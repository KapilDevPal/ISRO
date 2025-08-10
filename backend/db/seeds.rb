# Clear existing data
puts "Clearing existing data..."

# Clear in proper order to avoid foreign key violations
MissionFailure.destroy_all
FutureMission.destroy_all
MissionMilestone.destroy_all
CrewModule.destroy_all
MissionObjective.destroy_all
AstronautMission.destroy_all
MissionOrganization.destroy_all
MissionRocket.destroy_all
MissionSatellite.destroy_all
SpaceEventOrganization.destroy_all
SpaceMission.destroy_all
Astronaut.destroy_all
SpaceStation.destroy_all
SpaceProbe.destroy_all
SpaceEvent.destroy_all
LaunchSite.destroy_all
LaunchSatellite.destroy_all
Launch.destroy_all
Satellite.destroy_all
Rocket.destroy_all
News.destroy_all
Organization.destroy_all

# Create Organizations
puts "Creating organizations..."

organizations = [
  {
    name: "NASA",
    country: "United States",
    type: "Government",
    description: "National Aeronautics and Space Administration - America's space agency leading space exploration, scientific discovery, and aeronautics research.",
    founded_year: 1958
  },
  {
    name: "ISRO",
    country: "India",
    type: "Government", 
    description: "Indian Space Research Organisation - India's national space agency responsible for space research and exploration.",
    founded_year: 1969
  },
  {
    name: "SpaceX",
    country: "United States",
    type: "Private",
    description: "Space Exploration Technologies Corp. - Private aerospace manufacturer and space transportation services company.",
    founded_year: 2002
  },
  {
    name: "ESA",
    country: "Europe",
    type: "Government",
    description: "European Space Agency - Europe's gateway to space, coordinating space research and exploration for 22 member states.",
    founded_year: 1975
  },
  {
    name: "Roscosmos",
    country: "Russia",
    type: "Government",
    description: "Russian Federal Space Agency - Russia's space agency responsible for space research and cosmonautics programs.",
    founded_year: 1992
  },
  {
    name: "CNSA",
    country: "China",
    type: "Government",
    description: "China National Space Administration - China's space agency responsible for space research and exploration.",
    founded_year: 1993
  },
  {
    name: "JAXA",
    country: "Japan",
    type: "Government",
    description: "Japan Aerospace Exploration Agency - Japan's space agency conducting space research and exploration.",
    founded_year: 2003
  },
  {
    name: "Blue Origin",
    country: "United States",
    type: "Private",
    description: "Private aerospace manufacturer and spaceflight services company founded by Jeff Bezos.",
    founded_year: 2000
  },
  {
    name: "OneWeb",
    country: "United Kingdom",
    type: "Private",
    description: "Global communications company building a satellite internet constellation.",
    founded_year: 2012
  },
  {
    name: "DLR",
    country: "Germany",
    type: "Government",
    description: "German Aerospace Center - Germany's space agency and research center for aeronautics and space.",
    founded_year: 1969
  }
]

organizations.each do |org_data|
  Organization.create!(org_data)
end

puts "Created #{Organization.count} organizations"

# Create Rockets
puts "Creating rockets..."

rockets = [
  {
    name: "Falcon 9",
    description: "Two-stage rocket designed and manufactured by SpaceX for reliable and safe transport of satellites and Dragon spacecraft.",
    mass: 549054,
    height: 70,
    diameter: 3.7,
    payload_capacity: 22800,
    stages: 2,
    status: "active",
    organization_id: Organization.find_by(name: "SpaceX").id
  },
  {
    name: "Saturn V",
    description: "American super heavy-lift launch vehicle used by NASA for Apollo and Skylab programs.",
    mass: 2970000,
    height: 110.6,
    diameter: 10.1,
    payload_capacity: 140000,
    stages: 3,
    status: "retired",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "PSLV",
    description: "Polar Satellite Launch Vehicle - India's workhorse rocket for launching satellites into polar and geosynchronous orbits.",
    mass: 295000,
    height: 44,
    diameter: 2.8,
    payload_capacity: 3800,
    stages: 4,
    status: "active",
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "GSLV",
    description: "Geosynchronous Satellite Launch Vehicle - India's rocket for launching satellites into geosynchronous orbits.",
    mass: 414750,
    height: 49.13,
    diameter: 2.8,
    payload_capacity: 5000,
    stages: 3,
    status: "active",
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "Ariane 5",
    description: "European heavy-lift launch vehicle used by ESA for launching satellites and space probes.",
    mass: 777000,
    height: 53,
    diameter: 5.4,
    payload_capacity: 21000,
    stages: 2,
    status: "active",
    organization_id: Organization.find_by(name: "ESA").id
  },
  {
    name: "New Shepard",
    description: "Reusable suborbital rocket system designed for space tourism and research.",
    mass: 75000,
    height: 18,
    diameter: 3.7,
    payload_capacity: 1000,
    stages: 1,
    status: "active",
    organization_id: Organization.find_by(name: "Blue Origin").id
  }
]

