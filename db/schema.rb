# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180321160104) do

  create_table "badges", force: :cascade do |t|
    t.string "badge_name"
    t.string "requirements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "earned_badges", force: :cascade do |t|
    t.integer "badge_id"
    t.integer "player_id"
    t.datetime "date_earned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "player_id"
    t.string "description"
    t.datetime "event_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "sender_id"
    t.integer "receiver_id"
    t.string "priority"
    t.string "message"
    t.datetime "notified_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
  end

  create_table "player_calculations", force: :cascade do |t|
    t.integer "player_id"
    t.date "weak_of"
    t.float "sleep_average"
    t.float "hydration_average"
    t.float "stress_average"
    t.float "soreness_average"
    t.float "load_average"
    t.string "season"
    t.integer "season_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "practices", force: :cascade do |t|
    t.integer "team_id"
    t.integer "duration"
    t.integer "difficulty"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rostereds", force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "user_id"
    t.string "type"
    t.string "response"
    t.date "completed"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "session_load"
  end

  create_table "team_calculations", force: :cascade do |t|
    t.date "week_of"
    t.integer "sleep"
    t.integer "hydration"
    t.integer "stress"
    t.integer "load"
    t.integer "team_id"
    t.string "season"
    t.string "rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string "sport"
    t.string "gender"
    t.string "season"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "andrew_id"
    t.string "email"
    t.string "major"
    t.integer "phone"
    t.string "role"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
