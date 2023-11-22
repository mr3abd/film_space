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

ActiveRecord::Schema[7.0].define(version: 2023_11_22_172359) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "directors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "filming_locations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "year"
    t.bigint "director_id", null: false
    t.bigint "actor_id", null: false
    t.bigint "filming_location_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["actor_id"], name: "index_movies_on_actor_id"
    t.index ["country_id"], name: "index_movies_on_country_id"
    t.index ["director_id"], name: "index_movies_on_director_id"
    t.index ["filming_location_id"], name: "index_movies_on_filming_location_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.bigint "user_id", null: false
    t.text "review"
    t.integer "stars"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["movie_id"], name: "index_reviews_on_movie_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "movies", "actors"
  add_foreign_key "movies", "countries"
  add_foreign_key "movies", "directors"
  add_foreign_key "movies", "filming_locations"
  add_foreign_key "reviews", "movies"
  add_foreign_key "reviews", "users"
end