rockets.each do |rocket_data|
  Rocket.create!(rocket_data)
end

puts "Created #{Rocket.count} rockets"

# Create Satellites
puts "Creating satellites..."

satellites = [
  {
    name: "Hubble Space Telescope",
    purpose: "Space telescope for astronomical observations and deep space imaging.",
    mass: 11110,
    height: 13.2,
    width: 4.2,
    depth: 4.2,
    orbit_type: "Low Earth Orbit",
    status: "active",
    launch_date: "1990-04-24",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Mangalyaan",
    purpose: "Mars Orbiter Mission - India's first interplanetary mission to study Mars.",
    mass: 1337,
    height: 1.5,
    width: 1.5,
    depth: 1.5,
    orbit_type: "Mars Orbit",
    status: "active",
    launch_date: "2013-11-05",
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "Starlink Satellite",
    purpose: "Satellite internet constellation providing global broadband coverage.",
    mass: 260,
    height: 0.3,
    width: 1.6,
    depth: 1.6,
    orbit_type: "Low Earth Orbit",
    status: "active",
    launch_date: "2019-05-24",
    organization_id: Organization.find_by(name: "SpaceX").id
  },
  {
    name: "Chandrayaan-3",
    purpose: "Lunar exploration mission to study the Moon's surface and composition.",
    mass: 3900,
    height: 2.1,
    width: 2.1,
    depth: 2.1,
    orbit_type: "Lunar Orbit",
    status: "active",
    launch_date: "2023-07-14",
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "James Webb Space Telescope",
    purpose: "Infrared space telescope for studying the early universe and exoplanets.",
    mass: 6200,
    height: 8.0,
    width: 21.2,
    depth: 14.2,
    orbit_type: "Lagrange Point L2",
    status: "active",
    launch_date: "2021-12-25",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Galileo Satellite",
    purpose: "European global navigation satellite system providing positioning services.",
    mass: 700,
    height: 2.7,
    width: 1.1,
    depth: 1.1,
    orbit_type: "Medium Earth Orbit",
    status: "active",
    launch_date: "2011-10-21",
    organization_id: Organization.find_by(name: "ESA").id
  },
  {
    name: "GPS Satellite",
    purpose: "Global Positioning System satellite for navigation and timing.",
    mass: 1630,
    height: 5.3,
    width: 1.8,
    depth: 1.8,
    orbit_type: "Medium Earth Orbit",
    status: "active",
    launch_date: "2010-05-28",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "INSAT-3DR",
    purpose: "Indian geostationary satellite for weather monitoring and communication.",
    mass: 2250,
    height: 2.4,
    width: 1.6,
    depth: 1.6,
    orbit_type: "Geostationary Orbit",
    status: "active",
    launch_date: "2016-09-08",
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "Astra 2E",
    purpose: "European communication satellite for broadcasting and broadband services.",
    mass: 6000,
    height: 7.0,
    width: 2.4,
    depth: 2.4,
    orbit_type: "Geostationary Orbit",
    status: "active",
    launch_date: "2013-09-29",
    organization_id: Organization.find_by(name: "ESA").id
  },
  {
    name: "OneWeb Satellite",
    purpose: "Satellite internet constellation for global connectivity.",
    mass: 150,
    height: 0.3,
    width: 1.0,
    depth: 1.0,
    orbit_type: "Low Earth Orbit",
    status: "active",
    launch_date: "2020-02-07",
    organization_id: Organization.find_by(name: "OneWeb").id
  },
  {
    name: "TerraSAR-X",
    purpose: "German radar satellite for Earth observation and mapping.",
    mass: 1230,
    height: 4.9,
    width: 2.4,
    depth: 2.4,
    orbit_type: "Low Earth Orbit",
    status: "active",
    launch_date: "2007-06-15",
    organization_id: Organization.find_by(name: "DLR").id
  },
  {
    name: "Sentinel-1A",
    purpose: "European radar satellite for environmental monitoring and disaster management.",
    mass: 2300,
    height: 3.4,
    width: 1.0,
    depth: 1.0,
    orbit_type: "Low Earth Orbit",
    status: "active",
    launch_date: "2014-04-03",
    organization_id: Organization.find_by(name: "ESA").id
  }
]

