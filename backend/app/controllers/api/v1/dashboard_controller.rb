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
    end
  end
end
