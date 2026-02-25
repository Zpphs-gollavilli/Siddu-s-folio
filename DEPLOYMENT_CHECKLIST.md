# Deployment Checklist for Siddu's 3D Portfolio

Complete this checklist to deploy your project successfully to Railway (backend) and Vercel (frontend).

## Pre-Deployment Setup

- [ ] All code is committed and pushed to GitHub branch `main` or your working branch
- [ ] You have a GitHub account connected to Railway and Vercel
- [ ] You have Supabase credentials ready (URL and Service Role Key)

## Step 1: Deploy Backend to Railway

### 1.1 Create Railway Account & Project
- [ ] Go to https://railway.app
- [ ] Sign up with GitHub
- [ ] Create a new project

### 1.2 Connect Your Repository
- [ ] Click "Create New" → "Project from Repo"
- [ ] Select `Zpphs-gollavilli/Siddu-s-folio` repository
- [ ] Authorize Railway to access your GitHub

### 1.3 Configure Railway Service
- [ ] In Railway, select "Create from existing repo"
- [ ] Service should be detected as Node.js
- [ ] Set Service Root: `/backend` (if not auto-detected)

### 1.4 Set Environment Variables
Copy the values from `/backend/.env` file:
- [ ] `SUPABASE_URL`: `https://chbnesjhzhwcsvqlxrhz.supabase.co`
- [ ] `SUPABASE_SERVICE_ROLE_KEY`: (copy the full key from your .env file)

### 1.5 Configure Start Command
- [ ] In Railway settings, set Start Command: `node server.js`
- [ ] Leave Build Command empty

### 1.6 Deploy Backend
- [ ] Click "Deploy" button
- [ ] Wait for deployment to complete (2-5 minutes)
- [ ] Check logs for errors: look for "WebSocket server running on port"
- [ ] Copy your Railway public URL (e.g., `your-service.up.railway.app`)

### 1.7 Get WebSocket URL
- [ ] Your WebSocket URL is: `wss://your-service.up.railway.app`
- [ ] Save this URL - you'll need it for the frontend

## Step 2: Deploy Frontend to Vercel

### 2.1 Update Frontend Environment
Before deploying, update the WebSocket URL:
- [ ] Open `Siddu-S-3D-World/.env.production`
- [ ] Replace `RAILWAY_DOMAIN` with your actual Railway domain from Step 1.7
- [ ] Example: `wss://my-portfolio-backend.up.railway.app`
- [ ] Commit and push changes to GitHub

### 2.2 Create Vercel Account & Import Project
- [ ] Go to https://vercel.com
- [ ] Sign up with GitHub
- [ ] Click "Add New..." → "Project"
- [ ] Select `Zpphs-gollavilli/Siddu-s-folio`

### 2.3 Configure Build Settings
- [ ] Root Directory: `Siddu-S-3D-World`
- [ ] Build Command: `npm run build`
- [ ] Output Directory: `dist`

### 2.4 Set Environment Variables
- [ ] Click "Environment Variables"
- [ ] Add new variable:
  - Name: `VITE_SERVER_URL`
  - Value: `wss://your-railway-domain.up.railway.app` (from Step 1.7)
  - Environments: Select all (Production, Preview, Development)
- [ ] Click "Add"

### 2.5 Deploy Frontend
- [ ] Click "Deploy" button
- [ ] Wait for build and deployment (3-10 minutes)
- [ ] Check the Deployment status page
- [ ] Your site URL will be shown (e.g., `your-project.vercel.app`)

## Step 3: Test Integration

### 3.1 Visit Your Live Site
- [ ] Open your Vercel deployment URL in browser: `https://your-project.vercel.app`
- [ ] Wait for the 3D world to load

### 3.2 Check WebSocket Connection
- [ ] Open Browser DevTools: Press `F12`
- [ ] Go to "Console" tab
- [ ] Look for connection status messages
- [ ] Check "Network" tab → filter by "WS" to see WebSocket connections

### 3.3 Test Interactive Features
- [ ] Navigate around the 3D world
- [ ] Test features that require server connection:
  - [ ] Whisper system (if enabled)
  - [ ] Cookie counter
  - [ ] Circuit leaderboard
  - [ ] Any multiplayer features

### 3.4 Check for Errors
- [ ] Console should show minimal errors
- [ ] No red error messages about "Connection refused"
- [ ] Network tab shouldn't show failed WebSocket connections

## Step 4: Production Setup

### 4.1 Monitor Services
- [ ] Enable Railway email alerts for deployments
- [ ] Enable Vercel analytics: Dashboard → Analytics
- [ ] Set up error tracking (optional): Sentry.io

### 4.2 Update DNS (Optional)
- [ ] If using custom domain, point to Vercel
- [ ] Vercel will provide CNAME records
- [ ] Add to your domain registrar

### 4.3 Monitor Performance
- [ ] Check Vercel Analytics regularly
- [ ] Monitor Railway logs for errors
- [ ] Check Supabase for database performance

## Troubleshooting

### Backend not starting on Railway
- [ ] Check Railway logs for error messages
- [ ] Verify Supabase credentials are correct
- [ ] Ensure `PORT` environment variable isn't conflicting
- [ ] Check that `backend/server.js` exists

### Frontend won't connect to backend
- [ ] Verify `VITE_SERVER_URL` is correct (use `wss://` not `ws://`)
- [ ] Check browser console for WebSocket errors
- [ ] Ensure Railway service is running
- [ ] Verify firewall allows WebSocket connections

### Build fails on Vercel
- [ ] Check Vercel build logs for specific errors
- [ ] Verify all dependencies are in `package.json`
- [ ] Ensure root directory is set to `Siddu-S-3D-World`
- [ ] Try rebuilding from dashboard

### 3D world not loading
- [ ] Check browser console for asset loading errors
- [ ] Verify static files are being served
- [ ] Check that textures and models load correctly
- [ ] Try clearing browser cache

## Quick Links

- **Railway Dashboard**: https://railway.app/dashboard
- **Vercel Dashboard**: https://vercel.com/dashboard
- **Supabase Console**: https://app.supabase.com
- **This Repository**: https://github.com/Zpphs-gollavilli/Siddu-s-folio

## After Successful Deployment

1. **Share your URL**: Your website is now live at `https://your-project.vercel.app`
2. **Update social links**: Share your portfolio across your social media
3. **Monitor**: Check dashboards daily for the first week
4. **Feedback**: Test all features and gather feedback from users
5. **Updates**: Make code changes and they'll auto-deploy to both services

---

**Estimated Time**: 20-30 minutes for complete deployment

**Questions?** Check the DEPLOYMENT_GUIDE.md for detailed instructions.
