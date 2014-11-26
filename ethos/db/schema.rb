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

ActiveRecord::Schema.define(version: 20141125225147) do

  create_table "activities", force: true do |t|
    t.integer  "user_id"
    t.string   "action"
    t.integer  "targetable_id"
    t.string   "targetable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["targetable_id", "targetable_type"], name: "index_activities_on_targetable_id_and_targetable_type"
  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "albums", force: true do |t|
    t.integer  "ideaboard_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "albums", ["ideaboard_id"], name: "index_albums_on_ideaboard_id"

  create_table "collaborations", force: true do |t|
    t.integer  "ideaboard_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "state"
  end

  add_index "collaborations", ["ideaboard_id"], name: "index_collaborations_on_ideaboard_id"
  add_index "collaborations", ["state"], name: "index_collaborations_on_state"

  create_table "documents", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "documents", ["user_id"], name: "index_documents_on_user_id"

  create_table "ideaboards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "#<ActiveRecord::ConnectionAdapters::TableDefinition:0x007ff0631b46c0>"
    t.string   "title"
    t.text     "description"
    t.integer  "user_id"
    t.integer  "document_id"
  end

  add_index "ideaboards", ["user_id"], name: "index_ideaboards_on_user_id"

  create_table "likes", force: true do |t|
    t.integer "ideaboard_id"
    t.integer "user_id"
    t.integer "like_id"
  end

  add_index "likes", ["ideaboard_id"], name: "index_likes_on_ideaboard_id"

  create_table "pictures", force: true do |t|
    t.integer  "album_id"
    t.integer  "ideaboard_id"
    t.string   "capton"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "asset_file_name"
    t.string   "asset_content_type"
    t.integer  "asset_file_size"
    t.datetime "asset_updated_at"
  end

  add_index "pictures", ["album_id"], name: "index_pictures_on_album_id"
  add_index "pictures", ["ideaboard_id"], name: "index_pictures_on_ideaboard_id"

  create_table "tags", force: true do |t|
    t.string   "name"
    t.integer  "tagable_id"
    t.string   "tagable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_skill",     default: false
  end

  add_index "tags", ["name"], name: "index_tags_on_name"
  add_index "tags", ["tagable_id", "tagable_type"], name: "index_tags_on_tagable_id_and_tagable_type"

  create_table "user_friendships", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "friend_id"
    t.string   "state"
  end

  add_index "user_friendships", ["friend_id"], name: "index_user_friendships_on_friend_id"
  add_index "user_friendships", ["state"], name: "index_user_friendships_on_state"
  add_index "user_friendships", ["user_id"], name: "index_user_friendships_on_user_id"

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
