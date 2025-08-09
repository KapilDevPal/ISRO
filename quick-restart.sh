#!/bin/bash

# Quick Restart Script for Space Explorer
# Simple script to kill and restart services quickly

echo "🚀 Quick Restart - Space Explorer"

# Kill processes on ports
echo "🛑 Killing processes on ports 3000 and 3001..."
pkill -f "rails server" 2>/dev/null || true
pkill -f "next" 2>/dev/null || true
pkill -f "npm run dev" 2>/dev/null || true

# Kill by port if still running
lsof -ti:3000 | xargs kill -9 2>/dev/null || true
lsof -ti:3001 | xargs kill -9 2>/dev/null || true

sleep 2

# Start backend
echo "🚀 Starting Rails backend..."
cd backend
rails server -p 3001 -d
cd ..

# Start frontend
echo "🚀 Starting Next.js frontend..."
cd frontend
npm run dev &
cd ..

echo "✅ Services restarted!"
echo "   Frontend: http://localhost:3000"
echo "   Backend: http://localhost:3001"
echo ""
echo "Press Ctrl+C to stop" 