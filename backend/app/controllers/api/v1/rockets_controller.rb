module Api
  module V1
    class RocketsController < BaseController
      def index
        @rockets = Rocket.includes(:organization).all
        
        # Apply filters
        @rockets = @rockets.by_organization(params[:organization_id]) if params[:organization_id].present?
        @rockets = @rockets.by_status(params[:status]) if params[:status].present?
        @rockets = @rockets.active if params[:active] == 'true'
        
        # Apply search
        if params[:search].present?
          @rockets = @rockets.where("rockets.name ILIKE ? OR rockets.description ILIKE ?", 
                                   "%#{params[:search]}%", "%#{params[:search]}%")
        end
        
        # Sorting
        sort_by = params[:sort_by] || 'name'
        sort_order = params[:sort_order] || 'asc'
        @rockets = @rockets.order(sort_by => sort_order)
        
        # Pagination
        @rockets = @rockets.page(@page).per(@per_page)
        
        render json: {
          rockets: @rockets.as_json(include: { 
            organization: { only: [:id, :name, :country] }
          }, methods: [:launch_count, :successful_launches, :success_rate]),
          pagination: {
            current_page: @rockets.current_page,
            total_pages: @rockets.total_pages,
            total_count: @rockets.total_count,
            per_page: @per_page
          }
        }
      end

      def show
        @rocket = Rocket.includes(:organization, :launches).find(params[:id])
        
        render json: @rocket.as_json(include: {
          organization: { only: [:id, :name, :country, :type, :description, :website] },
          launches: {
            only: [:id, :name, :launch_date, :launch_site, :status, :outcome],
            methods: [:countdown_seconds, :is_upcoming?, :is_past?, :days_until_launch]
          }
        }, methods: [:launch_count, :successful_launches, :success_rate])
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end
    end
  end
end
