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

ActiveRecord::Schema.define(:version => 20140330221818) do

  create_table "check_ins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.datetime "time_out"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "group_id"
    t.datetime "time_in"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.integer  "mod"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "place_id"
  end

  create_table "members", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "moderator_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "banned"
    t.integer  "banned_id"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "desc"
    t.string   "street"
    t.string   "city"
    t.integer  "zipcode"
    t.string   "hours"
    t.integer  "user_id"
    t.integer  "review_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "occupied"
    t.float    "lat"
    t.float    "lng"
    t.text     "photoref"
    t.integer  "group_id"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.text     "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.text     "fname"
    t.text     "lname"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "phone_num",       :limit => 8
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.text     "bio"
    t.text     "projects"
    t.string   "twitter"
    t.string   "website"
    t.boolean  "mentor"
    t.integer  "banned"
  end

end
