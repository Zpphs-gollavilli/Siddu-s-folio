# Siddu's 3D Portfolio - Deployment Guide

Welcome! Your 3D portfolio with WebSocket backend is ready to deploy.

## 🚀 Quick Start (Choose One)

### Option 1: Visual Guide (Recommended for first time)
→ Open **`DEPLOY_NOW.md`** - Step-by-step with screenshots instructions

### Option 2: Track Your Progress
→ Open **`DEPLOYMENT_PROGRESS.md`** - Checklist to mark off as you go

### Option 3: Detailed Deep Dive
→ Open **`DEPLOYMENT_GUIDE.md`** - Complete technical details

## 📁 Project Structure

```
Siddu-s-folio/
├── backend/                    # WebSocket server (deploys to Railway)
│   ├── server.js
│   ├── package.json
│   ├── .env                    # Supabase credentials
│   ├── .env.example
│   └── Procfile               # Railway configuration ✨
│
├── Siddu-S-3D-World/          # Frontend (deploys to Vercel)
│   ├── src/
│   ├── package.json
│   ├── vite.config.js
│   ├── .env                   # Dev environment
│   ├── .env.production        # Prod environment ✨
│   └── .env.example
│
├── vercel.json                 # Vercel configuration ✨
├── DEPLOY_NOW.md              # 👈 Start here!
├── DEPLOYMENT_GUIDE.md        # Detailed guide
├── DEPLOYMENT_CHECKLIST.md    # Full checklist
├── TESTING_GUIDE.md           # Troubleshooting
└── scripts/
    └── deploy.sh              # Helper script

✨ = New files added for deployment
```

## 🎯 What Gets Deployed

### Backend → Railway
- **Framework:** Node.js WebSocket Server
- **Port:** Dynamic (Railway assigns via `PORT` env var)
- **Files:** Everything in `/backend`
- **URL Format:** `wss://your-app-name.up.railway.app`

### Frontend → Vercel
- **Framework:** Vite React
- **Build:** `npm run build` → `dist/` folder
- **Files:** Everything in `/Siddu-S-3D-World`
- **URL Format:** `https://your-project.vercel.app`

## ⚙️ Environment Variables

### Backend (.env in `/backend`)
```
PORT=3001                      # Railway will override
SUPABASE_URL=your-url
SUPABASE_KEY=your-key
```

### Frontend (.env in `/Siddu-S-3D-World`)
**Development:**
```
VITE_SERVER_URL=ws://localhost:3001
```

**Production (`.env.production`):**
```
VITE_SERVER_URL=wss://your-railway-domain.up.railway.app
```

## 🔄 Deployment Flow

```
Your Code (GitHub)
    ↓
    ├─→ Railway (Backend)
    │   └─→ WebSocket Server Running
    │
    └─→ Vercel (Frontend)
        └─→ Connects to Railway via env var
```

## 📝 Step-by-Step Overview

1. **Commit to GitHub** (1 minute)
   - `git add .`
   - `git commit -m "Deploy configuration"`
   - `git push origin host-websocket-server`

2. **Deploy Backend to Railway** (5 minutes)
   - Create project from GitHub
   - Select `/backend` directory
   - Get your Railway domain
   - Save it: `wss://your-domain.up.railway.app`

3. **Update Frontend Config** (1 minute)
   - Edit `Siddu-S-3D-World/.env.production`
   - Add Railway domain
   - Push to GitHub

4. **Deploy Frontend to Vercel** (5 minutes)
   - Create project from GitHub
   - Set root directory: `./Siddu-S-3D-World`
   - Add environment variables
   - Deploy!

5. **Test & Go Live** (2 minutes)
   - Open your Vercel URL
   - Check WebSocket connects
   - Share with the world!

**Total Time: ~20 minutes**

## 🧪 Testing After Deployment

### In Browser DevTools (F12)
1. Open Console tab
2. Look for: "WebSocket connected" ✅
3. Check for any errors ❌
4. Test 3D world loads

### More Detailed Testing
→ See `TESTING_GUIDE.md`

## 🆘 Need Help?

### Quick Issues
- **WebSocket not connecting?** → Check Railway domain is correct
- **Build errors on Vercel?** → Check root directory is `./Siddu-S-3D-World`
- **Can't find my Railway domain?** → Railway Dashboard → Your Project → Settings → Domains

### Full Troubleshooting
→ See `TESTING_GUIDE.md`

## 📚 Full Documentation

| Document | Purpose |
|----------|---------|
| **DEPLOY_NOW.md** | Step-by-step deployment (START HERE) |
| **DEPLOYMENT_GUIDE.md** | Detailed technical guide |
| **DEPLOYMENT_CHECKLIST.md** | Complete checklist to follow |
| **DEPLOYMENT_PROGRESS.md** | Track your progress |
| **TESTING_GUIDE.md** | Testing and troubleshooting |

## 🔗 Important Links

- **Railway Dashboard:** https://railway.app/dashboard
- **Vercel Dashboard:** https://vercel.com/dashboard
- **GitHub Repository:** https://github.com/Zpphs-gollavilli/Siddu-s-folio
- **Branch:** `host-websocket-server`

## ✅ Pre-Deployment Checklist

Before you start:
- [ ] You have a GitHub account
- [ ] You have Railway account (free tier available)
- [ ] You have Vercel account (linked to GitHub)
- [ ] All code is committed locally
- [ ] You're on branch: `host-websocket-server`

## 🎉 Ready?

**Start with `DEPLOY_NOW.md` and follow the steps!**

Your 3D portfolio will be live in ~20 minutes. Let's go! 🚀

---

*Last Updated: 2025*
*Branch: host-websocket-server*
*Status: Ready for deployment*
