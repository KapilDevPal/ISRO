# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_09_200140) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "astronaut_missions", force: :cascade do |t|
    t.bigint "astronaut_id", null: false
    t.bigint "space_mission_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["astronaut_id", "space_mission_id"], name: "index_astronaut_missions_unique", unique: true
    t.index ["astronaut_id"], name: "index_astronaut_missions_on_astronaut_id"
    t.index ["space_mission_id"], name: "index_astronaut_missions_on_space_mission_id"
  end

  create_table "astronauts", force: :cascade do |t|
    t.string "name", null: false
    t.string "nationality", null: false
    t.text "bio"
    t.string "image_url"
    t.string "status", default: "active"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nationality"], name: "index_astronauts_on_nationality"
    t.index ["organization_id"], name: "index_astronauts_on_organization_id"
    t.index ["status"], name: "index_astronauts_on_status"
  end

  create_table "launch_satellites", force: :cascade do |t|
    t.bigint "launch_id", null: false
    t.bigint "satellite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["launch_id"], name: "index_launch_satellites_on_launch_id"
    t.index ["satellite_id"], name: "index_launch_satellites_on_satellite_id"
  end

  create_table "launch_sites", force: :cascade do |t|
    t.string "name", null: false
    t.string "country", null: false
    t.float "latitude"
    t.float "longitude"
    t.integer "total_launches", default: 0
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country"], name: "index_launch_sites_on_country"
    t.index ["organization_id"], name: "index_launch_sites_on_organization_id"
    t.index ["total_launches"], name: "index_launch_sites_on_total_launches"
  end

  create_table "launches", force: :cascade do |t|
    t.string "name"
    t.bigint "rocket_id", null: false
    t.datetime "launch_date"
    t.string "launch_site"
    t.text "mission_objective"
    t.string "status"
    t.string "outcome"
    t.string "image_url"
    t.string "webcast_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.index ["rocket_id"], name: "index_launches_on_rocket_id"
  end

  create_table "mission_organizations", force: :cascade do |t|
    t.bigint "space_mission_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_mission_organizations_on_organization_id"
    t.index ["space_mission_id", "organization_id"], name: "index_mission_orgs_unique", unique: true
    t.index ["space_mission_id"], name: "index_mission_organizations_on_space_mission_id"
  end

  create_table "mission_rockets", force: :cascade do |t|
    t.bigint "space_mission_id", null: false
    t.bigint "rocket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["rocket_id"], name: "index_mission_rockets_on_rocket_id"
    t.index ["space_mission_id", "rocket_id"], name: "index_mission_rockets_unique", unique: true
    t.index ["space_mission_id"], name: "index_mission_rockets_on_space_mission_id"
  end

  create_table "mission_satellites", force: :cascade do |t|
    t.bigint "space_mission_id", null: false
    t.bigint "satellite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["satellite_id"], name: "index_mission_satellites_on_satellite_id"
    t.index ["space_mission_id", "satellite_id"], name: "index_mission_satellites_unique", unique: true
    t.index ["space_mission_id"], name: "index_mission_satellites_on_space_mission_id"
  end

  create_table "news", force: :cascade do |t|
    t.string "title"
    t.string "source"
    t.string "url"
    t.datetime "published_at"
    t.text "summary"
    t.string "image_url"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "country"
    t.string "type"
    t.text "description"
    t.string "website"
    t.string "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "founded_year"
  end

  create_table "rockets", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id", null: false
    t.decimal "mass"
    t.decimal "payload_capacity"
    t.decimal "height"
    t.decimal "diameter"
    t.integer "stages"
    t.text "description"
    t.string "image_url"
    t.string "model_url"
    t.string "status"
    t.date "first_flight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_rockets_on_organization_id"
  end

  create_table "satellites", force: :cascade do |t|
    t.string "name"
    t.bigint "organization_id", null: false
    t.decimal "mass"
    t.decimal "height"
    t.decimal "width"
    t.decimal "depth"
    t.text "purpose"
    t.date "launch_date"
    t.string "orbit_type"
    t.string "status"
    t.string "image_url"
    t.string "model_url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_satellites_on_organization_id"
  end

  create_table "space_event_organizations", force: :cascade do |t|
    t.bigint "space_event_id", null: false
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_space_event_organizations_on_organization_id"
    t.index ["space_event_id", "organization_id"], name: "index_space_event_orgs_unique", unique: true
    t.index ["space_event_id"], name: "index_space_event_organizations_on_space_event_id"
  end

  create_table "space_events", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "event_date", null: false
    t.string "category", default: "milestone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category"], name: "index_space_events_on_category"
    t.index ["event_date"], name: "index_space_events_on_event_date"
  end

  create_table "space_missions", force: :cascade do |t|
    t.string "name", null: false
    t.text "objective"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status", default: "planned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["start_date"], name: "index_space_missions_on_start_date"
    t.index ["status"], name: "index_space_missions_on_status"
  end

  create_table "space_probes", force: :cascade do |t|
    t.string "name", null: false
    t.string "target_destination", null: false
    t.datetime "launch_date"
    t.string "status", default: "active"
    t.text "discoveries"
    t.bigint "organization_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["launch_date"], name: "index_space_probes_on_launch_date"
    t.index ["organization_id"], name: "index_space_probes_on_organization_id"
    t.index ["status"], name: "index_space_probes_on_status"
  end

  create_table "space_statistics", force: :cascade do |t|
    t.integer "satellites_in_orbit", default: 0
    t.integer "active_astronauts", default: 0
    t.integer "launches_this_year", default: 0
    t.integer "reusable_landings", default: 0
    t.date "last_updated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "astronaut_missions", "astronauts"
  add_foreign_key "astronaut_missions", "space_missions"
  add_foreign_key "astronauts", "organizations"
  add_foreign_key "launch_satellites", "launches"
  add_foreign_key "launch_satellites", "satellites"
  add_foreign_key "launch_sites", "organizations"
  add_foreign_key "launches", "rockets"
  add_foreign_key "mission_organizations", "organizations"
  add_foreign_key "mission_organizations", "space_missions"
  add_foreign_key "mission_rockets", "rockets"
  add_foreign_key "mission_rockets", "space_missions"
  add_foreign_key "mission_satellites", "satellites"
  add_foreign_key "mission_satellites", "space_missions"
  add_foreign_key "rockets", "organizations"
  add_foreign_key "satellites", "organizations"
  add_foreign_key "space_event_organizations", "organizations"
  add_foreign_key "space_event_organizations", "space_events"
  add_foreign_key "space_probes", "organizations"
end
