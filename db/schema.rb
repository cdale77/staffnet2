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

ActiveRecord::Schema.define(version: 20131204002737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: true do |t|
    t.string   "name",          default: ""
    t.string   "address1",      default: ""
    t.string   "address2",      default: ""
    t.string   "city",          default: ""
    t.string   "state",         default: ""
    t.string   "zip",           default: ""
    t.string   "contact_name",  default: ""
    t.string   "contact_phone", default: ""
    t.string   "contact_email", default: ""
    t.string   "uri",           default: ""
    t.text     "notes",         default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: true do |t|
    t.integer  "user_id"
    t.string   "first_name",                                default: ""
    t.string   "last_name",                                 default: ""
    t.string   "email",                                     default: ""
    t.string   "phone",                                     default: ""
    t.string   "address1",                                  default: ""
    t.string   "address2",                                  default: ""
    t.string   "city",                                      default: ""
    t.string   "state",                                     default: ""
    t.string   "zip",                                       default: ""
    t.string   "title",                                     default: ""
    t.decimal  "pay_hourly",        precision: 8, scale: 2, default: 0.0
    t.decimal  "pay_daily",         precision: 8, scale: 2, default: 0.0
    t.date     "hire_date"
    t.date     "term_date"
    t.string   "fed_filing_status",                         default: ""
    t.string   "ca_filing_status",                          default: ""
    t.integer  "fed_allowances",                            default: 0
    t.integer  "ca_allowances",                             default: 0
    t.date     "dob"
    t.string   "gender",                                    default: ""
    t.boolean  "active",                                    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employees", ["active"], name: "index_employees_on_active", using: :btree
  add_index "employees", ["email"], name: "index_employees_on_email", using: :btree
  add_index "employees", ["hire_date"], name: "index_employees_on_hire_date", using: :btree
  add_index "employees", ["last_name"], name: "index_employees_on_last_name", using: :btree
  add_index "employees", ["phone"], name: "index_employees_on_phone", using: :btree
  add_index "employees", ["term_date"], name: "index_employees_on_term_date", using: :btree
  add_index "employees", ["title"], name: "index_employees_on_title", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "client_id"
    t.string   "name",       default: ""
    t.date     "start_date"
    t.date     "end_date"
    t.string   "desc",       default: ""
    t.text     "notes",      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "shift_types", force: true do |t|
    t.string   "shift_type", default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shift_types", ["shift_type"], name: "index_shift_types_on_shift_type", using: :btree

  create_table "shifts", force: true do |t|
    t.integer  "employee_id"
    t.integer  "shift_type_id"
    t.date     "date"
    t.time     "time_in"
    t.time     "time_out"
    t.integer  "break_time",                            default: 0
    t.text     "notes",                                 default: ""
    t.decimal  "travel_reimb",  precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shifts", ["date"], name: "index_shifts_on_date", using: :btree
  add_index "shifts", ["employee_id"], name: "index_shifts_on_employee_id", using: :btree
  add_index "shifts", ["shift_type_id"], name: "index_shifts_on_shift_type_id", using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "shift_id"
    t.integer  "project_id"
    t.string   "name",                               default: ""
    t.decimal  "hours",      precision: 8, scale: 2, default: 0.0
    t.string   "desc",                               default: ""
    t.text     "notes",                              default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["shift_id"], name: "index_tasks_on_shift_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "role",                   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

end
