module Api
  module V1
    class LaunchesController < BaseController
      def index
        @launches = Launch.includes(:rocket, :satellites)
                         .order(launch_date: :desc)
                         .page(params[:page])
                         .per(params[:per_page] || 12)
        
        render json: {
          launches: @launches.as_json(include: [:rocket, :satellites]),
          pagination: {
            current_page: @launches.current_page,
            total_pages: @launches.total_pages,
            total_count: @launches.total_count,
            per_page: @launches.limit_value
          }
        }
      end

      def show
        @launch = Launch.includes(:rocket, :satellites).find(params[:id])
        render json: { launch: @launch.as_json(include: [:rocket, :satellites]) }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Launch not found' }, status: :not_found
      end
    end
  end
end
