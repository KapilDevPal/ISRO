# Clear existing data
puts "Clearing existing data..."
Organization.destroy_all
Rocket.destroy_all
Satellite.destroy_all
Launch.destroy_all
News.destroy_all

# Create Organizations
puts "Creating organizations..."
spacex = Organization.create!(
  name: "SpaceX",
  country: "United States",
  type: "Private",
  description: "Space Exploration Technologies Corp. is an American aerospace manufacturer and space transportation services company.",
  website: "https://www.spacex.com",
  logo_url: "https://upload.wikimedia.org/wikipedia/commons/9/99/SpaceX_Logo_Black.png"
)

nasa = Organization.create!(
  name: "NASA",
  country: "United States",
  type: "Government",
  description: "The National Aeronautics and Space Administration is an independent agency of the U.S. federal government responsible for the civilian space program.",
  website: "https://www.nasa.gov",
  logo_url: "https://upload.wikimedia.org/wikipedia/commons/e/e5/NASA_logo.svg"
)

esa = Organization.create!(
  name: "European Space Agency",
  country: "Europe",
  type: "International",
  description: "The European Space Agency is an intergovernmental organisation dedicated to the exploration of space.",
  website: "https://www.esa.int",
  logo_url: "https://upload.wikimedia.org/wikipedia/en/6/6e/European_Space_Agency_logo.svg"
)

# Create Rockets
puts "Creating rockets..."
falcon9 = Rocket.create!(
  name: "Falcon 9",
  organization: spacex,
  mass: 549054,
  payload_capacity: 22800,
  height: 70.0,
  diameter: 3.7,
  stages: 2,
  description: "A two-stage rocket designed and manufactured by SpaceX for the reliable and safe transport of satellites and the Dragon spacecraft into orbit.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/e/eb/Bangabandhu_Satellite-1_Mission_%2842025499722%29.jpg",
  model_url: "https://models.readyplayer.me/64f7b8b8b8b8b8b8b8b8b8b8.glb",
  status: "active",
  first_flight: Date.parse("2010-06-04")
)

falcon_heavy = Rocket.create!(
  name: "Falcon Heavy",
  organization: spacex,
  mass: 1420788,
  payload_capacity: 63800,
  height: 70.0,
  diameter: 3.7,
  stages: 2,
  description: "A super heavy-lift launch vehicle designed and manufactured by SpaceX. It is derived from the Falcon 9 vehicle.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/2/27/Falcon_Heavy_Demo_Mission_%2842025499722%29.jpg",
  model_url: "https://models.readyplayer.me/64f7b8b8b8b8b8b8b8b8b8b9.glb",
  status: "active",
  first_flight: Date.parse("2018-02-06")
)

sls = Rocket.create!(
  name: "Space Launch System",
  organization: nasa,
  mass: 2600000,
  payload_capacity: 95000,
  height: 98.0,
  diameter: 8.4,
  stages: 2,
  description: "A super heavy-lift expendable launch vehicle developed by NASA for the Artemis program.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/1/1f/SLS_Artemis_1_rollout.jpg",
  model_url: "https://models.readyplayer.me/64f7b8b8b8b8b8b8b8b8b8ba.glb",
  status: "active",
  first_flight: Date.parse("2022-11-16")
)

# Create Satellites
puts "Creating satellites..."
starlink_1 = Satellite.create!(
  name: "Starlink-1",
  organization: spacex,
  mass: 260,
  height: 0.1,
  width: 0.5,
  depth: 0.5,
  purpose: "Broadband internet service",
  launch_date: Date.parse("2019-05-24"),
  orbit_type: "Low Earth Orbit",
  status: "active",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/8/8a/Starlink_satellite.jpg",
  model_url: "https://models.readyplayer.me/64f7b8b8b8b8b8b8b8b8b8bb.glb",
  description: "A satellite internet constellation operated by SpaceX providing satellite Internet access coverage to most of the Earth."
)

hubble = Satellite.create!(
  name: "Hubble Space Telescope",
  organization: nasa,
  mass: 11110,
  height: 13.2,
  width: 4.2,
  depth: 4.2,
  purpose: "Space observatory",
  launch_date: Date.parse("1990-04-24"),
  orbit_type: "Low Earth Orbit",
  status: "active",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/3/3f/HST-SM4.jpeg",
  model_url: "https://models.readyplayer.me/64f7b8b8b8b8b8b8b8b8b8bc.glb",
  description: "A space telescope that was launched into low Earth orbit in 1990 and remains in operation."
)

