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

ActiveRecord::Schema.define(version: 20180402213954) do

  create_table "badges", force: :cascade do |t|
    t.string "badge_name"
    t.string "requirements"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "badge_description"
  end

  create_table "earned_badges", force: :cascade do |t|
    t.integer "badge_id"
    t.integer "user_id"
    t.datetime "date_earned"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer "user_id"
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
    t.integer "user_id"
  end

  create_table "player_calculations", force: :cascade do |t|
    t.integer "user_id"
    t.float "sleep_average"
    t.float "hydration_average"
    t.float "soreness_average"
    t.float "load_average"
    t.string "season"
    t.integer "season_rank"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weekly_load"
    t.float "weekly_strain"
    t.float "life_stress_average"
    t.float "academic_stress_average"
    t.float "sleep_quality_average"
    t.float "hydration_quality_average"
    t.float "personal_performance_average"
    t.float "practice_difficulty_average"
    t.datetime "week_of"
  end

  create_table "practices", force: :cascade do |t|
    t.integer "team_id"
    t.integer "duration"
    t.integer "difficulty"
    t.datetime "practice_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "session_load"
  end

  create_table "surveys", force: :cascade do |t|
    t.integer "user_id"
    t.string "survey_type"
    t.datetime "completed_time"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "session_load"
    t.float "daily_load"
    t.float "daily_strain"
    t.float "monotony"
    t.float "hours_of_sleep"
    t.integer "quality_of_sleep"
    t.integer "academic_stress"
    t.integer "life_stress"
    t.integer "soreness"
    t.float "ounces_of_water_consumed"
    t.boolean "hydration_quality"
    t.integer "player_rpe_rating"
    t.integer "player_personal_performance"
    t.boolean "participated_in_full_practice"
    t.integer "minutes_participated"
    t.float "expected_session_load"
    t.integer "practice_id"
  end

  create_table "team_assignments", force: :cascade do |t|
    t.integer "team_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "active"
    t.datetime "date_added"
  end

  create_table "team_calculations", force: :cascade do |t|
    t.datetime "week_of"
    t.integer "team_id"
    t.string "season"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "weekly_load"
    t.float "sleep_average"
    t.float "hydration_average"
    t.float "soreness_average"
    t.float "load_average"
    t.float "weekly_strain"
    t.integer "season_rank"
    t.float "life_stress_average"
    t.float "academic_stress_average"
    t.float "sleep_quality_average"
    t.float "hydration_quality_average"
    t.float "practice_difficulty_average"
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
    t.string "phone"
    t.string "role"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "year"
  end

end
