module Api
  module V1
    class SatellitesController < BaseController
      def index
        @satellites = Satellite.includes(:organization)
                              .order(created_at: :desc)
                              .page(params[:page])
                              .per(params[:per_page] || 12)
        
        render json: {
          satellites: @satellites.as_json(include: :organization),
          pagination: {
            current_page: @satellites.current_page,
            total_pages: @satellites.total_pages,
            total_count: @satellites.total_count,
            per_page: @satellites.limit_value
          }
        }
      end

      def show
        @satellite = Satellite.includes(:organization, :launches).find(params[:id])
        render json: { satellite: @satellite.as_json(include: [:organization, :launches]) }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Satellite not found' }, status: :not_found
      end
    end
  end
end
