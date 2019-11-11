# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_11_10_233636) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "feed_arguments", primary_key: ["feed_id", "key"], force: :cascade do |t|
    t.integer "feed_id", null: false
    t.string "feed_type"
    t.string "key", null: false
    t.string "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feed_parameters", primary_key: ["feed_type", "key"], force: :cascade do |t|
    t.string "feed_type", null: false
    t.string "key", null: false
    t.string "value_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feed_types", primary_key: "name", id: :string, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "feeds", force: :cascade do |t|
    t.string "user_login"
    t.string "feed_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "game_participants", primary_key: ["game_id", "user_login"], force: :cascade do |t|
    t.integer "game_id", null: false
    t.string "user_login", null: false
    t.boolean "will_go", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "games", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.datetime "start_date", null: false
    t.datetime "end_date", null: false
    t.integer "limit_participants"
    t.string "state", default: "on_hold", null: false
    t.string "owner_user_login", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "societies", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.string "latitude", null: false
    t.string "longitude", null: false
    t.string "owner_user_login", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "society_phones", primary_key: ["society_id", "phone"], force: :cascade do |t|
    t.integer "society_id", null: false
    t.string "phone", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "society_ratings", primary_key: ["society_id", "user_login"], force: :cascade do |t|
    t.integer "society_id", null: false
    t.string "user_login", null: false
    t.float "rating", null: false
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_subscriptions", primary_key: ["team_initials", "user_login"], force: :cascade do |t|
    t.string "team_initials", null: false
    t.string "user_login", null: false
    t.string "role"
    t.datetime "joined_date"
    t.boolean "accepted"
    t.boolean "banned", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teams", primary_key: "initials", id: :string, force: :cascade do |t|
    t.string "name", null: false
    t.string "avatar"
    t.string "owner_user_login", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_followers", primary_key: ["user_login", "follower_user_login"], force: :cascade do |t|
    t.string "user_login", null: false
    t.string "follower_user_login", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", primary_key: "login", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "gender"
    t.date "birthday"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti", null: false
    t.string "avatar"
    t.integer "level", default: 1, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["jti"], name: "index_users_on_jti", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "feed_arguments", "feed_parameters", column: "feed_type", primary_key: "feed_type", name: "fk_feed_arguments_type_key"
  add_foreign_key "feed_arguments", "feeds", on_delete: :cascade
  add_foreign_key "feed_parameters", "feed_types", column: "feed_type", primary_key: "name", on_delete: :cascade
  add_foreign_key "feeds", "feed_types", column: "feed_type", primary_key: "name", on_delete: :cascade
  add_foreign_key "feeds", "users", column: "user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "game_participants", "games", on_delete: :cascade
  add_foreign_key "game_participants", "users", column: "user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "games", "users", column: "owner_user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "societies", "users", column: "owner_user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "society_phones", "societies", on_delete: :cascade
  add_foreign_key "society_ratings", "societies", on_delete: :cascade
  add_foreign_key "society_ratings", "users", column: "user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "team_subscriptions", "teams", column: "team_initials", primary_key: "initials", on_delete: :cascade
  add_foreign_key "team_subscriptions", "users", column: "user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "teams", "users", column: "owner_user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "user_followers", "users", column: "follower_user_login", primary_key: "login", on_delete: :cascade
  add_foreign_key "user_followers", "users", column: "user_login", primary_key: "login", on_delete: :cascade
end
