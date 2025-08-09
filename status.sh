#!/bin/bash

# Status Script for Space Explorer
# Shows the current status of all services

echo "🚀 Space Explorer - Service Status"
echo "=================================="

# Check backend
echo "🔍 Checking Backend (Rails API)..."
if curl -s http://localhost:3001/up >/dev/null 2>&1; then
    echo "✅ Backend is running on port 3001"
    
    # Test API endpoints
    echo "   Testing API endpoints..."
    
    # Dashboard
    if curl -s http://localhost:3001/api/v1/dashboard >/dev/null 2>&1; then
        echo "   ✅ Dashboard API working"
    else
        echo "   ❌ Dashboard API failed"
    fi
    
    # Launches
    if curl -s http://localhost:3001/api/v1/launches >/dev/null 2>&1; then
        echo "   ✅ Launches API working"
    else
        echo "   ❌ Launches API failed"
    fi
    
    # Rockets
    if curl -s http://localhost:3001/api/v1/rockets >/dev/null 2>&1; then
        echo "   ✅ Rockets API working"
    else
        echo "   ❌ Rockets API failed"
    fi
    
else
    echo "❌ Backend is not running on port 3001"
fi

echo ""

# Check frontend
echo "🔍 Checking Frontend (Next.js)..."
if curl -s http://localhost:3000 >/dev/null 2>&1; then
    echo "✅ Frontend is running on port 3000"
    
    # Check if it's showing the Space Explorer title
    if curl -s http://localhost:3000 | grep -q "Space Explorer"; then
        echo "   ✅ Frontend is serving Space Explorer content"
    else
        echo "   ⚠️  Frontend is running but content may not be loading properly"
    fi
else
    echo "❌ Frontend is not running on port 3000"
fi

echo ""

# Show process information
echo "📊 Process Information:"
echo "======================"

# Rails processes
echo "Rails processes:"
ps aux | grep -E "(rails|puma)" | grep -v grep | while read line; do
    echo "   $line"
done

# Node processes
echo "Node.js processes:"
ps aux | grep -E "(node|next)" | grep -v grep | while read line; do
    echo "   $line"
done

echo ""

# Show port usage
echo "🌐 Port Usage:"
echo "============="
if lsof -i :3000 >/dev/null 2>&1; then
    echo "✅ Port 3000 (Frontend) - In use"
else
    echo "❌ Port 3000 (Frontend) - Not in use"
fi

if lsof -i :3001 >/dev/null 2>&1; then
    echo "✅ Port 3001 (Backend) - In use"
else
    echo "❌ Port 3001 (Backend) - Not in use"
fi

echo ""
echo "🌐 Access URLs:"
echo "=============="
echo "   Frontend: http://localhost:3000"
echo "   Backend API: http://localhost:3001"
echo "   API Dashboard: http://localhost:3001/api/v1/dashboard"
echo "   API Launches: http://localhost:3001/api/v1/launches"
echo "   API Rockets: http://localhost:3001/api/v1/rockets"
echo ""

# Quick API test
echo "🧪 Quick API Test:"
echo "================="
if curl -s http://localhost:3001/api/v1/dashboard | jq -r '.stats.total_organizations' 2>/dev/null; then
    echo "✅ API is responding with data"
else
    echo "❌ API test failed"
fi 