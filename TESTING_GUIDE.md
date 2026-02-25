# Testing Guide: Verify Your Deployment

After deploying to Railway and Vercel, use this guide to test all components.

---

## Before Testing

- [ ] Backend deployed to Railway (check Railway dashboard)
- [ ] Frontend deployed to Vercel (check Vercel dashboard)
- [ ] Frontend environment variables set correctly
- [ ] At least 5 minutes have passed since deployment

---

## Test 1: Basic Site Loading

### Steps:
1. Open your Vercel URL in a fresh browser tab
2. Wait for the 3D world to fully load (30-60 seconds)
3. Look for the 3D environment to render

### Expected Results:
- [ ] Page loads without errors
- [ ] 3D scene renders and is visible
- [ ] No blank/white screen
- [ ] No "Cannot connect to server" error on load

### If It Fails:
- Check browser console (F12) for errors
- Verify Vercel deployment completed successfully
- Clear browser cache and retry
- Check that static assets are loading (Network tab)

---

## Test 2: WebSocket Connection

### Steps:
1. Open DevTools: Press `F12`
2. Go to "Console" tab
3. Watch for connection messages
4. Look for any WebSocket-related logs

### Expected Results:
- [ ] No "Connection refused" messages
- [ ] Server connection status shows "online" or "connected"
- [ ] CSS class `is-server-online` is applied to `<html>` element
- [ ] No WebSocket errors in console

### Check Connection Status:
Open console and run:
```javascript
document.documentElement.className
```

You should see a class containing `is-server-online` if connected.

### If It Fails:
- Check browser console for specific WebSocket errors
- Verify VITE_SERVER_URL environment variable in Vercel
- Confirm Railway service is running (check Railway logs)
- Ensure WebSocket URL uses `wss://` not `ws://`
- Check that Railway domain is correct

---

## Test 3: Network Tab Inspection

### Steps:
1. Open DevTools: Press `F12`
2. Go to "Network" tab
3. Filter by "WS" (WebSocket filter icon)
4. Reload the page

