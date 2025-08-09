module Api
  module V1
    class SatellitesController < BaseController
      def index
        @satellites = Satellite.includes(:organization).all
        
        # Apply filters
        @satellites = @satellites.by_organization(params[:organization_id]) if params[:organization_id].present?
        @satellites = @satellites.by_orbit_type(params[:orbit_type]) if params[:orbit_type].present?
        @satellites = @satellites.by_status(params[:status]) if params[:status].present?
        @satellites = @satellites.active if params[:active] == 'true'
        @satellites = @satellites.recent if params[:recent] == 'true'
        
        # Apply search
        if params[:search].present?
          @satellites = @satellites.where("satellites.name ILIKE ? OR satellites.purpose ILIKE ? OR satellites.description ILIKE ?", 
                                        "%#{params[:search]}%", "%#{params[:search]}%", "%#{params[:search]}%")
        end
        
        # Date range filter
        if params[:launch_date_from].present?
          @satellites = @satellites.where('launch_date >= ?', Date.parse(params[:launch_date_from]))
        end
        if params[:launch_date_to].present?
          @satellites = @satellites.where('launch_date <= ?', Date.parse(params[:launch_date_to]))
        end
        
        # Sorting
        sort_by = params[:sort_by] || 'name'
        sort_order = params[:sort_order] || 'asc'
        @satellites = @satellites.order(sort_by => sort_order)
        
        # Pagination
        @satellites = @satellites.page(@page).per(@per_page)
        
        render json: {
          satellites: @satellites.as_json(include: { 
            organization: { only: [:id, :name, :country] }
          }, methods: [:launch_count, :age_in_days]),
          pagination: {
            current_page: @satellites.current_page,
            total_pages: @satellites.total_pages,
            total_count: @satellites.total_count,
            per_page: @per_page
          }
        }
      end

      def show
        @satellite = Satellite.includes(:organization, :launches).find(params[:id])
        
        render json: @satellite.as_json(include: {
          organization: { only: [:id, :name, :country, :type, :description, :website] },
          launches: {
            only: [:id, :name, :launch_date, :launch_site, :status, :outcome],
            include: { rocket: { only: [:id, :name, :organization_id] } },
            methods: [:countdown_seconds, :is_upcoming?, :is_past?, :days_until_launch]
          }
        }, methods: [:launch_count, :age_in_days])
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end
    end
  end
end
