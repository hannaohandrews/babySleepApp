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

ActiveRecord::Schema[7.0].define(version: 2023_09_15_050229) do
  create_table "calculations", force: :cascade do |t|
    t.time "wake_up_time"
    t.time "bedtime"
    t.time "nap1"
    t.time "nap2"
    t.time "nap3"
    t.time "nap4"
    t.time "nap5"
    t.integer "awake_window"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "naps", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.integer "age"
    t.time "wake_up_time"
    t.time "bedtime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "calculated_schedule"
  end

  create_table "results", force: :cascade do |t|
    t.time "wake_up_time"
    t.time "nap1"
    t.time "nap2"
    t.time "nap3"
    t.time "nap4"
    t.time "nap5"
    t.time "bedtime"
    t.integer "suggested_awake_window"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