satellites.each do |satellite_data|
  Satellite.create!(satellite_data)
end

puts "Created #{Satellite.count} satellites"

# Create Launches
puts "Creating launches..."

launches = [
  {
    name: "Artemis I",
    description: "Uncrewed test flight of the Orion spacecraft around the Moon.",
    launch_date: "2025-08-23 23:46:00",
    launch_site: "Kennedy Space Center, Florida",
    status: "scheduled",
    outcome: "Unknown",
    rocket: Rocket.find_by(name: "Saturn V")
  },
  {
    name: "Starlink Mission",
    description: "Launch of Starlink satellites for global internet coverage.",
    launch_date: "2025-09-15 14:30:00",
    launch_site: "Cape Canaveral, Florida",
    status: "scheduled",
    outcome: "Unknown",
    rocket: Rocket.find_by(name: "Falcon 9")
  },
  {
    name: "Chandrayaan-3 Launch",
    description: "Successful launch of India's lunar exploration mission.",
    launch_date: "2023-07-14 09:05:00",
    launch_site: "Satish Dhawan Space Centre, India",
    status: "success",
    outcome: "Successful",
    rocket: Rocket.find_by(name: "GSLV")
  },
  {
    name: "Hubble Space Telescope Launch",
    description: "Launch of the Hubble Space Telescope aboard Space Shuttle Discovery.",
    launch_date: "1990-04-24 12:33:00",
    launch_site: "Kennedy Space Center, Florida",
    status: "success",
    outcome: "Successful",
    rocket: Rocket.find_by(name: "Saturn V")
  },
  {
    name: "Mangalyaan Launch",
    description: "India's first Mars mission launch.",
    launch_date: "2013-11-05 09:08:00",
    launch_site: "Satish Dhawan Space Centre, India",
    status: "success",
    outcome: "Successful",
    rocket: Rocket.find_by(name: "PSLV")
  },
  {
    name: "James Webb Launch",
    description: "Launch of the James Webb Space Telescope.",
    launch_date: "2021-12-25 12:20:00",
    launch_site: "Guiana Space Center, French Guiana",
    status: "success",
    outcome: "Successful",
    rocket: Rocket.find_by(name: "Ariane 5")
  }
]

launches.each do |launch_data|
  Launch.create!(launch_data)
end

puts "Created #{Launch.count} launches"

# Create Launch-Satellite associations
puts "Creating launch-satellite associations..."

LaunchSatellite.create!(
  launch: Launch.find_by(name: "Hubble Space Telescope Launch"),
  satellite: Satellite.find_by(name: "Hubble Space Telescope")
)

LaunchSatellite.create!(
  launch: Launch.find_by(name: "Chandrayaan-3 Launch"),
  satellite: Satellite.find_by(name: "Chandrayaan-3")
)

LaunchSatellite.create!(
  launch: Launch.find_by(name: "Mangalyaan Launch"),
  satellite: Satellite.find_by(name: "Mangalyaan")
)

LaunchSatellite.create!(
  launch: Launch.find_by(name: "James Webb Launch"),
  satellite: Satellite.find_by(name: "James Webb Space Telescope")
)

# Create Space Statistics
puts "Creating space statistics..."

SpaceStatistic.create!(
  satellites_in_orbit: 4852,
  active_astronauts: 7,
  launches_this_year: 156,
  reusable_landings: 234,
  last_updated: Date.current
)

puts "Created space statistics"

# Create Space Probes
puts "Creating space probes..."

probes = [
  {
    name: "Voyager 1",
    target_destination: "Interstellar Space",
    launch_date: "1977-09-05",
    status: "active",
    discoveries: "First spacecraft to enter interstellar space. Discovered active volcanoes on Io, complex ring system of Saturn, and provided detailed images of Jupiter and Saturn.",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Voyager 2",
    target_destination: "Interstellar Space",
    launch_date: "1977-08-20",
    status: "active",
    discoveries: "Only spacecraft to visit Uranus and Neptune. Discovered 10 new moons, 2 new rings, and provided detailed images of all four outer planets.",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Perseverance",
    target_destination: "Mars",
    launch_date: "2020-07-30",
    status: "active",
    discoveries: "Collecting rock and soil samples for future return to Earth. Searching for signs of ancient microbial life and studying Mars' geology and climate.",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Curiosity",
    target_destination: "Mars",
    launch_date: "2011-11-26",
    status: "active",
    discoveries: "Confirmed Mars had conditions suitable for microbial life in the past. Found organic molecules and seasonal methane variations.",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Parker Solar Probe",
    target_destination: "Sun",
    launch_date: "2018-08-12",
    status: "active",
    discoveries: "Closest spacecraft to the Sun. Studying solar wind, coronal heating, and solar energetic particles.",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Juno",
    target_destination: "Jupiter",
    launch_date: "2011-08-05",
    status: "active",
    discoveries: "Studying Jupiter's composition, gravity field, magnetic field, and polar magnetosphere. Revealed complex atmospheric dynamics.",
    organization_id: Organization.find_by(name: "NASA").id
  }
]

