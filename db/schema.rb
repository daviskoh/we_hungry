# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20131022144451) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ingredients", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playlist_foods", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_url"
  end

  create_table "unliked_foods", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name",                       null: false
    t.boolean  "vege",       default: false
    t.boolean  "vegan",      default: false
    t.boolean  "lactose",    default: false
    t.boolean  "nut",        default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_ingredients", force: true do |t|
    t.integer "user_id",                   null: false
    t.integer "ingredient_id",             null: false
    t.integer "pos_votes"
    t.integer "tot_votes",     default: 0
  end

  create_table "users_playlist_foods", force: true do |t|
    t.integer "user_id",          null: false
    t.integer "playlist_food_id", null: false
  end

  create_table "users_unliked_foods", force: true do |t|
    t.integer "user_id",         null: false
    t.integer "unliked_food_id", null: false
  end

end
