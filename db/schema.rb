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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130408111038) do

  create_table "albums", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "photo_count"
    t.boolean  "global",         :default => false
    t.boolean  "all_brackts",    :default => false
    t.integer  "total_likes",    :default => 0
    t.integer  "total_comments", :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "photo_posts", :force => true do |t|
    t.integer  "user_id"
    t.string   "text"
    t.integer  "branched_id",    :default => 0
    t.boolean  "global",         :default => false
    t.boolean  "all_brackts",    :default => false
    t.integer  "photo_count"
    t.integer  "likes_count",    :default => 0
    t.integer  "comments_count", :default => 0
    t.integer  "branches_count", :default => 0
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "photo_temps", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "album_id",   :default => 0
    t.integer  "post_id",    :default => 0
    t.string   "photo_path"
    t.integer  "height"
    t.integer  "width"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "photo_temps", ["album_id"], :name => "index_photo_temps_on_album_id"
  add_index "photo_temps", ["post_id"], :name => "index_photo_temps_on_post_id"
  add_index "photo_temps", ["user_id"], :name => "index_photo_temps_on_user_id"

  create_table "photos", :force => true do |t|
    t.integer  "user_id",                       :null => false
    t.integer  "album_id",       :default => 0
    t.integer  "photo_post_id",  :default => 0
    t.string   "text"
    t.string   "photo_path"
    t.integer  "height"
    t.integer  "width"
    t.integer  "likes_count"
    t.integer  "comments_count"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "photos", ["album_id"], :name => "index_photos_on_album_id"
  add_index "photos", ["photo_post_id"], :name => "index_photos_on_photo_post_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

  create_table "statuses", :force => true do |t|
    t.integer  "user_id"
    t.string   "status"
    t.integer  "branched_id"
    t.boolean  "global"
    t.boolean  "all_brackts"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "photo_path",     :default => "0"
    t.integer  "image_height"
    t.integer  "image_width"
    t.integer  "likes_count",    :default => 0
    t.integer  "replies_count",  :default => 0
    t.integer  "branches_count", :default => 0
  end

  add_index "statuses", ["branched_id"], :name => "index_statuses_on_branched_id"
  add_index "statuses", ["user_id", "created_at"], :name => "index_statuses_on_author_id_and_created_at"

  create_table "user_verification_tokens", :force => true do |t|
    t.integer  "user_id",                              :null => false
    t.string   "email",                                :null => false
    t.string   "token",                                :null => false
    t.string   "verification_type",                    :null => false
    t.boolean  "confirmed",         :default => false
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "fullname"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "remember_token"
    t.boolean  "email_verified",  :default => false
  end

end