probes.each do |probe_data|
  SpaceProbe.create!(probe_data)
end

puts "Created #{SpaceProbe.count} space probes"

# Create Launch Sites
puts "Creating launch sites..."

launch_sites = [
  {
    name: "Kennedy Space Center",
    country: "United States",
    latitude: 28.5729,
    longitude: -80.6490,
    total_launches: 184,
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Cape Canaveral Space Force Station",
    country: "United States",
    latitude: 28.4889,
    longitude: -80.5778,
    total_launches: 156,
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Satish Dhawan Space Centre",
    country: "India",
    latitude: 13.7199,
    longitude: 80.2304,
    total_launches: 89,
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "Guiana Space Center",
    country: "French Guiana",
    latitude: 5.2320,
    longitude: -52.7694,
    total_launches: 312,
    organization_id: Organization.find_by(name: "ESA").id
  },
  {
    name: "Baikonur Cosmodrome",
    country: "Kazakhstan",
    latitude: 45.9646,
    longitude: 63.3052,
    total_launches: 1567,
    organization_id: Organization.find_by(name: "Roscosmos").id
  },
  {
    name: "Jiuquan Satellite Launch Center",
    country: "China",
    latitude: 40.9583,
    longitude: 100.2917,
    total_launches: 145,
    organization_id: Organization.find_by(name: "CNSA").id
  },
  {
    name: "Tanegashima Space Center",
    country: "Japan",
    latitude: 30.4000,
    longitude: 130.9700,
    total_launches: 67,
    organization_id: Organization.find_by(name: "JAXA").id
  },
  {
    name: "SpaceX Launch Complex 40",
    country: "United States",
    latitude: 28.5619,
    longitude: -80.5772,
    total_launches: 234,
    organization_id: Organization.find_by(name: "SpaceX").id
  }
]

launch_sites.each do |site_data|
  LaunchSite.create!(site_data)
end

puts "Created #{LaunchSite.count} launch sites"

# Create Space Events
puts "Creating space events..."

events = [
  {
    name: "First Human in Space",
    description: "Yuri Gagarin becomes the first human to journey into outer space aboard Vostok 1.",
    event_date: "1961-04-12",
    category: "milestone"
  },
  {
    name: "First Moon Landing",
    description: "Neil Armstrong and Buzz Aldrin become the first humans to walk on the Moon during Apollo 11 mission.",
    event_date: "1969-07-20",
    category: "milestone"
  },
  {
    name: "Challenger Disaster",
    description: "Space Shuttle Challenger breaks apart 73 seconds into its flight, killing all seven crew members.",
    event_date: "1986-01-28",
    category: "disaster"
  },
  {
    name: "Hubble Space Telescope Launch",
    description: "Hubble Space Telescope is deployed into low Earth orbit, revolutionizing astronomy.",
    event_date: "1990-04-24",
    category: "milestone"
  },
  {
    name: "First Space Station",
    description: "Salyut 1 becomes the world's first space station, launched by the Soviet Union.",
    event_date: "1971-04-19",
    category: "milestone"
  },
  {
    name: "Halley's Comet Approach",
    description: "Halley's Comet makes its closest approach to Earth, visible to the naked eye.",
    event_date: "1986-02-09",
    category: "astronomical_event"
  },
  {
    name: "Columbia Disaster",
    description: "Space Shuttle Columbia disintegrates during re-entry, killing all seven crew members.",
    event_date: "2003-02-01",
    category: "disaster"
  },
  {
    name: "First Private Spacecraft",
    description: "SpaceShipOne becomes the first privately funded spacecraft to reach space.",
    event_date: "2004-06-21",
    category: "milestone"
  }
]

events.each do |event_data|
  SpaceEvent.create!(event_data)
end

puts "Created #{SpaceEvent.count} space events"

# Create Space Missions
puts "Creating space missions..."

