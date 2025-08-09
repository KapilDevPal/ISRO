module Api
  module V1
    class RocketsController < BaseController
      def index
        @rockets = Rocket.includes(:organization)
                        .order(created_at: :desc)
                        .page(params[:page])
                        .per(params[:per_page] || 12)
        
        render json: {
          rockets: @rockets.as_json(include: :organization),
          pagination: {
            current_page: @rockets.current_page,
            total_pages: @rockets.total_pages,
            total_count: @rockets.total_count,
            per_page: @rockets.limit_value
          }
        }
      end

      def show
        @rocket = Rocket.includes(:organization, :launches).find(params[:id])
        render json: { rocket: @rocket.as_json(include: [:organization, :launches]) }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Rocket not found' }, status: :not_found
      end
    end
  end
end