### Expected Results:
- [ ] One or more WebSocket connections listed
- [ ] Status should be "101 Switching Protocols" (green)
- [ ] URL starts with `wss://` (secure WebSocket)
- [ ] Connection stays open (doesn't show red X)

### Example WebSocket Entry:
```
wss://your-railway-domain.up.railway.app/
Method: GET
Status: 101 Switching Protocols
Type: websocket
Size: 0 B
```

### If It Fails:
- Red X on WebSocket = connection failed
- 403/404 errors = wrong URL
- Check Railway service logs for errors
- Verify firewall allows WebSocket connections

---

## Test 4: Real-time Features

Depending on your implementation, test these features that require WebSocket:

### Whisper System (If Implemented)
- [ ] Click on areas to send whispers
- [ ] Whispers appear on screen immediately
- [ ] Check console for "whispersInsert" messages

### Cookie Counter (If Implemented)
- [ ] Click cookie elements
- [ ] Counter updates in real-time
- [ ] Other users see the updated count
- [ ] Check for "cookiesUpdate" messages in console

### Circuit/Leaderboard (If Implemented)
- [ ] Leaderboard displays correctly
- [ ] Times are current
- [ ] Check for "circuitUpdate" messages

### Message Events
Open console and look for patterns like:
```
{type: 'whispersInsert', whispers: [...]}
{type: 'cookiesUpdate', total: 123}
{type: 'circuitUpdate', circuitLeaderboard: [...]}
```

### If Features Don't Work:
- Check that Supabase is configured correctly
- Verify database tables exist (query Supabase directly)
- Check Railway logs for database errors
- Ensure your Supabase service role key is valid

---

## Test 5: Performance Checks

### Check Load Time
1. Open DevTools → Network tab
2. Reload page (Ctrl+Shift+R for hard refresh)
3. Note the "DOMContentLoaded" time (should be < 3s)
4. Note the "Load" time for full page

### Expected Performance:
- [ ] DOMContentLoaded: < 3 seconds
- [ ] Full Load: < 10 seconds
- [ ] 3D scene interactive after < 5 seconds
- [ ] No significant jank while navigating

### Check Asset Loading
1. Network tab → Filter by "Img" for images
2. Check that textures load successfully
3. Check for 404 errors on assets
4. Monitor for slow-loading files

### If Performance is Poor:
- Check Vercel deployment region (dashboard settings)
- Verify assets are optimized (compression)
- Check Railway service performance
- Look for large uncompressed files
- Monitor browser's main thread (Performance tab)

---

## Test 6: Error Handling

### Test Connection Loss
1. Disconnect internet or throttle connection
2. Watch for graceful degradation
3. Look for "Server disconnected" notification
4. CSS class should change to `is-server-offline`

### Expected Behavior:
- [ ] Graceful disconnect notification appears
- [ ] App doesn't crash
- [ ] Reconnection attempts visible in console
- [ ] Connection status updates when back online

### Test With DevTools
1. Open DevTools → Network tab
2. Set throttling to "Offline"
3. Refresh page
4. Observe connection behavior
5. Re-enable and watch reconnection

### If Error Handling Fails:
- Check that error notifications display
- Verify reconnection logic works
- Check console for unhandled errors
- Test with actual offline mode

---

## Test 7: Cross-Browser Testing

Test on multiple browsers:

### Desktop Browsers:
- [ ] Chrome/Chromium
- [ ] Firefox
- [ ] Safari
- [ ] Edge

### Mobile Browsers:
- [ ] Chrome Mobile
- [ ] Safari Mobile
- [ ] Firefox Mobile

### For Each Browser Check:
- [ ] Page loads
- [ ] 3D renders correctly
- [ ] WebSocket connects
- [ ] No console errors
- [ ] Touch controls work (if applicable)

### If Issues on Specific Browser:
- Check browser compatibility
- Look for polyfill issues
- Verify WebGL support
- Check console for specific errors

---

## Test 8: Mobile Testing

### Steps:
1. Get your Vercel URL
2. Open on mobile device
3. Check performance and functionality

### Mobile Checks:
- [ ] Page loads on mobile network
- [ ] 3D scene renders (check GPU capability)
- [ ] Touch controls work properly
- [ ] No zoom issues
- [ ] Responsive layout (if applicable)
- [ ] WebSocket connects on mobile network

### Known Mobile Issues:
- Some mobile devices may have weak WebGL support
- Battery drain from 3D rendering
- Mobile networks might be slower
- Touch event handling differences

---

## Test 9: Monitor Production

### Daily Monitoring:
- [ ] Check Vercel dashboard for build errors
- [ ] Check Railway logs for runtime errors
- [ ] Monitor Supabase for database issues
- [ ] Watch for performance degradation

### Set Up Alerts:
1. **Vercel**: Enable email alerts for deployments
2. **Railway**: Enable deployment notifications
3. **Supabase**: Monitor quota usage

### Check Logs
1. **Vercel**: Deployments → Select deployment → View logs
2. **Railway**: Logs tab in service dashboard
3. **Supabase**: Logs in database settings

---

## Test 10: Load Testing (Optional)

If you want to stress test:

### Simple Load Test:
1. Open the same page in 5+ browser tabs
2. Interact with features simultaneously
3. Watch for server errors or disconnections
4. Monitor server resource usage in Railway

### What to Expect:
- Server should handle 5+ concurrent connections
- No cascading failures
- Graceful degradation under heavy load
- Memory usage stays reasonable

---

## Verification Checklist

After all tests pass, verify:

- [ ] WebSocket connects on page load
- [ ] Real-time features work
- [ ] No console errors
- [ ] Performance is acceptable
- [ ] Mobile works (if applicable)
- [ ] Error handling works
- [ ] Cross-browser compatible
- [ ] Server logs are clean
- [ ] No database errors
- [ ] Site is publicly accessible

---

## Issue Resolution Flowchart

```
Is the 3D world loading?
├─ NO
│  ├─ Check browser console for JavaScript errors
│  ├─ Verify assets loading (Network tab)
│  └─ Check Vercel deployment logs
└─ YES
   Is WebSocket connected?
   ├─ NO
   │  ├─ Check Network tab for WebSocket failures
   │  ├─ Verify VITE_SERVER_URL is correct
   │  ├─ Check Railway service is running
   │  └─ Check browser console for connection errors
   └─ YES
      Are real-time features working?
      ├─ NO
      │  ├─ Check Supabase database has data
      │  ├─ Check Railway logs for errors
      │  └─ Verify Supabase credentials
      └─ YES
         Deployment successful!
```

---

## Support Resources

- **Railway Docs**: https://docs.railway.app
- **Vercel Docs**: https://vercel.com/docs
- **WebSocket API**: https://developer.mozilla.org/en-US/docs/Web/API/WebSocket
- **Supabase Docs**: https://supabase.com/docs
- **Three.js Docs**: https://threejs.org/docs

---

## Final Checklist

- [ ] Site is publicly accessible
- [ ] WebSocket connects
- [ ] Real-time features work
- [ ] No critical errors
- [ ] Performance is good
- [ ] Mobile works (optional)
- [ ] Monitoring is set up
- [ ] Team members can access the site

**If all checks pass, your deployment is successful!**