space_missions = [
  {
    name: "Artemis Program",
    description: "NASA's program to return humans to the Moon and establish sustainable lunar exploration.",
    status: "ongoing",
    start_date: "2017-01-01",
    end_date: nil,
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Gaganyaan",
    description: "India's first human spaceflight program to send astronauts to low Earth orbit.",
    status: "planned",
    start_date: "2024-01-01",
    end_date: "2025-12-31",
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "Mars Sample Return",
    description: "Joint mission to return samples from Mars to Earth for analysis.",
    status: "planned",
    start_date: "2026-01-01",
    end_date: "2031-12-31",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Starlink Constellation",
    description: "SpaceX's satellite internet constellation providing global broadband coverage.",
    status: "ongoing",
    start_date: "2019-01-01",
    end_date: nil,
    organization_id: Organization.find_by(name: "SpaceX").id
  }
]

space_missions.each do |mission_data|
  mission = SpaceMission.create!(
    name: mission_data[:name],
    description: mission_data[:description],
    status: mission_data[:status],
    start_date: mission_data[:start_date],
    end_date: mission_data[:end_date],
    organization_id: mission_data[:organization_id]
  )
  
  # Add additional organizations if multiple
  if mission_data[:name] == "Mars Sample Return"
    MissionOrganization.create!(space_mission: mission, organization: Organization.find_by(name: "ESA"))
  end
end

puts "Created #{SpaceMission.count} space missions"

# Create Mission-Rocket associations
puts "Creating mission-rocket associations..."

MissionRocket.create!(
  space_mission: SpaceMission.find_by(name: "Artemis Program"),
  rocket: Rocket.find_by(name: "Saturn V")
)

MissionRocket.create!(
  space_mission: SpaceMission.find_by(name: "Gaganyaan"),
  rocket: Rocket.find_by(name: "GSLV")
)

MissionRocket.create!(
  space_mission: SpaceMission.find_by(name: "Starlink Constellation"),
  rocket: Rocket.find_by(name: "Falcon 9")
)

# Create Mission-Satellite associations
puts "Creating mission-satellite associations..."

MissionSatellite.create!(
  space_mission: SpaceMission.find_by(name: "Starlink Constellation"),
  satellite: Satellite.find_by(name: "Starlink Satellite")
)

MissionSatellite.create!(
  space_mission: SpaceMission.find_by(name: "Starlink Constellation"),
  satellite: Satellite.find_by(name: "OneWeb Satellite")
)

# Create Mission Milestones
puts "Creating mission milestones..."

mission_milestones = [
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Artemis I Launch",
    description: "Uncrewed test flight of Orion spacecraft around the Moon",
    event_date: "2022-11-16",
    milestone_type: "launch",
    status: "completed"
  },
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Artemis II Launch",
    description: "Crewed test flight with astronauts around the Moon",
    event_date: "2025-09-01",
    milestone_type: "launch",
    status: "planned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Artemis III Landing",
    description: "First human landing on the Moon since 1972",
    event_date: "2026-12-01",
    milestone_type: "landing",
    status: "planned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Gaganyaan"),
    name: "Uncrewed Test Flight",
    description: "Test flight without astronauts to validate systems",
    event_date: "2024-12-01",
    milestone_type: "launch",
    status: "planned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Gaganyaan"),
    name: "Crewed Mission",
    description: "First Indian human spaceflight mission",
    event_date: "2025-12-01",
    milestone_type: "launch",
    status: "planned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Starlink Constellation"),
    name: "First Launch",
    description: "Initial deployment of Starlink satellites",
    event_date: "2019-05-24",
    milestone_type: "deployment",
    status: "completed"
  },
  {
    space_mission: SpaceMission.find_by(name: "Starlink Constellation"),
    name: "Global Coverage",
    description: "Achieve global internet coverage",
    event_date: "2024-12-31",
    milestone_type: "deployment",
    status: "in_progress"
  }
]

mission_milestones.each do |milestone_data|
  MissionMilestone.create!(milestone_data)
end

puts "Created #{MissionMilestone.count} mission milestones"

# Create Mission Objectives
puts "Creating mission objectives..."

