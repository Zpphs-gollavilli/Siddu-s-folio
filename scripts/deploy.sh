#!/bin/bash

# Deployment script for Siddu's 3D World
# This script helps you deploy to Railway (backend) and Vercel (frontend)

echo "🚀 Starting deployment process..."
echo ""

# Step 1: Commit changes
echo "📝 Step 1: Committing changes to Git"
echo "Run: git add ."
echo "Run: git commit -m 'Deploy: Add Railway and Vercel configurations for 3D World'"
echo ""

# Step 2: Push to GitHub
echo "📤 Step 2: Pushing to GitHub"
echo "Run: git push origin host-websocket-server"
echo ""

# Step 3: Deploy Backend
echo "🔌 Step 3: Deploy Backend to Railway"
echo "Visit: https://railway.app"
echo "1. Sign up / Log in with GitHub"
echo "2. Create new project → Deploy from GitHub repo"
echo "3. Select: Zpphs-gollavilli/Siddu-s-folio"
echo "4. Select branch: host-websocket-server"
echo "5. Navigate to: /backend"
echo "6. Copy the live domain from Railway (e.g., wss://your-app.up.railway.app)"
echo ""

# Step 4: Update Frontend Config
echo "🔄 Step 4: Update Frontend Environment"
echo "Edit: Siddu-S-3D-World/.env.production"
echo "Replace VITE_SERVER_URL with your Railway domain"
echo "Example: VITE_SERVER_URL=wss://your-app-name.up.railway.app"
echo ""

# Step 5: Deploy Frontend
echo "🌐 Step 5: Deploy Frontend to Vercel"
echo "Visit: https://vercel.com"
echo "1. Import your GitHub project"
echo "2. Root directory: ./Siddu-S-3D-World"
echo "3. Add environment variables from .env.production"
echo "4. Deploy!"
echo ""

# Step 6: Test
echo "✅ Step 6: Test the Deployment"
echo "Open your Vercel domain and check:"
echo "1. WebSocket connects to Railway backend"
echo "2. 3D world loads correctly"
echo "3. Real-time updates work"
echo ""

echo "📚 For detailed instructions, see:"
echo "   - QUICK_START.md (5-step overview)"
echo "   - DEPLOYMENT_GUIDE.md (detailed steps)"
echo "   - TESTING_GUIDE.md (comprehensive testing)"
