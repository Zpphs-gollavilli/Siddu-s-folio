# Quick Start: Deploy Your Portfolio in 5 Steps

**Time Required**: ~20 minutes  
**Prerequisites**: GitHub, Railway, and Vercel accounts

---

## Step 1: Get Your Railway WebSocket URL (5 min)

1. Go to [railway.app](https://railway.app)
2. Click "Create New" → "Project from Repo"
3. Select `Zpphs-gollavilli/Siddu-s-folio`
4. Add environment variables:
   - `SUPABASE_URL`: `https://chbnesjhzhwcsvqlxrhz.supabase.co`
   - `SUPABASE_SERVICE_ROLE_KEY`: (from `backend/.env`)
5. Deploy and copy your Railway domain: `xxxx.up.railway.app`
6. Your WebSocket URL: `wss://xxxx.up.railway.app`

---

## Step 2: Update Frontend Config (2 min)

1. Edit `Siddu-S-3D-World/.env.production`
2. Replace `RAILWAY_DOMAIN` with your Railway domain
3. Commit and push to GitHub

```env
# Example:
VITE_SERVER_URL=wss://my-portfolio.up.railway.app
```

---

## Step 3: Deploy to Vercel (5 min)

1. Go to [vercel.com](https://vercel.com)
2. Click "Add New" → "Project"
3. Import `Zpphs-gollavilli/Siddu-s-folio`
4. Configure:
   - **Root Directory**: `Siddu-S-3D-World`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`

---

## Step 4: Add Environment Variable (2 min)

1. In Vercel, go to "Environment Variables"
2. Add:
   - Name: `VITE_SERVER_URL`
   - Value: `wss://your-railway-domain.up.railway.app`
   - Environments: Production, Preview, Development
3. Click "Deploy"

---

## Step 5: Test Your Site (3 min)

1. Wait for deployment to complete
2. Visit your URL: `https://your-project.vercel.app`
3. Open DevTools (F12) → Console
4. Check for WebSocket connection messages
5. Test interactive features

---

## Links You'll Need

| Service | URL | Action |
|---------|-----|--------|
| Railway | https://railway.app | Deploy backend |
| Vercel | https://vercel.com | Deploy frontend |
| GitHub | GitHub Settings | Connect repos |
| Repository | https://github.com/Zpphs-gollavilli/Siddu-s-folio | Your code |

---

## Environment Variables Reference

### Backend (`backend/.env`) - Already configured
```
SUPABASE_URL=https://chbnesjhzhwcsvqlxrhz.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...
```

### Frontend Production (`Siddu-S-3D-World/.env.production`)
```
VITE_SERVER_URL=wss://RAILWAY_DOMAIN.up.railway.app
```

---

## Troubleshooting Quick Fixes

**Backend won't start?**
- Check Supabase credentials are correct
- Look at Railway logs for errors

**Frontend won't connect?**
- Use `wss://` not `ws://`
- Check Vercel environment variables
- Look at browser console for WebSocket errors

**Build fails?**
- Check root directory is `Siddu-S-3D-World`
- Verify all packages in `package.json`
- Check Vercel build logs

---

## After Deployment ✓

- Your portfolio is now live!
- Share your URL on social media
- Monitor both dashboards for errors
- Update code and it auto-deploys

**Need more help?** See `DEPLOYMENT_GUIDE.md` for detailed instructions.
