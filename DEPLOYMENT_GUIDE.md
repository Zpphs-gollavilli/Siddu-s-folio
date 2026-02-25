# Deployment Guide - Siddu's 3D Portfolio

This guide explains how to deploy your WebSocket backend to Railway and your 3D portfolio frontend to Vercel.

## Part 1: Deploy Backend to Railway ✈️

### Step 1: Prepare Your Repository
1. Make sure all changes are committed and pushed to GitHub
2. The backend code is in the `/backend` folder with `server.js`

### Step 2: Create Railway Account
1. Go to [railway.app](https://railway.app)
2. Sign up with GitHub (recommended for easier integration)
3. Create a new project

### Step 3: Connect Repository to Railway
1. Click "Create New" → "Project from Repo"
2. Select your repository `Siddu-s-folio`
3. Choose the repository and confirm

### Step 4: Configure Environment Variables
1. In Railway dashboard, go to "Variables"
2. Add these environment variables:
   - `SUPABASE_URL`: Your Supabase project URL
   - `SUPABASE_SERVICE_ROLE_KEY`: Your Supabase service role key
   - `PORT`: Leave empty (Railway assigns this automatically)

### Step 5: Configure Build Settings
1. Go to "Settings" in your Railway service
2. Set "Start Command": `node backend/server.js`
3. Set "Build Command": (leave empty, no build needed)
4. Make sure the root directory is set to `/` (project root)

### Step 6: Deploy
1. Railway will automatically deploy on git push
2. Once deployed, you'll get a public URL like: `railway-app-production.up.railway.app`
3. Your WebSocket URL will be: `wss://railway-app-production.up.railway.app` (note: `wss://` for secure WebSocket)

### Step 7: Get Your Public WebSocket URL
1. Go to Railway dashboard → Your Service
2. Look for "Public URL" or "Domains"
3. Copy your domain (e.g., `railway-app-production.up.railway.app`)
4. Your WebSocket URL: `wss://railway-app-production.up.railway.app`

---

## Part 2: Deploy Frontend to Vercel 🚀

### Step 1: Prepare Frontend Configuration
1. Update `.env.production` in `Siddu-S-3D-World/` with your Railway WebSocket URL:
   ```
   VITE_SERVER_URL=wss://your-railway-domain.up.railway.app
   ```

### Step 2: Create Vercel Account
1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub
3. Import your repository

### Step 3: Import Project to Vercel
1. Click "New Project"
2. Select your `Siddu-s-folio` repository
3. Configure project settings

### Step 4: Configure Build Settings
1. **Root Directory**: `Siddu-S-3D-World`
2. **Build Command**: `npm run build`
3. **Output Directory**: `dist`

### Step 5: Set Environment Variables
1. In Vercel dashboard, go to "Settings" → "Environment Variables"
2. Add:
   - Name: `VITE_SERVER_URL`
   - Value: `wss://your-railway-domain.up.railway.app` (your Railway WebSocket URL)
   - Environments: Production, Preview, Development

### Step 6: Deploy
1. Click "Deploy"
2. Vercel will build and deploy automatically
3. Your site will be live at `your-project.vercel.app`

---

## Step 7: Test the Full Integration

1. Visit your Vercel deployment: `https://your-project.vercel.app`
2. Open browser DevTools (F12) → Console
3. You should see: `WebSocket server running on port 3001` OR connection status
4. Check for any WebSocket connection errors
5. Test the interactive features that require server connection

---

## Troubleshooting

### Backend not connecting
- Check Railway logs for errors
- Verify all Supabase credentials are correct
- Ensure service is running (check Railway dashboard)
- Check CORS/origin headers if needed

### WebSocket Connection Issues
- Make sure you're using `wss://` (secure WebSocket) not `ws://`
- Verify the Railway domain is correct
- Check browser console for connection errors
- Railway might need SSL certificate setup (usually automatic)

### Build Fails on Vercel
- Check build logs in Vercel dashboard
- Ensure all dependencies are in `package.json`
- Verify build output path matches `Siddu-S-3D-World/dist`

### After Deploying
- Update `VITE_SERVER_URL` in production immediately if not already set
- Monitor Railway and Vercel dashboards for errors
- Set up email alerts for deployment failures

---

## Environment Variables Quick Reference

### Backend (`backend/.env`)
```
SUPABASE_URL=https://xxx.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...
PORT=3001 (set by Railway)
```

### Frontend (`Siddu-S-3D-World/.env.production`)
```
VITE_SERVER_URL=wss://your-railway-domain.up.railway.app
```

---

## Next Steps After Deployment

1. **Monitor**: Set up error tracking with Sentry or similar
2. **Performance**: Use Vercel Analytics to track performance
3. **Database**: Monitor Supabase for performance issues
4. **Updates**: Update dependencies regularly
5. **Testing**: Test all interactive features regularly

---

Need help? Check out:
- Railway Docs: https://docs.railway.app
- Vercel Docs: https://vercel.com/docs
- WebSocket: https://developer.mozilla.org/en-US/docs/Web/API/WebSocket
