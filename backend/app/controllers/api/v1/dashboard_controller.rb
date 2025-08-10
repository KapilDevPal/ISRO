module Api
  module V1
    class DashboardController < BaseController
      def index
        render json: {
          stats: {
            total_organizations: Organization.count,
            total_rockets: Rocket.count,
            total_satellites: Satellite.count,
            total_launches: Launch.count,
            total_space_missions: SpaceMission.count,
            total_astronauts: Astronaut.count,
            upcoming_launches: Launch.upcoming.count,
            recent_news: News.recent.count
          },
          upcoming_launches: Launch.upcoming.limit(5).as_json(include: {
            rocket: { only: [:id, :name], include: { organization: { only: [:id, :name] } } }
          }, methods: [:countdown_seconds, :days_until_launch]),
          recent_news: News.recent.limit(5).as_json(methods: [:published_date, :time_ago]),
          featured_rockets: Rocket.active.limit(3).as_json(include: {
            organization: { only: [:id, :name] }
          }, methods: [:launch_count, :success_rate]),
          featured_satellites: Satellite.active.limit(3).as_json(include: {
            organization: { only: [:id, :name] }
          }, methods: [:age_in_days])
        }
      end

      def launch_success_rates
        # Get launch success rates by organization
        organizations = Organization.joins(rockets: :launches)
                                  .group('organizations.id, organizations.name')
                                  .select('organizations.id, organizations.name, 
                                          COUNT(launches.id) as total_launches,
                                          COUNT(CASE WHEN launches.status = \'success\' THEN 1 END) as successful_launches,
                                          COUNT(CASE WHEN launches.status = \'failed\' THEN 1 END) as failed_launches')
                                  .having('COUNT(launches.id) > 0')
                                  .order('total_launches DESC')

        data = organizations.map do |org|
          total = org.total_launches
          successful = org.successful_launches
          failed = org.failed_launches
          other = total - successful - failed
          
          {
            organization: org.name,
            total_launches: total,
            successful: successful,
            failed: failed,
            other: other,
            success_rate: total > 0 ? (successful.to_f / total * 100).round(1) : 0
          }
        end

        render json: { data: data }
      end

      def top_rockets_by_payload
        # Get top rockets by payload capacity
        rockets = Rocket.joins(:organization)
                       .select('rockets.id, rockets.name, rockets.payload_capacity, 
                               rockets.mass, rockets.height, rockets.stages,
                               organizations.name as organization_name')
                       .where('rockets.payload_capacity > 0')
                       .order('rockets.payload_capacity DESC')
                       .limit(20)

        data = rockets.map do |rocket|
          {
            id: rocket.id,
            name: rocket.name,
            payload_capacity: rocket.payload_capacity,
            mass: rocket.mass,
            height: rocket.height,
            stages: rocket.stages,
            organization: rocket.organization_name,
            mass_to_payload_ratio: rocket.mass > 0 ? (rocket.mass / rocket.payload_capacity).round(2) : 0
          }
        end

        render json: { data: data }
      end

      def mission_cost_estimator
        # Get cost data for mission estimation
        rockets = Rocket.select('id, name, payload_capacity, mass')
                       .where('payload_capacity > 0')
                       .order(:payload_capacity)

        satellites = Satellite.select('id, name, mass, purpose')
                            .where('mass > 0')
                            .order(:mass)

        # Estimated cost factors (in USD per kg)
        cost_factors = {
          rocket_cost_per_kg: 5000,      # $5000 per kg to LEO
          satellite_cost_per_kg: 10000,  # $10000 per kg for satellite
          launch_services: 2000,         # $2000 per kg for launch services
          insurance: 0.15,               # 15% of total cost
          contingency: 0.20              # 20% contingency
        }

        render json: {
          rockets: rockets,
          satellites: satellites,
          cost_factors: cost_factors
        }
      end

      def human_space_missions
        # Get human space mission statistics
        missions = SpaceMission.joins(:astronauts)
                              .group('space_missions.id, space_missions.name, space_missions.status, space_missions.start_date, space_missions.end_date')
                              .select('space_missions.id, space_missions.name, space_missions.status, space_missions.start_date, space_missions.end_date,
                                      COUNT(astronauts.id) as astronaut_count')
                              .order('space_missions.start_date DESC')
                              .limit(20)

        data = missions.map do |mission|
          {
            id: mission.id,
            name: mission.name,
            status: mission.status,
            start_date: mission.start_date,
            end_date: mission.end_date,
            astronaut_count: mission.astronaut_count,
            duration_days: mission.end_date ? (mission.end_date.to_date - mission.start_date.to_date).to_i : nil
          }
        end

        render json: { data: data }
      end

      def astronaut_statistics
        # Get astronaut statistics by nationality and status
        nationality_stats = Astronaut.group(:nationality)
                                   .count
                                   .sort_by { |_, count| -count }
                                   .first(10)

        status_stats = Astronaut.group(:status)
                               .count

        mission_stats = Astronaut.joins(:space_missions)
                                .group('astronauts.id, astronauts.name, astronauts.nationality')
                                .select('astronauts.id, astronauts.name, astronauts.nationality,
                                        COUNT(space_missions.id) as mission_count')
                                .order('mission_count DESC')
                                .limit(15)

        render json: {
          nationality_distribution: nationality_stats.map { |nationality, count| { nationality: nationality, count: count } },
          status_distribution: status_stats.map { |status, count| { status: status, count: count } },
          top_astronauts: mission_stats.map do |astronaut|
            {
              id: astronaut.id,
              name: astronaut.name,
              nationality: astronaut.nationality,
              mission_count: astronaut.mission_count
            }
          end
        }
      end

      def space_mission_timeline
        # Get space mission timeline data
        missions = SpaceMission.includes(:organizations, :astronauts)
                              .order(:start_date)
                              .limit(50)

        data = missions.map do |mission|
          {
            id: mission.id,
            name: mission.name,
            status: mission.status,
            start_date: mission.start_date,
            end_date: mission.end_date,
            organization_count: mission.organizations.count,
            astronaut_count: mission.astronauts.count,
            duration_days: mission.duration_days
          }
        end

        render json: { data: data }
      end

      def launch_trends
        # Get launch trends over time
        launches = Launch.group("DATE(launch_date)")
                        .select("DATE(launch_date) as date, COUNT(*) as count, 
                                COUNT(CASE WHEN status = 'success' THEN 1 END) as successful,
                                COUNT(CASE WHEN status = 'failed' THEN 1 END) as failed")
                        .where('launch_date >= ?', 1.year.ago)
                        .order(:date)

        data = launches.map do |launch|
          {
            date: launch.date,
            total: launch.count,
            successful: launch.successful,
            failed: launch.failed,
            success_rate: launch.count > 0 ? (launch.successful.to_f / launch.count * 100).round(1) : 0
          }
        end

        render json: { data: data }
      end

      def organization_performance
        # Get organization performance metrics
        data = Organization.all.map do |org|
          launch_count = org.launches.count
          successful_launches = org.launches.where(status: 'success').count
          success_rate = launch_count > 0 ? (successful_launches.to_f / launch_count * 100).round(1) : 0
          
          {
            id: org.id,
            name: org.name,
            country: org.country,
            rocket_count: org.rockets.count,
            satellite_count: org.satellites.count,
            launch_count: launch_count,
            successful_launches: successful_launches,
            success_rate: success_rate
          }
        end.sort_by { |org| -org[:launch_count] }.first(15)

        render json: { data: data }
      end

      def mission_progress_visualization
        # Get mission progress data for visualization
        missions = SpaceMission.includes(:mission_milestones, :mission_objectives, :crew_modules)
                              .where.not(mission_milestones: { id: nil })
                              .order(:start_date)
                              .limit(30)

        data = missions.map do |mission|
          {
            id: mission.id,
            name: mission.name,
            status: mission.status,
            start_date: mission.start_date,
            end_date: mission.end_date,
            milestone_progress: mission.milestone_progress,
            total_milestones: mission.mission_milestones.count,
            completed_milestones: mission.mission_milestones.completed.count,
            total_objectives: mission.mission_objectives.count,
            primary_objectives: mission.mission_objectives.primary.count,
            crew_assigned: mission.crew_modules.assigned.count,
            total_crew_positions: mission.crew_modules.count
          }
        end

        render json: { data: data }
      end

      def mission_timeline_visualization
        # Get mission timeline data for visualization
        missions = SpaceMission.includes(:organizations, :astronauts, :mission_milestones)
                              .order(:start_date)
                              .limit(50)

        data = missions.map do |mission|
          {
            id: mission.id,
            name: mission.name,
            status: mission.status,
            start_date: mission.start_date,
            end_date: mission.end_date,
            organization_names: mission.organizations.pluck(:name),
            astronaut_count: mission.astronauts.count,
            milestone_count: mission.mission_milestones.count,
            completed_milestones: mission.mission_milestones.completed.count,
            duration_days: mission.duration_days
          }
        end

        render json: { data: data }
      end

      def orbit_distribution
        # Get satellite orbit distribution data
        orbit_stats = Satellite.group(:orbit_type)
                              .count
                              .sort_by { |_, count| -count }

        # Categorize orbits into LEO, MEO, GEO, and others
        categorized_orbits = {
          'LEO' => 0,
          'MEO' => 0,
          'GEO' => 0,
          'Other' => 0
        }

        orbit_stats.each do |orbit_type, count|
          case orbit_type&.downcase
          when /low earth|leo/
            categorized_orbits['LEO'] += count
          when /medium earth|meo/
            categorized_orbits['MEO'] += count
          when /geosynchronous|geostationary|geo/
            categorized_orbits['GEO'] += count
          else
            categorized_orbits['Other'] += count
          end
        end

        # Get detailed orbit breakdown
        detailed_orbits = orbit_stats.map do |orbit_type, count|
          {
            orbit_type: orbit_type || 'Unknown',
            count: count,
            percentage: (count.to_f / Satellite.count * 100).round(1)
          }
        end

        render json: {
          categorized: categorized_orbits.map { |category, count| { category: category, count: count } },
          detailed: detailed_orbits,
          total_satellites: Satellite.count
        }
      end

      def mission_family_tree
        # Get all missions with their associations
        missions = SpaceMission.includes(:organizations, :mission_rockets, :mission_satellites, :mission_milestones)
                              .order(:start_date)
                              .limit(50)
        
        data = missions.map do |mission|
          # Find related missions by rocket
          related_by_rocket = []
          mission.mission_rockets.each do |mission_rocket|
            rocket = mission_rocket.rocket
            if rocket
              related_missions = SpaceMission.joins(:mission_rockets)
                                            .where(mission_rockets: { rocket: rocket })
                                            .where.not(id: mission.id)
                                            .limit(5)
              related_by_rocket.concat(related_missions.map { |m| { id: m.id, name: m.name, relation: "Same Rocket: #{rocket.name}" } })
            end
          end
          
          # Find related missions by organization
          related_by_org = []
          mission.organizations.each do |org|
            related_missions = SpaceMission.joins(:organizations)
                                          .where(organizations: { id: org.id })
                                          .where.not(id: mission.id)
                                          .limit(5)
            related_by_org.concat(related_missions.map { |m| { id: m.id, name: m.name, relation: "Same Agency: #{org.name}" } })
          end
          
          # Find related missions by target (based on description keywords)
          related_by_target = []
          target_keywords = extract_target_keywords(mission.description)
          if target_keywords.any?
            related_missions = SpaceMission.where("description ILIKE ?", "%#{target_keywords.first}%")
                                          .where.not(id: mission.id)
                                          .limit(3)
            related_by_target.concat(related_missions.map { |m| { id: m.id, name: m.name, relation: "Similar Target: #{target_keywords.first}" } })
          end
          
          # Combine all related missions and remove duplicates
          all_related = (related_by_rocket + related_by_org + related_by_target)
                         .uniq { |m| m[:id] }
                         .first(8) # Limit to 8 related missions
          
          {
            id: mission.id,
            name: mission.name,
            description: mission.description,
            status: mission.status,
            start_date: mission.start_date,
            end_date: mission.end_date,
            organizations: mission.organizations.map { |org| { id: org.id, name: org.name, country: org.country } },
            rockets: mission.mission_rockets.map { |mr| mr.rocket&.name }.compact,
            satellites: mission.mission_satellites.map { |ms| ms.satellite&.name }.compact,
            milestone_count: mission.mission_milestones.count,
            completed_milestones: mission.mission_milestones.completed.count,
            related_missions: all_related
          }
        end
        
        render json: { data: data }
      end

      private

      def extract_target_keywords(description)
        return [] unless description
        
        keywords = []
        description.downcase!
        
        # Extract celestial body keywords
        if description.include?('moon') || description.include?('lunar')
          keywords << 'Moon'
        end
        if description.include?('mars') || description.include?('martian')
          keywords << 'Mars'
        end
        if description.include?('earth') || description.include?('terrestrial')
          keywords << 'Earth'
        end
        if description.include?('sun') || description.include?('solar')
          keywords << 'Sun'
        end
        if description.include?('jupiter') || description.include?('jovian')
          keywords << 'Jupiter'
        end
        if description.include?('saturn') || description.include?('saturnian')
          keywords << 'Saturn'
        end
        
        keywords
      end
    end
  end
end
