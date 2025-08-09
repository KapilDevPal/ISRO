class Admin::DashboardController < ApplicationController
  def index
    @stats = {
      organizations: Organization.count,
      rockets: Rocket.count,
      satellites: Satellite.count,
      launches: Launch.count,
      news: News.count,
      space_probes: SpaceProbe.count,
      launch_sites: LaunchSite.count,
      space_events: SpaceEvent.count,
      space_missions: SpaceMission.count,
      astronauts: Astronaut.count
    }
  end
end
