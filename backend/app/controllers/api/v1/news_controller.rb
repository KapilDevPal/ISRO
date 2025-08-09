module Api
  module V1
    class NewsController < BaseController
      def index
        @news = News.order(published_at: :desc)
                   .page(params[:page])
                   .per(params[:per_page] || 12)
        
        render json: {
          news: @news.as_json,
          pagination: {
            current_page: @news.current_page,
            total_pages: @news.total_pages,
            total_count: @news.total_count,
            per_page: @news.limit_value
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