mission_objectives = [
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Establish sustainable lunar exploration",
    description: "Establish sustainable lunar exploration",
    objective_type: "lunar_exploration",
    color_code: "#6B7280",
    priority: 1,
    is_primary: true
  },
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Test new technologies for Mars missions",
    description: "Test new technologies for Mars missions",
    objective_type: "technology_demonstration",
    color_code: "#F59E0B",
    priority: 2,
    is_primary: false
  },
  {
    space_mission: SpaceMission.find_by(name: "Gaganyaan"),
    name: "Demonstrate human spaceflight capability",
    description: "Demonstrate human spaceflight capability",
    objective_type: "technology_demonstration",
    color_code: "#F59E0B",
    priority: 1,
    is_primary: true
  },
  {
    space_mission: SpaceMission.find_by(name: "Gaganyaan"),
    name: "Conduct scientific experiments in space",
    description: "Conduct scientific experiments in space",
    objective_type: "scientific_research",
    color_code: "#8B5CF6",
    priority: 3,
    is_primary: false
  },
  {
    space_mission: SpaceMission.find_by(name: "Starlink Constellation"),
    name: "Provide global internet access",
    description: "Provide global internet access",
    objective_type: "communication",
    color_code: "#3B82F6",
    priority: 1,
    is_primary: true
  },
  {
    space_mission: SpaceMission.find_by(name: "Starlink Constellation"),
    name: "Generate revenue for Mars missions",
    description: "Generate revenue for Mars missions",
    objective_type: "commercial",
    color_code: "#10B981",
    priority: 2,
    is_primary: false
  }
]

mission_objectives.each do |objective_data|
  MissionObjective.create!(objective_data)
end

puts "Created #{MissionObjective.count} mission objectives"



# Create Astronauts
puts "Creating astronauts..."

astronauts = [
  {
    name: "Neil Armstrong",
    nationality: "American",
    bio: "First human to walk on the Moon during Apollo 11 mission. Naval aviator, test pilot, and aerospace engineer.",
    image_url: "https://example.com/neil-armstrong.jpg",
    status: "deceased",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Buzz Aldrin",
    nationality: "American",
    bio: "Second human to walk on the Moon during Apollo 11 mission. Fighter pilot, engineer, and advocate for space exploration.",
    image_url: "https://example.com/buzz-aldrin.jpg",
    status: "retired",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Yuri Gagarin",
    nationality: "Soviet",
    bio: "First human to journey into outer space aboard Vostok 1. Soviet Air Forces pilot and cosmonaut.",
    image_url: "https://example.com/yuri-gagarin.jpg",
    status: "deceased",
    organization_id: Organization.find_by(name: "Roscosmos").id
  },
  {
    name: "Sally Ride",
    nationality: "American",
    bio: "First American woman in space aboard Space Shuttle Challenger. Physicist and advocate for science education.",
    image_url: "https://example.com/sally-ride.jpg",
    status: "deceased",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Chris Hadfield",
    nationality: "Canadian",
    bio: "First Canadian to walk in space. Commander of the International Space Station and social media pioneer.",
    image_url: "https://example.com/chris-hadfield.jpg",
    status: "retired",
    organization_id: Organization.find_by(name: "NASA").id
  },
  {
    name: "Rakesh Sharma",
    nationality: "Indian",
    bio: "First Indian citizen to travel to space aboard Soyuz T-11. Indian Air Force pilot and cosmonaut.",
    image_url: "https://example.com/rakesh-sharma.jpg",
    status: "retired",
    organization_id: Organization.find_by(name: "ISRO").id
  },
  {
    name: "Yang Liwei",
    nationality: "Chinese",
    bio: "First Chinese astronaut in space aboard Shenzhou 5. People's Liberation Army pilot and taikonaut.",
    image_url: "https://example.com/yang-liwei.jpg",
    status: "retired",
    organization_id: Organization.find_by(name: "CNSA").id
  },
  {
    name: "Tim Peake",
    nationality: "British",
    bio: "First British ESA astronaut to visit the International Space Station. Army Air Corps officer and space advocate.",
    image_url: "https://example.com/tim-peake.jpg",
    status: "active",
    organization_id: Organization.find_by(name: "ESA").id
  }
]

astronauts.each do |astronaut_data|
  Astronaut.create!(astronaut_data)
end

puts "Created #{Astronaut.count} astronauts"

# Create Crew Modules
puts "Creating crew modules..."

crew_modules = [
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Commander Module",
    mission_role: "Commander",
    astronaut_id: Astronaut.find_by(name: "Neil Armstrong").id,
    status: "assigned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Pilot Module",
    mission_role: "Pilot",
    astronaut_id: Astronaut.find_by(name: "Buzz Aldrin").id,
    status: "assigned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Artemis Program"),
    name: "Mission Specialist Module",
    mission_role: "Mission Specialist",
    astronaut_id: Astronaut.find_by(name: "Sally Ride").id,
    status: "assigned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Gaganyaan"),
    name: "Commander Module",
    mission_role: "Commander",
    astronaut_id: Astronaut.find_by(name: "Rakesh Sharma").id,
    status: "assigned"
  },
  {
    space_mission: SpaceMission.find_by(name: "Gaganyaan"),
    name: "Pilot Module",
    mission_role: "Pilot",
    astronaut_id: Astronaut.find_by(name: "Chris Hadfield").id,
    status: "assigned"
  }
]

