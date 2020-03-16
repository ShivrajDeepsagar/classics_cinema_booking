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

ActiveRecord::Schema.define(version: 20170328095307) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "coupons", force: :cascade do |t|
    t.string   "code"
    t.integer  "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "movie_name",                  null: false
    t.integer  "duration",                    null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "image_url",  default: "none"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "screening_id"
    t.integer  "user_id"
    t.boolean  "reserved"
    t.boolean  "paid"
    t.boolean  "active"
    t.integer  "show_num"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["screening_id"], name: "index_reservations_on_screening_id", using: :btree
    t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
  end

  create_table "screenings", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "theater_id"
    t.datetime "ondate"
    t.boolean  "first"
    t.boolean  "second"
    t.boolean  "third"
    t.boolean  "fourth"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "first_seats",  default: 100
    t.integer  "second_seats", default: 100
    t.integer  "third_seats",  default: 100
    t.integer  "fourth_seats", default: 100
    t.integer  "cost",                       null: false
    t.index ["movie_id"], name: "index_screenings_on_movie_id", using: :btree
    t.index ["theater_id"], name: "index_screenings_on_theater_id", using: :btree
  end

  create_table "seats", force: :cascade do |t|
    t.integer  "screening_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "reservation_id"
    t.integer  "user_id"
    t.string   "seat_details",   default: [],              array: true
    t.index ["reservation_id"], name: "index_seats_on_reservation_id", using: :btree
    t.index ["screening_id"], name: "index_seats_on_screening_id", using: :btree
    t.index ["user_id"], name: "index_seats_on_user_id", using: :btree
  end

  create_table "theaters", force: :cascade do |t|
    t.string   "theater_name",               null: false
    t.integer  "no_of_shows",  default: 4
    t.integer  "total_seates", default: 100
    t.string   "address"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "seat_id"
    t.integer  "reservation_id"
    t.integer  "screening_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["reservation_id"], name: "index_seat_reserved_on_reservations_id", using: :btree
    t.index ["screening_id"], name: "index_seat_reserved_on_screenings_id", using: :btree
    t.index ["seat_id"], name: "index_seat_reserved_on_seats_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                            null: false
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "gender",                          null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "admin",           default: false
  end

end
