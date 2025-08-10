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
        # Get comprehensive organization performance metrics
        organizations = Organization.joins(rockets: :launches)
                                  .group('organizations.id, organizations.name')
                                  .select('organizations.id, organizations.name,
                                          COUNT(DISTINCT rockets.id) as rocket_count,
                                          COUNT(DISTINCT launches.id) as launch_count,
                                          COUNT(CASE WHEN launches.status = \'success\' THEN 1 END) as successful_launches,
                                          COUNT(CASE WHEN launches.status = \'failed\' THEN 1 END) as failed_launches,
                                          AVG(rockets.payload_capacity) as avg_payload_capacity')
                                  .having('COUNT(launches.id) > 0')
                                  .order('launch_count DESC')

        data = organizations.map do |org|
          total = org.launch_count
          successful = org.successful_launches
          failed = org.failed_launches
          
          {
            id: org.id,
            name: org.name,
            rocket_count: org.rocket_count,
            launch_count: total,
            successful_launches: successful,
            failed_launches: failed,
            success_rate: total > 0 ? (successful.to_f / total * 100).round(1) : 0,
            avg_payload_capacity: org.avg_payload_capacity&.round(0) || 0
          }
        end

        render json: { data: data }
      end
    end
  end
end