crew_modules.each do |crew_data|
  CrewModule.create!(crew_data)
end

puts "Created #{CrewModule.count} crew modules"

# Create News
puts "Creating news articles..."

news_articles = [
  {
    title: "NASA's Artemis Program Aims for Moon Return",
    source: "NASA",
    url: "https://www.nasa.gov/artemis",
    published_at: "2024-01-15 10:00:00",
    summary: "NASA's Artemis program is making significant progress toward returning humans to the Moon by 2025.",
    category: "featured",
    image_url: "https://example.com/artemis.jpg"
  },
  {
    title: "ISRO Successfully Launches Chandrayaan-3",
    source: "ISRO",
    url: "https://www.isro.gov.in/chandrayaan-3",
    published_at: "2023-07-14 15:30:00",
    summary: "India's space agency successfully launches Chandrayaan-3 mission to explore the Moon's south pole.",
    category: "featured",
    image_url: "https://example.com/chandrayaan.jpg"
  },
  {
    title: "SpaceX Achieves 100th Successful Landing",
    source: "SpaceX",
    url: "https://www.spacex.com/news",
    published_at: "2024-02-20 14:15:00",
    summary: "SpaceX celebrates its 100th successful rocket landing, marking a major milestone in reusable rocket technology.",
    category: "featured",
    image_url: "https://example.com/spacex.jpg"
  },
  {
    title: "James Webb Telescope Discovers New Exoplanet",
    source: "NASA",
    url: "https://www.nasa.gov/jwst",
    published_at: "2024-03-10 09:45:00",
    summary: "The James Webb Space Telescope has discovered a potentially habitable exoplanet in a distant star system.",
    category: "featured",
    image_url: "https://example.com/jwst.jpg"
  },
  {
    title: "ESA's Ariane 6 Rocket Completes Final Tests",
    source: "ESA",
    url: "https://www.esa.int/ariane6",
    published_at: "2024-01-25 16:20:00",
    summary: "European Space Agency's new Ariane 6 rocket completes final testing phase before maiden flight.",
    category: "featured",
    image_url: "https://example.com/ariane6.jpg"
  }
]

news_articles.each do |news_data|
  News.create!(news_data)
end

puts "Created #{News.count} news articles"

# Seed Mission Failures Data
puts "Seeding Mission Failures..."

mission_failures_data = [
  # ISRO Failures
  {
    mission_name: "PSLV-D1 (1993)",
    failed_stage: "second_stage",
    notes: "Software bug in onboard guidance/control led to crash • ~12 mins after launch",
    failure_date: DateTime.parse("1993-09-20"),
    organization: "ISRO",
    failure_type: "software"
  },
  {
    mission_name: "GSLV-F06 / GSAT-5P (2010)",
    failed_stage: "first_stage",
    notes: "Launch unsuccessful",
    failure_date: DateTime.parse("2010-12-25"),
    organization: "ISRO",
    failure_type: "technical"
  },
  {
    mission_name: "GSLV-D3 / GSAT-4 (2010)",
    failed_stage: "unknown",
    notes: "Total mission failure",
    failure_date: DateTime.parse("2010-04-15"),
    organization: "ISRO",
    failure_type: "unknown"
  },
  {
    mission_name: "GSLV-F02 / INSAT-4C (2006)",
    failed_stage: "unspecified",
    notes: "Satellite not placed in orbit",
    failure_date: DateTime.parse("2006-07-10"),
    organization: "ISRO",
    failure_type: "technical"
  },
  {
    mission_name: "GSLV-F10 / EOS-03 (2021)",
    failed_stage: "onboard_abort",
    notes: "Abort by onboard computer",
    failure_date: DateTime.parse("2021-08-12"),
    organization: "ISRO",
    failure_type: "technical"
  },
  {
    mission_name: "PSLV-C61 / EOS-09 (2025)",
    failed_stage: "third_stage",
    notes: "Mid-flight abort; rare PSLV failure",
    failure_date: DateTime.parse("2025-01-01"),
    organization: "ISRO",
    failure_type: "technical"
  },
  {
    mission_name: "Chandrayaan-2 (2019)",
    failed_stage: "landing",
    notes: "Communication lost during braking/landing phase",
    failure_date: DateTime.parse("2019-09-07"),
    organization: "ISRO",
    failure_type: "communication"
  },
  {
    mission_name: "Chandrayaan-1 (2009)",
    failed_stage: "power_system",
    notes: "Mission ~95% successful despite early loss",
    failure_date: DateTime.parse("2009-08-29"),
    organization: "ISRO",
    failure_type: "power"
  },
  
  # NASA Failures
  {
    mission_name: "Mariner 1 (1962)",
    failed_stage: "post_launch",
    notes: "Software bug in guidance equations caused course deviation",
    failure_date: DateTime.parse("1962-07-22"),
    organization: "NASA",
    failure_type: "software"
  },
  {
    mission_name: "Glory (2011)",
    failed_stage: "fairing_separation",
    notes: "Carrier's fairing didn't separate → satellite re-entered atmosphere",
    failure_date: DateTime.parse("2011-03-04"),
    organization: "NASA",
    failure_type: "hardware"
  },
  {
    mission_name: "Surveyor 2 (1966)",
    failed_stage: "mid_course_correction",
    notes: "Crashed before lunar landing",
    failure_date: DateTime.parse("1966-09-22"),
    organization: "NASA",
    failure_type: "guidance"
  },
  {
    mission_name: "Surveyor 4 (1967)",
    failed_stage: "landing",
    notes: "Contact lost, likely explosion",
    failure_date: DateTime.parse("1967-07-14"),
    organization: "NASA",
    failure_type: "unknown"
  },
  {
    mission_name: "Apollo 13 (1970)",
    failed_stage: "mid_mission",
    notes: "Abort landing; safe return via Lunar Module backup systems",
    failure_date: DateTime.parse("1970-04-13"),
    organization: "NASA",
    failure_type: "hardware"
  }
]

