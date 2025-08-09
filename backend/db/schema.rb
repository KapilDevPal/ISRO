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

ActiveRecord::Schema[8.0].define(version: 2025_08_09_181105) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "launch_satellites", force: :cascade do |t|
    t.bigint "launch_id", null: false
    t.bigint "satellite_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["launch_id"], name: "index_launch_satellites_on_launch_id"
    t.index ["satellite_id"], name: "index_launch_satellites_on_satellite_id"
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
    t.index ["rocket_id"], name: "index_launches_on_rocket_id"
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

  add_foreign_key "launch_satellites", "launches"
  add_foreign_key "launch_satellites", "satellites"
  add_foreign_key "launches", "rockets"
  add_foreign_key "rockets", "organizations"
  add_foreign_key "satellites", "organizations"
end
