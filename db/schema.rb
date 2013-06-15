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

ActiveRecord::Schema.define(:version => 20130615174352) do

  create_table "assists", :force => true do |t|
    t.integer  "flare_id"
    t.integer  "responder_id"
    t.boolean  "active"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "commmunications", :force => true do |t|
    t.integer  "flare_id"
    t.integer  "responder_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "flares", :force => true do |t|
    t.string   "srcphone"
    t.integer  "zip"
    t.string   "location"
    t.float    "lat"
    t.float    "long"
    t.string   "category"
    t.text     "description"
    t.boolean  "active"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "missing_people", :force => true do |t|
    t.string   "name"
    t.string   "contact_name"
    t.string   "contact_number"
    t.text     "description"
    t.boolean  "found"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "responders", :force => true do |t|
    t.string   "srcphone"
    t.string   "zip"
    t.float    "lat"
    t.float    "long"
    t.float    "radius"
    t.string   "active"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
