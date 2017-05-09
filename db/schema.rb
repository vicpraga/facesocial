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

ActiveRecord::Schema.define(version: 20170509071957) do

  create_table "friends", force: :cascade do |t|
    t.integer  "userA_id"
    t.integer  "userB_id"
    t.boolean  "estado",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "friends", ["userA_id"], name: "index_friends_on_userA_id"
  add_index "friends", ["userB_id"], name: "index_friends_on_userB_id"

  create_table "likes", force: :cascade do |t|
    t.string   "message"
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["message_id"], name: "index_likes_on_message_id"
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.text     "texto"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "notifications", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.integer  "message_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "notificationType"
    t.boolean  "visto",            default: false
  end

  add_index "notifications", ["message_id"], name: "index_notifications_on_message_id"
  add_index "notifications", ["receiver_id"], name: "index_notifications_on_receiver_id"
  add_index "notifications", ["sender_id"], name: "index_notifications_on_sender_id"

  create_table "sessions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shareds", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "message_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "shareds", ["message_id"], name: "index_shareds_on_message_id"
  add_index "shareds", ["user_id"], name: "index_shareds_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password"
    t.boolean  "admin",      default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

end