james_webb = Satellite.create!(
  name: "James Webb Space Telescope",
  organization: nasa,
  mass: 6200,
  height: 20.197,
  width: 14.162,
  depth: 8.5,
  purpose: "Space observatory",
  launch_date: Date.parse("2021-12-25"),
  orbit_type: "Sun-Earth L2",
  status: "active",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/7/7f/James_Webb_Space_Telescope.jpg",
  model_url: "https://models.readyplayer.me/64f7b8b8b8b8b8b8b8b8b8bd.glb",
  description: "A space telescope designed primarily to conduct infrared astronomy."
)

# Create Launches
puts "Creating launches..."
launch1 = Launch.create!(
  name: "Starlink Mission",
  rocket: falcon9,
  launch_date: 1.week.from_now,
  launch_site: "Kennedy Space Center, Florida",
  mission_objective: "Deploy 60 Starlink satellites to low Earth orbit",
  status: "scheduled",
  outcome: nil,
  image_url: "https://upload.wikimedia.org/wikipedia/commons/8/8a/Starlink_launch.jpg",
  webcast_url: "https://www.youtube.com/watch?v=example"
)

launch2 = Launch.create!(
  name: "Artemis I",
  rocket: sls,
  launch_date: 2.weeks.from_now,
  launch_site: "Kennedy Space Center, Florida",
  mission_objective: "Uncrewed test flight of the Orion spacecraft around the Moon",
  status: "scheduled",
  outcome: nil,
  image_url: "https://upload.wikimedia.org/wikipedia/commons/1/1f/Artemis_I_launch.jpg",
  webcast_url: "https://www.youtube.com/watch?v=example2"
)

launch3 = Launch.create!(
  name: "Falcon Heavy Demo Mission",
  rocket: falcon_heavy,
  launch_date: 1.month.ago,
  launch_site: "Kennedy Space Center, Florida",
  mission_objective: "Demonstrate Falcon Heavy capabilities with Tesla Roadster payload",
  status: "completed",
  outcome: "success",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/2/27/Falcon_Heavy_Demo_Mission.jpg",
  webcast_url: "https://www.youtube.com/watch?v=example3"
)

# Create Launch-Satellite associations
LaunchSatellite.create!(launch: launch1, satellite: starlink_1)
LaunchSatellite.create!(launch: launch2, satellite: james_webb)

# Create News
puts "Creating news..."
News.create!(
  title: "SpaceX Successfully Launches Starlink Mission",
  source: "SpaceX",
  url: "https://www.spacex.com/news/2023/starlink-launch",
  published_at: 1.day.ago,
  summary: "SpaceX successfully launched another batch of Starlink satellites, bringing the total constellation to over 4,000 satellites in orbit.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/8/8a/Starlink_launch.jpg",
  category: "launch"
)

News.create!(
  title: "NASA Announces New Mars Mission",
  source: "NASA",
  url: "https://www.nasa.gov/news/mars-mission-2024",
  published_at: 2.days.ago,
  summary: "NASA has announced plans for a new Mars mission scheduled for 2024, which will include advanced robotic exploration and sample return capabilities.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/0/02/OSIRIS_Mars_false_color.jpg",
  category: "mission"
)

News.create!(
  title: "James Webb Telescope Discovers New Exoplanet",
  source: "NASA",
  url: "https://www.nasa.gov/news/jwst-exoplanet-discovery",
  published_at: 3.days.ago,
  summary: "The James Webb Space Telescope has discovered a new Earth-like exoplanet orbiting a distant star, raising hopes for finding signs of life beyond our solar system.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/7/7f/James_Webb_Space_Telescope.jpg",
  category: "discovery"
)

News.create!(
  title: "ESA Plans New Lunar Mission",
  source: "European Space Agency",
  url: "https://www.esa.int/news/esa-lunar-mission-2025",
  published_at: 4.days.ago,
  summary: "The European Space Agency has announced plans for a new lunar mission in 2025, focusing on lunar resource exploration and potential future human settlement.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/3/3f/Moon.jpg",
  category: "mission"
)

News.create!(
  title: "Space Tourism Takes Off with Blue Origin",
  source: "Blue Origin",
  url: "https://www.blueorigin.com/news/tourism-launch",
  published_at: 5.days.ago,
  summary: "Blue Origin successfully completed another space tourism flight, taking civilian passengers to the edge of space for a brief weightless experience.",
  image_url: "https://upload.wikimedia.org/wikipedia/commons/4/4a/Blue_Origin_New_Shepard.jpg",
  category: "tourism"
)

puts "Seed data created successfully!"
puts "Created #{Organization.count} organizations"
puts "Created #{Rocket.count} rockets"
puts "Created #{Satellite.count} satellites"
puts "Created #{Launch.count} launches"
puts "Created #{News.count} news articles"
