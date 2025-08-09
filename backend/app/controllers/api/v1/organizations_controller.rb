module Api
  module V1
    class OrganizationsController < BaseController
      def index
        @organizations = Organization.all
        
        # Apply filters
        @organizations = @organizations.by_country(params[:country]) if params[:country].present?
        @organizations = @organizations.by_type(params[:type]) if params[:type].present?
        @organizations = @organizations.active if params[:status] == 'active'
        
        # Apply search
        if params[:search].present?
          @organizations = @organizations.where("name ILIKE ? OR description ILIKE ?", 
                                               "%#{params[:search]}%", "%#{params[:search]}%")
        end
        
        # Pagination
        @organizations = @organizations.page(@page).per(@per_page)
        
        render json: {
          organizations: @organizations.as_json(include: { 
            rockets: { only: [:id, :name, :status] },
            satellites: { only: [:id, :name, :status] }
          }),
          pagination: {
            current_page: @organizations.current_page,
            total_pages: @organizations.total_pages,
            total_count: @organizations.total_count,
            per_page: @per_page
          }
        }
      end

      def show
        @organization = Organization.find(params[:id])
        
        render json: @organization.as_json(include: {
          rockets: { 
            only: [:id, :name, :mass, :payload_capacity, :height, :diameter, :stages, :status, :first_flight],
            methods: [:launch_count, :success_rate]
          },
          satellites: {
            only: [:id, :name, :mass, :height, :width, :depth, :purpose, :launch_date, :orbit_type, :status],
            methods: [:launch_count, :age_in_days]
          }
        })
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end
    end
  end
end
