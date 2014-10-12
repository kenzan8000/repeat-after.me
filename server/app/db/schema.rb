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

ActiveRecord::Schema.define(version: 20140922052953) do

  create_table "record_titles", force: true do |t|
    t.string   "category_en"
    t.string   "category_jp"
    t.string   "text_en"
    t.string   "text_jp"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.string   "user_id"
    t.string   "record_title_id"
    t.string   "facebook_post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "facebook_user_id"
    t.string   "name"
    t.string   "profile_image_url"
    t.integer  "login_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
