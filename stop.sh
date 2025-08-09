#!/bin/bash

# Stop Script for Space Explorer
# Kills all running services

echo "🛑 Stopping Space Explorer Services"

# Kill Rails processes
echo "🔄 Stopping Rails server..."
pkill -f "rails server" 2>/dev/null || true
pkill -f "puma" 2>/dev/null || true

# Kill Node.js processes
echo "🔄 Stopping Node.js processes..."
pkill -f "next" 2>/dev/null || true
pkill -f "npm run dev" 2>/dev/null || true

# Kill by port
echo "🔄 Killing processes on ports 3000 and 3001..."
lsof -ti:3000 | xargs kill -9 2>/dev/null || true
lsof -ti:3001 | xargs kill -9 2>/dev/null || true

sleep 2

# Check if ports are free
if ! lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "✅ Port 3000 is free"
else
    echo "❌ Port 3000 is still in use"
fi

if ! lsof -Pi :3001 -sTCP:LISTEN -t >/dev/null 2>&1; then
    echo "✅ Port 3001 is free"
else
    echo "❌ Port 3001 is still in use"
fi

echo "✅ All services stopped!" 