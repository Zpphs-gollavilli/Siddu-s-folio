#!/bin/bash

# DEPLOYMENT COMMANDS CHEATSHEET
# Copy and paste these commands as you deploy

# ============================================================================
# STEP 1: PUSH TO GITHUB
# ============================================================================

git add .
git commit -m "Deploy: Add Railway and Vercel configurations"
git push origin host-websocket-server

# ============================================================================
# STEP 2: RAILWAY BACKEND DEPLOYMENT
# ============================================================================

# 1. Go to: https://railway.app
# 2. Click: New Project → Deploy from GitHub repo
# 3. Select: Zpphs-gollavilli/Siddu-s-folio
# 4. Select branch: host-websocket-server
# 5. When asked, set root directory to: /backend
# 6. Railway auto-deploys
# 7. Wait for green checkmark ✓
# 8. Go to Settings → Domains → Generate Domain
# 9. Copy your Railway domain (looks like: wss://app-name.up.railway.app)

# ============================================================================
# STEP 3: UPDATE FRONTEND CONFIG
# ============================================================================

# Edit the file: Siddu-S-3D-World/.env.production
# Replace the URL with your Railway domain:
# VITE_SERVER_URL=wss://your-railway-domain.up.railway.app

# Then push to GitHub:

git add Siddu-S-3D-World/.env.production
git commit -m "Update: Production WebSocket URL for Railway"
git push origin host-websocket-server

# ============================================================================
# STEP 4: VERCEL FRONTEND DEPLOYMENT
# ============================================================================

# 1. Go to: https://vercel.com/dashboard
# 2. Click: Add New → Project
# 3. Click: Import Git Repository
# 4. Select: Zpphs-gollavilli/Siddu-s-folio
# 5. Configure Project:
#    - Framework: Vite
#    - Root Directory: ./Siddu-S-3D-World
#    - Build Command: npm run build
#    - Output Directory: dist
# 6. Add Environment Variables:
#    - Name: VITE_SERVER_URL
#    - Value: wss://your-railway-domain.up.railway.app
# 7. Click: Deploy
# 8. Wait for green checkmark ✓

# ============================================================================
# STEP 5: TEST DEPLOYMENT
# ============================================================================

# 1. Open your Vercel domain in browser: https://your-domain.vercel.app
# 2. Open DevTools: F12
# 3. Go to Console tab
# 4. Look for: "WebSocket connected" ✓
# 5. Check for any errors ✗
# 6. Test 3D world loads and works

# ============================================================================
# VERIFICATION COMMANDS (Run locally to verify setup)
# ============================================================================

# Check git status
git status

# View current branch
git branch

# Check backend .env file exists
test -f backend/.env && echo "✓ Backend .env exists" || echo "✗ Backend .env missing"

# Check frontend .env file exists
test -f Siddu-S-3D-World/.env && echo "✓ Frontend .env exists" || echo "✗ Frontend .env missing"

# Check Procfile exists
test -f backend/Procfile && echo "✓ Procfile exists" || echo "✗ Procfile missing"

# Check vercel.json exists
test -f vercel.json && echo "✓ vercel.json exists" || echo "✗ vercel.json missing"

# ============================================================================
# USEFUL LINKS
# ============================================================================

# Railway Dashboard:     https://railway.app/dashboard
# Vercel Dashboard:      https://vercel.com/dashboard
# Your GitHub Repo:      https://github.com/Zpphs-gollavilli/Siddu-s-folio
# Your Branch:           https://github.com/Zpphs-gollavilli/Siddu-s-folio/tree/host-websocket-server

# ============================================================================
# DEBUGGING COMMANDS
# ============================================================================

# Check if backend port is set correctly
grep -n "PORT\|port" backend/server.js | head -5

# Check if frontend uses env variable
grep -n "VITE_SERVER_URL" Siddu-S-3D-World/sources/Game/Server.js

# List all env files
echo "Environment files:"
find . -name ".env*" -type f 2>/dev/null | grep -v node_modules

# Show current git log
git log --oneline -5

# ============================================================================
# AFTER DEPLOYMENT - MONITORING
# ============================================================================

# Monitor Railway logs
# 1. Go to: https://railway.app/dashboard
# 2. Select your project
# 3. Click: Deployments → View Logs
# 4. Look for: "WebSocket server running"

# Monitor Vercel logs
# 1. Go to: https://vercel.com/dashboard
# 2. Select your project
# 3. Click: Deployments → Your deployment → Logs
# 4. Look for: Build successful

# ============================================================================
# ENVIRONMENT VARIABLES TO SAVE
# ============================================================================

# After deployment, save these:
# 
# Railway Backend Domain:
# wss://___________________________________
#
# Vercel Frontend URL:
# https://___________________________________
#
# Supabase URL (already in .env):
# https://___________________________________
#
# Supabase Key (already in .env):
# (keep this secret!)

# ============================================================================
# COMMON ISSUES & FIXES
# ============================================================================

# Issue: WebSocket not connecting
# Fix 1: Verify Railway domain is correct in .env.production
# Fix 2: Check Railway is running (see dashboard)
# Fix 3: Verify Vercel has env variable set
# Command: Check Vercel settings → Environment Variables

# Issue: Build fails on Vercel
# Fix 1: Verify root directory is ./Siddu-S-3D-World
# Fix 2: Check build command is: npm run build
# Fix 3: Check dependencies are installed
# Command: npm install in root directory

# Issue: 3D models not loading
# Fix 1: Check Vercel build logs
# Fix 2: Verify all assets are in /public folder
# Fix 3: Check console for 404 errors
# Command: F12 in browser → Console

# ============================================================================
# COMPLETE CHECKLIST
# ============================================================================

# [ ] Read: INDEX.md or DEPLOY_NOW.md
# [ ] Run: git push origin host-websocket-server
# [ ] Deploy backend to Railway
# [ ] Copy Railway domain
# [ ] Edit: Siddu-S-3D-World/.env.production
# [ ] Run: git push (update frontend config)
# [ ] Deploy frontend to Vercel
# [ ] Add env variable to Vercel
# [ ] Wait for deployment (green checkmarks)
# [ ] Test in browser
# [ ] Check WebSocket in console
# [ ] Verify 3D world works
# [ ] Share your portfolio!

# ============================================================================
# THAT'S IT! YOU'RE DONE! 🎉
# ============================================================================
