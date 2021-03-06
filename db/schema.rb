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

ActiveRecord::Schema.define(version: 20160422023248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "board_shape"
    t.integer  "board_size"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
    t.integer  "players_count",            default: 0
    t.string   "state",                    default: "waiting_for_players"
    t.integer  "starting_player_position"
    t.integer  "turns_count",              default: 0
  end

  create_table "moves", force: :cascade do |t|
    t.integer  "turn_id"
    t.integer  "x"
    t.integer  "y"
    t.integer  "z"
    t.integer  "position"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "moves", ["turn_id"], name: "index_moves_on_turn_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "position"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "score",      default: 0
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id", using: :btree
  add_index "players", ["user_id"], name: "index_players_on_user_id", using: :btree

  create_table "turns", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.integer  "position"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "moves_count", default: 0
  end

  add_index "turns", ["game_id"], name: "index_turns_on_game_id", using: :btree
  add_index "turns", ["player_id"], name: "index_turns_on_player_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "avatar"
    t.string   "provider"
    t.string   "uid"
    t.string   "refresh_token"
    t.string   "access_token"
    t.datetime "expires_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
