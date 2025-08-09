module Api
  module V1
    class LaunchesController < BaseController
      def index
        @launches = Launch.includes(:rocket, :satellites).all
        
        # Apply filters
        @launches = @launches.by_status(params[:status]) if params[:status].present?
        @launches = @launches.by_rocket(params[:rocket_id]) if params[:rocket_id].present?
        @launches = @launches.by_site(params[:launch_site]) if params[:launch_site].present?
        @launches = @launches.upcoming if params[:type] == 'upcoming'
        @launches = @launches.past if params[:type] == 'past'
        @launches = @launches.recent if params[:recent] == 'true'
        
        # Apply search
        if params[:search].present?
          @launches = @launches.where("launches.name ILIKE ? OR launches.mission_objective ILIKE ?", 
                                    "%#{params[:search]}%", "%#{params[:search]}%")
        end
        
        # Date range filter
        if params[:launch_date_from].present?
          @launches = @launches.where('launch_date >= ?', DateTime.parse(params[:launch_date_from]))
        end
        if params[:launch_date_to].present?
          @launches = @launches.where('launch_date <= ?', DateTime.parse(params[:launch_date_to]))
        end
        
        # Sorting
        sort_by = params[:sort_by] || 'launch_date'
        sort_order = params[:sort_order] || 'desc'
        @launches = @launches.order(sort_by => sort_order)
        
        # Pagination
        @launches = @launches.page(@page).per(@per_page)
        
        render json: {
          launches: @launches.as_json(include: { 
            rocket: { only: [:id, :name, :organization_id], include: { organization: { only: [:id, :name] } } },
            satellites: { only: [:id, :name, :purpose] }
          }, methods: [:countdown_seconds, :is_upcoming?, :is_past?, :days_until_launch]),
          pagination: {
            current_page: @launches.current_page,
            total_pages: @launches.total_pages,
            total_count: @launches.total_count,
            per_page: @per_page
          }
        }
      end

      def show
        @launch = Launch.includes(:rocket, :satellites).find(params[:id])
        
        render json: @launch.as_json(include: {
          rocket: { 
            only: [:id, :name, :mass, :payload_capacity, :height, :diameter, :stages, :status, :first_flight],
            include: { organization: { only: [:id, :name, :country, :type] } },
            methods: [:launch_count, :success_rate]
          },
          satellites: {
            only: [:id, :name, :mass, :height, :width, :depth, :purpose, :launch_date, :orbit_type, :status],
            include: { organization: { only: [:id, :name] } },
            methods: [:age_in_days]
          }
        }, methods: [:countdown_seconds, :is_upcoming?, :is_past?, :days_until_launch])
      rescue ActiveRecord::RecordNotFound
        render_not_found
      end

      def upcoming
        @launches = Launch.upcoming.includes(:rocket, :satellites)
        @launches = @launches.page(@page).per(@per_page)
        
        render json: {
          launches: @launches.as_json(include: { 
            rocket: { only: [:id, :name, :organization_id], include: { organization: { only: [:id, :name] } } },
            satellites: { only: [:id, :name, :purpose] }
          }, methods: [:countdown_seconds, :days_until_launch]),
          pagination: {
            current_page: @launches.current_page,
            total_pages: @launches.total_pages,
            total_count: @launches.total_count,
            per_page: @per_page
          }
        }
      end

      def past
        @launches = Launch.past.includes(:rocket, :satellites)
        @launches = @launches.page(@page).per(@per_page)
        
        render json: {
          launches: @launches.as_json(include: { 
            rocket: { only: [:id, :name, :organization_id], include: { organization: { only: [:id, :name] } } },
            satellites: { only: [:id, :name, :purpose] }
          }),
          pagination: {
            current_page: @launches.current_page,
            total_pages: @launches.total_pages,
            total_count: @launches.total_count,
            per_page: @per_page
          }
        }
      end
    end
  end
end