mission_failures_data.each do |failure_data|
  MissionFailure.find_or_create_by(mission_name: failure_data[:mission_name]) do |failure|
    failure.assign_attributes(failure_data)
  end
end

puts "Mission Failures seeded successfully!"

# Seed Future Missions Data
puts "Seeding Future Missions..."

future_missions_data = [
  # ISRO Future Missions
  {
    mission_name: "Gaganyaan Vyommitra test (2025-12)",
    planned_stages: "Uncrewed test: expected to pass all stages to simulate human flight",
    organization: "ISRO",
    target_date: Date.parse("2025-12-01"),
    mission_type: "crewed_mission",
    description: "Uncrewed test flight for Gaganyaan human spaceflight program"
  },
  {
    mission_name: "NISAR (2025-07-30)",
    planned_stages: "Earth-observation satellite; pass through PSLV/GSLV launch stages",
    organization: "ISRO",
    target_date: Date.parse("2025-07-30"),
    mission_type: "satellite_launch",
    description: "Joint NASA-ISRO Earth observation satellite"
  },
  {
    mission_name: "Chandrayaan-4 (Sample Return)",
    planned_stages: "TBD—include lunar touch-down and return phases",
    organization: "ISRO",
    target_date: nil,
    mission_type: "lunar_mission",
    description: "Lunar sample return mission"
  },
  {
    mission_name: "Chandrayaan-5 (with JAXA rover)",
    planned_stages: "Future joint lunar mission; multi-stage landing and deployment",
    organization: "ISRO",
    target_date: nil,
    mission_type: "lunar_mission",
    description: "Joint ISRO-JAXA lunar exploration mission"
  }
]

future_missions_data.each do |mission_data|
  FutureMission.find_or_create_by(mission_name: mission_data[:mission_name]) do |mission|
    mission.assign_attributes(mission_data)
  end
end

puts "Future Missions seeded successfully!"

puts "Database seeding completed successfully!"
puts "Organizations: #{Organization.count}"
puts "Rockets: #{Rocket.count}"
puts "Satellites: #{Satellite.count}"
puts "Launches: #{Launch.count}"
puts "Launch-Satellite Associations: #{LaunchSatellite.count}"
puts "Mission-Rocket Associations: #{MissionRocket.count}"
puts "Mission-Satellite Associations: #{MissionSatellite.count}"
puts "News: #{News.count}"
puts "Space Statistics: #{SpaceStatistic.count}"
puts "Space Probes: #{SpaceProbe.count}"
puts "Launch Sites: #{LaunchSite.count}"
puts "Space Events: #{SpaceEvent.count}"
puts "Space Missions: #{SpaceMission.count}"
puts "Mission Milestones: #{MissionMilestone.count}"
puts "Mission Objectives: #{MissionObjective.count}"
puts "Crew Modules: #{CrewModule.count}"
puts "Astronauts: #{Astronaut.count}"
puts "Mission Failures: #{MissionFailure.count}"
puts "Future Missions: #{FutureMission.count}"

# Create admin user for development
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?