module Api
  module V1
    class NewsController < BaseController
      def index
        @news = News.all
        
        # Apply filters
        @news = @news.by_category(params[:category]) if params[:category].present?
        @news = @news.by_source(params[:source]) if params[:source].present?
        @news = @news.featured if params[:featured] == 'true'
        @news = @news.recent if params[:recent] == 'true'
        
        # Apply search
        if params[:search].present?
          @news = @news.where("title ILIKE ? OR summary ILIKE ?", 
                             "%#{params[:search]}%", "%#{params[:search]}%")
        end
        
        # Date range filter
        if params[:published_from].present?
          @news = @news.where('published_at >= ?', DateTime.parse(params[:published_from]))
        end
        if params[:published_to].present?
          @news = @news.where('published_at <= ?', DateTime.parse(params[:published_to]))
        end
        
        # Sorting
        sort_by = params[:sort_by] || 'published_at'
        sort_order = params[:sort_order] || 'desc'
        @news = @news.order(sort_by => sort_order)
        
        # Pagination
        @news = @news.page(@page).per(@per_page)
        
        render json: {
          news: @news.as_json(methods: [:published_date, :time_ago]),
          pagination: {
            current_page: @news.current_page,
            total_pages: @news.total_pages,
            total_count: @news.total_count,
            per_page: @per_page
          }
        }
      end

      def show
        @news_item = News.find(params[:id])
        
        render json: @news_item.as_json(methods: [:published_date, :time_ago])
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end

      def featured
        @news = News.featured.page(@page).per(@per_page)
        
        render json: {
          news: @news.as_json(methods: [:published_date, :time_ago]),
          pagination: {
            current_page: @news.current_page,
            total_pages: @news.total_pages,
            total_count: @news.total_count,
            per_page: @per_page
          }
        }
      end
    end
  end
end
