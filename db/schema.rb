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

ActiveRecord::Schema.define(version: 20141204150532) do

  create_table "customers", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "address"
    t.string   "organization"
    t.string   "district"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.string   "name"
    t.string   "code_cn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_customers", id: false, force: true do |t|
    t.integer  "project_id"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_samples", force: true do |t|
    t.integer  "project_id"
    t.integer  "sample_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "acc"
    t.date     "start_date"
    t.date     "deadline"
    t.string   "creater"
    t.integer  "creater_id"
    t.string   "salesman"
    t.integer  "salesman_id"
    t.date     "samples_received_date"
    t.string   "samples_receiver"
    t.integer  "samples_receiver_id"
    t.date     "experiments_done_date"
    t.string   "experimenter"
    t.integer  "experimenter_id"
    t.date     "analysis_done_date"
    t.string   "bioinformatician"
    t.integer  "bioinformatician_id"
    t.date     "report_sent_date"
    t.string   "report_sender"
    t.string   "report_sender_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "role_users", id: false, force: true do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "role_users", ["role_id"], name: "index_role_users_on_role_id"
  add_index "role_users", ["user_id"], name: "index_role_users_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "samples", force: true do |t|
    t.string   "name"
    t.date     "received_date"
    t.string   "receiver"
    t.integer  "receiver_id"
    t.string   "express_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_projects", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "project_id"
    t.string  "role_name"
  end

  add_index "user_projects", ["project_id"], name: "index_user_projects_on_project_id"
  add_index "user_projects", ["user_id"], name: "index_user_projects_on_user_id"

  create_table "users", force: true do |t|
    t.string   "name"
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
    t.string   "phone"
    t.text     "jd"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
