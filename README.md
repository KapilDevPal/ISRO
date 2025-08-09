# Space Explorer - Interactive Space Exploration Platform

A modern, mobile-friendly, SEO-optimized space exploration web application built with Next.js frontend and Ruby on Rails API backend. Explore rockets, satellites, launches, and the latest space news with interactive 3D models and real-time data.

## 🚀 Features

### Frontend (Next.js)
- **Mobile-first responsive design** with TailwindCSS
- **Interactive 3D models** using Three.js and React Three Fiber
- **Smooth animations** with Framer Motion
- **SEO optimized** with server-side rendering and structured data
- **Real-time countdown timers** for upcoming launches
- **Advanced filtering and search** capabilities
- **PWA-ready** for offline functionality
- **Dark theme** optimized for space exploration

### Backend (Rails API)
- **RESTful API** with comprehensive endpoints
- **PostgreSQL database** for data persistence
- **External API integration** (NASA, SpaceX, The Space Devs)
- **Background job processing** with Sidekiq
- **Caching and rate limiting** for optimal performance
- **Pagination and filtering** support
- **JSON serialization** with Active Model Serializers

## 📋 Pages & Features

### 1. Home (Dashboard)
- Overview of space activities with SEO-friendly headings
- Upcoming launches with animated countdown timers
- Featured rockets and satellites in interactive carousel
- Space-themed animated hero banner with parallax effects
- Real-time statistics and news feed

### 2. Satellites
- Search & filter by organization, launch year, orbit type, status
- Detail pages with specifications and high-quality images
- Interactive 3D models for selected satellites
- SEO optimized with structured data (JSON-LD)

### 3. Rockets
- List view with quick specifications
- Detail view with dimensions, mass, payload capacity
- Interactive Three.js 3D models with animations
- Launch history and success rates

### 4. Launches
- Past & upcoming launches with filter options
- Detail page with mission objectives and outcomes
- Countdown animation using Framer Motion
- Real-time launch status updates

### 5. News
- Aggregated feed from multiple space agencies
- Responsive card grid with fade-in animations
- Click-through to full articles
- Category-based filtering

## 🛠️ Tech Stack

### Frontend
- **Next.js 14** - React framework with App Router
- **TypeScript** - Type-safe development
- **TailwindCSS** - Utility-first CSS framework
- **Framer Motion** - Animation library
- **Three.js / React Three Fiber** - 3D graphics
- **Lucide React** - Icon library
- **Headless UI** - Accessible UI components

### Backend
- **Ruby on Rails 8.0.2** - API framework
- **PostgreSQL** - Database
- **Redis** - Caching and background jobs
- **Sidekiq** - Background job processing
- **HTTParty** - HTTP client for external APIs
- **Kaminari** - Pagination
- **Ransack** - Search functionality
- **Rack Attack** - Rate limiting

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ and npm
- Ruby 3.3+ and Rails 8.0.2
- PostgreSQL
- Redis

### Backend Setup

1. **Clone and navigate to backend:**
```bash
cd backend
```

2. **Install dependencies:**
```bash
bundle install
```

3. **Setup database:**
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. **Start the Rails server:**
```bash
rails server -p 3001
```

The API will be available at `http://localhost:3001`

### Frontend Setup

1. **Navigate to frontend:**
```bash
cd frontend
```

2. **Install dependencies:**
```bash
npm install
```

3. **Start the development server:**
```bash
npm run dev
```

The application will be available at `http://localhost:3000`

## 📊 API Endpoints

### Base URL: `http://localhost:3001/api/v1`

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/dashboard` | GET | Overview statistics and featured content |
| `/organizations` | GET | List all space organizations |
| `/organizations/:id` | GET | Organization details |
| `/rockets` | GET | List all rockets with filtering |
| `/rockets/:id` | GET | Rocket details with launch history |
| `/satellites` | GET | List all satellites with filtering |
| `/satellites/:id` | GET | Satellite details |
| `/launches` | GET | List all launches with filtering |
| `/launches/:id` | GET | Launch details |
| `/launches/upcoming` | GET | Upcoming launches only |
| `/launches/past` | GET | Past launches only |
| `/news` | GET | List all news articles |
| `/news/:id` | GET | News article details |
| `/news/featured` | GET | Featured news articles |

### Query Parameters

All list endpoints support:
- `page` - Page number (default: 1)
- `per_page` - Items per page (default: 20, max: 100)
- `search` - Search term
- `sort_by` - Sort field
- `sort_order` - Sort direction (asc/desc)

## 🎨 Design Features

### Mobile-First Design
- Responsive grid layouts
- Touch-friendly navigation
- Optimized for mobile performance
- PWA capabilities

### Animations & Interactions
- Smooth page transitions
- Hover effects and micro-interactions
- Loading states and skeleton screens
- Parallax scrolling effects

### 3D Elements
- Interactive rocket models
- Satellite orbit visualizations
- Launch sequence animations
- Space environment backgrounds

## 🔧 Configuration

### Environment Variables

#### Backend (.env)
```bash
DATABASE_URL=postgresql://username:password@localhost/space_explorer
REDIS_URL=redis://localhost:6379
NASA_API_KEY=your_nasa_api_key
SPACEX_API_KEY=your_spacex_api_key
```

#### Frontend (.env.local)
```bash
NEXT_PUBLIC_API_URL=http://localhost:3001/api/v1
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

## 🚀 Deployment

### Backend Deployment (Hostinger VPS with Kamal)

1. **Setup Kamal configuration:**
```bash
kamal setup
```

2. **Deploy the application:**
```bash
kamal deploy
```

### Frontend Deployment (Vercel)

1. **Connect to Vercel:**
```bash
vercel --prod
```

2. **Configure environment variables in Vercel dashboard**

### Alternative: Static Export

For static hosting:
```bash
npm run build
npm run export
```

## 📈 Performance Optimizations

### Frontend
- Image optimization with Next.js Image component
- Code splitting and lazy loading
- Bundle analysis and optimization
- Service worker for caching

### Backend
- Database query optimization
- Redis caching for API responses
- Background job processing
- Rate limiting and API throttling

## 🔍 SEO Features

- Server-side rendering for all pages
- Dynamic meta tags and Open Graph data
- JSON-LD structured data
- Sitemap generation
- Robots.txt configuration
- Optimized images and lazy loading

## 🧪 Testing

### Backend Tests
```bash
cd backend
bundle exec rspec
```

### Frontend Tests
```bash
cd frontend
npm test
```

## 📝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- NASA for space data and imagery
- SpaceX for launch information
- The Space Devs for API resources
- Three.js community for 3D graphics
- Framer Motion for animations

## 📞 Support

For support and questions:
- Create an issue on GitHub
- Check the documentation
- Review the API documentation

---

**Built with ❤️ for space exploration enthusiasts** 