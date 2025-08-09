#!/bin/bash

# Space Explorer - Restart Script
# This script kills old processes and restarts both backend and frontend servers

echo "🚀 Space Explorer - Restarting Services"
echo "======================================"

# Function to kill process by port
kill_port() {
    local port=$1
    local pid=$(lsof -ti:$port)
    if [ ! -z "$pid" ]; then
        echo "🔄 Killing process on port $port (PID: $pid)"
        kill -9 $pid
        sleep 2
    else
        echo "✅ No process found on port $port"
    fi
}

# Function to kill Rails server
kill_rails() {
    echo "🔄 Stopping Rails server..."
    pkill -f "rails server" || true
    pkill -f "puma" || true
    sleep 2
}

# Function to kill Node.js processes
kill_node() {
    echo "🔄 Stopping Node.js processes..."
    pkill -f "next" || true
    pkill -f "npm run dev" || true
    sleep 2
}

# Function to check if port is available
check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null ; then
        echo "❌ Port $port is still in use"
        return 1
    else
        echo "✅ Port $port is available"
        return 0
    fi
}

# Function to start backend
start_backend() {
    echo "🚀 Starting Rails backend..."
    cd backend
    if [ ! -f "Gemfile.lock" ]; then
        echo "📦 Installing Rails dependencies..."
        bundle install
    fi
    
    # Check if database exists, if not create it
    if ! rails db:version >/dev/null 2>&1; then
        echo "🗄️  Setting up database..."
        rails db:create
        rails db:migrate
        rails db:seed
    fi
    
    echo "🌐 Starting Rails server on port 3001..."
    rails server -p 3001 -d
    cd ..
}

# Function to start frontend
start_frontend() {
    echo "🚀 Starting Next.js frontend..."
    cd frontend
    
    # Check if node_modules exists, if not install dependencies
    if [ ! -d "node_modules" ]; then
        echo "📦 Installing Node.js dependencies..."
        npm install
    fi
    
    echo "🌐 Starting Next.js development server on port 3000..."
    npm run dev &
    cd ..
}

# Function to wait for service to be ready
wait_for_service() {
    local port=$1
    local service_name=$2
    local max_attempts=30
    local attempt=1
    
    echo "⏳ Waiting for $service_name to be ready..."
    while [ $attempt -le $max_attempts ]; do
        if curl -s http://localhost:$port >/dev/null 2>&1; then
            echo "✅ $service_name is ready on port $port"
            return 0
        fi
        echo "⏳ Attempt $attempt/$max_attempts - $service_name not ready yet..."
        sleep 2
        attempt=$((attempt + 1))
    done
    
    echo "❌ $service_name failed to start on port $port"
    return 1
}

# Function to show status
show_status() {
    echo ""
    echo "📊 Service Status:"
    echo "=================="
    
    # Check backend
    if curl -s http://localhost:3001/up >/dev/null 2>&1; then
        echo "✅ Backend (Rails) - Running on port 3001"
    else
        echo "❌ Backend (Rails) - Not running"
    fi
    
    # Check frontend
    if curl -s http://localhost:3000 >/dev/null 2>&1; then
        echo "✅ Frontend (Next.js) - Running on port 3000"
    else
        echo "❌ Frontend (Next.js) - Not running"
    fi
    
    echo ""
    echo "🌐 Access URLs:"
    echo "   Frontend: http://localhost:3000"
    echo "   Backend API: http://localhost:3001"
    echo "   API Dashboard: http://localhost:3001/api/v1/dashboard"
}

# Main execution
main() {
    echo "🛑 Stopping existing services..."
    
    # Kill processes on specific ports
    kill_port 3000  # Frontend
    kill_port 3001  # Backend
    
    # Kill any remaining Rails/Node processes
    kill_rails
    kill_node
    
    # Wait a moment for processes to fully stop
    sleep 3
    
    # Verify ports are free
    echo ""
    echo "🔍 Checking port availability..."
    check_port 3000
    check_port 3001
    
    echo ""
    echo "🚀 Starting services..."
    
    # Start backend
    start_backend
    
    # Wait for backend to be ready
    if wait_for_service 3001 "Backend"; then
        echo "✅ Backend started successfully"
    else
        echo "❌ Backend failed to start"
        exit 1
    fi
    
    # Start frontend
    start_frontend
    
    # Wait for frontend to be ready
    if wait_for_service 3000 "Frontend"; then
        echo "✅ Frontend started successfully"
    else
        echo "❌ Frontend failed to start"
        exit 1
    fi
    
    # Show final status
    show_status
    
    echo ""
    echo "🎉 Space Explorer is ready!"
    echo "   Press Ctrl+C to stop all services"
    
    # Keep script running and handle cleanup on exit
    trap cleanup EXIT
    
    # Wait for user to stop
    while true; do
        sleep 1
    done
}

# Cleanup function
cleanup() {
    echo ""
    echo "🛑 Shutting down services..."
    kill_port 3000
    kill_port 3001
    kill_rails
    kill_node
    echo "✅ All services stopped"
    exit 0
}

# Check if we're in the right directory
if [ ! -d "backend" ] || [ ! -d "frontend" ]; then
    echo "❌ Error: Please run this script from the project root directory"
    echo "   Expected structure:"
    echo "   ├── backend/"
    echo "   ├── frontend/"
    echo "   └── restart.sh"
    exit 1
fi

# Run main function
main 