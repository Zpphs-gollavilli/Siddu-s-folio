import 'dotenv/config'
import { WebSocketServer } from 'ws'
import msgpack from 'msgpack-lite'
import { createClient } from '@supabase/supabase-js'

/* ----------------------------------------
   WebSocket
---------------------------------------- */

const PORT = process.env.PORT || 3001
const wss = new WebSocketServer({ port: PORT })
console.log(`WebSocket server running on port ${PORT}`)

/* ----------------------------------------
   Supabase
---------------------------------------- */

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
)

/* ----------------------------------------
   Helpers
---------------------------------------- */

function broadcast(obj)
{
  const buf = msgpack.encode(obj)

  wss.clients.forEach(c =>
  {
    if (c.readyState === 1)
      c.send(buf)
  })
}

/* ----------------------------------------
   Circuit Leaderboard Helpers
---------------------------------------- */

async function getCircuitLeaderboard()
{
  const { data, error } = await supabase
    .from('circuit_runs')
    .select('tag, country_code, duration')
    .order('duration', { ascending: true })
    .limit(10)

  if (error)
  {
    console.error('Leaderboard fetch error', error)
    return []
  }

  return data.map(r => [
    r.tag,
    r.country_code,
    r.duration
  ])
}

function getResetTime()
{
  // Simple daily reset (midnight UTC)
  const now = new Date()
  const tomorrow = new Date(Date.UTC(
    now.getUTCFullYear(),
    now.getUTCMonth(),
    now.getUTCDate() + 1,
    0, 0, 0
  ))

  return tomorrow.getTime()
}

/* ----------------------------------------
   Send initial whispers
---------------------------------------- */

async function sendInit(ws)
{
  const { data, error } = await supabase
    .from('whispers')
    .select('id, message, country_code, x, y, z')
    .order('created_at', { ascending: false })
    .limit(200)

  if (error)
  {
    console.error('Init load error', error)
    return
  }

  const whispers = data.map(w => ({
    id: w.id,
    message: w.message,
    countrycode: w.country_code,
    x: w.x,
    y: w.y,
    z: w.z
  }))

  ws.send(msgpack.encode({
    type: 'init',
    whispers
  }))
}

/* ----------------------------------------
   Send current global counters
---------------------------------------- */

async function sendCurrentGlobals(ws)
{
  const { data, error } = await supabase
    .from('global_counters')
    .select('cookies, altar')
    .eq('id', 1)
    .single()

  if (error)
  {
    console.error('Failed loading global counters', error)
    return
  }

  ws.send(msgpack.encode({
    type: 'globalsInit',
    cookies: data.cookies,
    altar: data.altar
  }))
}

/* ----------------------------------------
   Send circuit data
---------------------------------------- */

async function sendCircuitData(ws)
{
  const leaderboard = await getCircuitLeaderboard()

  ws.send(msgpack.encode({
    type: 'init',
    circuitLeaderboard: leaderboard,
    circuitResetTime: getResetTime()
  }))
}

/* ----------------------------------------
   Main socket
---------------------------------------- */

wss.on('connection', async (ws) =>
{
  await sendInit(ws)
  await sendCurrentGlobals(ws)
  await sendCircuitData(ws)

  ws.on('message', async (buffer) =>
  {
    let data

    try
    {
      data = msgpack.decode(new Uint8Array(buffer))
    }
    catch
    {
      console.error('Invalid msgpack packet')
      return
    }

    console.log('Received:', data)

    try
    {
      switch (data.type)
      {
        case 'whispersInsert':
          await insertWhisper(data)
          break

        case 'cookiesInsert':
          await addCookies(data.amount || 1)
          break

        case 'cataclysmInsert':
          await consumeAltar()
          break

        case 'circuitInsert':
          await insertCircuitRun(data)
          break
      }
    }
    catch (err)
    {
      console.error('DB error', err)
    }
  })
})

/* ----------------------------------------
   DB operations
---------------------------------------- */

async function insertWhisper(d)
{
  const { data, error } = await supabase
    .from('whispers')
    .insert({
      uuid: d.uuid,
      message: d.message,
      country_code: d.countryCode,
      x: d.x,
      y: d.y,
      z: d.z
    })
    .select('id, message, country_code, x, y, z')
    .single()

  if (error) throw error

  const whisper = {
    id: data.id,
    message: data.message,
    countrycode: data.country_code,
    x: data.x,
    y: data.y,
    z: data.z
  }

  broadcast({
    type: 'whispersInsert',
    whispers: [ whisper ]
  })
}

async function addCookies(amount)
{
  const { data, error } = await supabase.rpc(
    'increment_cookies',
    { p_amount: amount }
  )

  if (error) throw error

  broadcast({
    type: 'cookiesUpdate',
    total: data
  })
}

async function consumeAltar()
{
  const { data, error } = await supabase.rpc('decrement_altar')

  if (error) throw error

  broadcast({
    type: 'altarUpdate',
    total: data
  })
}

/* -------- circuit run storage -------- */

async function insertCircuitRun(d)
{
  const duration =
    d.duration ??
    d.duration_ms ??
    d.time ??
    null

  if (duration === null)
  {
    console.error('Missing duration in circuitInsert:', d)
    return
  }

  const { error } = await supabase
    .from('circuit_runs')
    .insert({
      uuid: d.uuid,
      country_code: d.countryCode,
      tag: d.tag,
      duration: duration,
      checkpoint_timings: d.checkpointTimings ?? []
    })

  if (error) throw error

  // After insert → fetch updated leaderboard
  const leaderboard = await getCircuitLeaderboard()

  broadcast({
    type: 'circuitUpdate',
    circuitLeaderboard: leaderboard
  })
}
