module Api
  module V1
    class OrganizationsController < BaseController
      def index
        @organizations = Organization.includes(:rockets, :satellites)
                                   .order(created_at: :desc)
                                   .page(params[:page])
                                   .per(params[:per_page] || 12)
        
        render json: {
          organizations: @organizations.as_json(include: [:rockets, :satellites]),
          pagination: {
            current_page: @organizations.current_page,
            total_pages: @organizations.total_pages,
            total_count: @organizations.total_count,
            per_page: @organizations.limit_value
          }
        }
      end

      def show
        @organization = Organization.includes(:rockets, :satellites, :launch_sites, :astronauts).find(params[:id])
        render json: { organization: @organization.as_json(include: [:rockets, :satellites, :launch_sites, :astronauts]) }
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Organization not found' }, status: :not_found
      end
    end
  end
end
