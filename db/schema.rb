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

ActiveRecord::Schema.define(version: 20140728185013) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "clients", force: true do |t|
    t.string   "name",          default: ""
    t.string   "legacy_id",     default: ""
    t.string   "address1",      default: ""
    t.string   "address2",      default: ""
    t.string   "address_city",  default: ""
    t.string   "address_state", default: ""
    t.string   "address_zip",   default: ""
    t.string   "contact_name",  default: ""
    t.string   "contact_phone", default: ""
    t.string   "contact_email", default: ""
    t.string   "uri",           default: ""
    t.text     "notes",         default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deposit_batches", force: true do |t|
    t.integer  "employee_id"
    t.string   "batch_type",     default: ""
    t.date     "date"
    t.boolean  "deposited",      default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",       default: false
    t.string   "receipt_number", default: ""
  end

  create_table "donations", force: true do |t|
    t.integer  "legacy_id"
    t.integer  "supporter_id"
    t.integer  "shift_id"
    t.date     "date"
    t.string   "donation_type",                                   default: ""
    t.string   "source",                                          default: ""
    t.string   "campaign",                                        default: ""
    t.string   "sub_month",     limit: 1,                         default: ""
    t.integer  "sub_week",      limit: 2,                         default: 0
    t.decimal  "amount",                  precision: 8, scale: 2, default: 0.0
    t.boolean  "cancelled",                                       default: false
    t.text     "notes",                                           default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "donations", ["shift_id"], name: "index_donations_on_shift_id", using: :btree
  add_index "donations", ["supporter_id"], name: "index_donations_on_supporter_id", using: :btree

  create_table "employees", force: true do |t|
    t.integer  "user_id"
    t.string   "legacy_id",                                 default: ""
    t.string   "first_name",                                default: ""
    t.string   "last_name",                                 default: ""
    t.string   "email",                                     default: ""
    t.string   "phone",                                     default: ""
    t.string   "address1",                                  default: ""
    t.string   "address2",                                  default: ""
    t.string   "address_city",                              default: ""
    t.string   "address_state",                             default: ""
    t.string   "address_zip",                               default: ""
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
    t.text     "notes",                                     default: ""
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

  create_table "migration_errors", force: true do |t|
    t.integer  "record_id"
    t.string   "record_name", default: ""
    t.string   "message",     default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_profiles", force: true do |t|
    t.integer  "supporter_id"
    t.string   "cim_payment_profile_id", default: ""
    t.string   "payment_profile_type",   default: ""
    t.hstore   "details",                default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "payment_profiles", ["cim_payment_profile_id"], name: "index_payment_profiles_on_cim_payment_profile_id", using: :btree
  add_index "payment_profiles", ["supporter_id"], name: "index_payment_profiles_on_supporter_id", using: :btree

  create_table "payments", force: true do |t|
    t.integer  "donation_id"
    t.integer  "payment_profile_id"
    t.integer  "deposit_batch_id"
    t.string   "legacy_id",                                  default: ""
    t.string   "cim_transaction_id",                         default: ""
    t.string   "cim_auth_code",                              default: ""
    t.date     "deposited_at"
    t.string   "payment_type",                               default: ""
    t.boolean  "captured",                                   default: false
    t.boolean  "processed",                                  default: false
    t.decimal  "amount",             precision: 8, scale: 2, default: 0.0
    t.text     "notes",                                      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "receipt_sent_at"
  end

  add_index "payments", ["cim_auth_code"], name: "index_payments_on_cim_auth_code", using: :btree
  add_index "payments", ["cim_transaction_id"], name: "index_payments_on_cim_transaction_id", using: :btree
  add_index "payments", ["deposit_batch_id"], name: "index_payments_on_deposit_batch_id", using: :btree
  add_index "payments", ["donation_id"], name: "index_payments_on_donation_id", using: :btree
  add_index "payments", ["payment_profile_id"], name: "index_payments_on_payment_profile_id", using: :btree

  create_table "projects", force: true do |t|
    t.integer  "client_id"
    t.string   "legacy_id",  default: ""
    t.string   "name",       default: ""
    t.date     "start_date"
    t.date     "end_date"
    t.string   "desc",       default: ""
    t.text     "notes",      default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "sendy_lists", force: true do |t|
    t.integer  "supporter_type_id"
    t.string   "sendy_list_identifier", default: ""
    t.string   "name",                  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sendy_lists", ["sendy_list_identifier"], name: "index_sendy_lists_on_sendy_list_identifier", using: :btree
  add_index "sendy_lists", ["supporter_type_id"], name: "index_sendy_lists_on_supporter_type_id", using: :btree

  create_table "sendy_updates", force: true do |t|
    t.integer  "supporter_id"
    t.integer  "sendy_list_id"
    t.integer  "sendy_batch_id"
    t.string   "sendy_email",      default: ""
    t.string   "new_sendy_email",  default: ""
    t.string   "new_sendy_status", default: ""
    t.string   "action",           default: ""
    t.boolean  "success",          default: false
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sendy_updates", ["sendy_batch_id"], name: "index_sendy_updates_on_sendy_batch_id", using: :btree
  add_index "sendy_updates", ["sendy_list_id"], name: "index_sendy_updates_on_sendy_list_id", using: :btree
  add_index "sendy_updates", ["success"], name: "index_sendy_updates_on_success", using: :btree
  add_index "sendy_updates", ["supporter_id"], name: "index_sendy_updates_on_supporter_id", using: :btree

  create_table "shift_types", force: true do |t|
    t.string   "name",                                            default: ""
    t.decimal  "monthly_cc_multiplier",   precision: 8, scale: 2, default: 0.0
    t.decimal  "quarterly_cc_multiplier", precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shifts", force: true do |t|
    t.integer  "employee_id"
    t.integer  "field_manager_employee_id"
    t.integer  "shift_type_id"
    t.string   "legacy_id",                                         default: ""
    t.date     "date"
    t.time     "time_in"
    t.time     "time_out"
    t.integer  "break_time",                                        default: 0
    t.text     "notes",                                             default: ""
    t.decimal  "travel_reimb",              precision: 8, scale: 2, default: 0.0
    t.boolean  "cv_shift",                                          default: false
    t.boolean  "quota_shift",                                       default: false
    t.hstore   "products",                                          default: ""
    t.decimal  "reported_raised",           precision: 8, scale: 2, default: 0.0
    t.integer  "reported_total_yes",                                default: 0
    t.integer  "reported_cash_qty",                                 default: 0
    t.decimal  "reported_cash_amt",         precision: 8, scale: 2, default: 0.0
    t.integer  "reported_check_qty",                                default: 0
    t.decimal  "reported_check_amt",        precision: 8, scale: 2, default: 0.0
    t.integer  "reported_one_time_cc_qty",                          default: 0
    t.decimal  "reported_one_time_cc_amt",  precision: 8, scale: 2, default: 0.0
    t.integer  "reported_monthly_cc_qty",                           default: 0
    t.decimal  "reported_monthly_cc_amt",   precision: 8, scale: 2, default: 0.0
    t.integer  "reported_quarterly_cc_amt",                         default: 0
    t.decimal  "reported_quarterly_cc_qty", precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shifts", ["employee_id"], name: "index_shifts_on_employee_id", using: :btree
  add_index "shifts", ["field_manager_employee_id"], name: "index_shifts_on_field_manager_employee_id", using: :btree
  add_index "shifts", ["shift_type_id"], name: "index_shifts_on_shift_type_id", using: :btree

  create_table "supporters", force: true do |t|
    t.integer  "supporter_type_id"
    t.integer  "sendy_list_id"
    t.string   "legacy_id",         default: ""
    t.string   "external_id",       default: ""
    t.string   "cim_id",            default: ""
    t.string   "prefix",            default: ""
    t.string   "salutation",        default: ""
    t.string   "first_name",        default: ""
    t.string   "last_name",         default: ""
    t.string   "suffix",            default: ""
    t.string   "address1",          default: ""
    t.string   "address2",          default: ""
    t.string   "address_city",      default: ""
    t.string   "address_state",     default: ""
    t.string   "address_zip",       default: ""
    t.string   "address_county",    default: ""
    t.boolean  "address_bad",       default: false
    t.string   "email_1",           default: ""
    t.boolean  "email_1_bad",       default: false
    t.string   "email_2",           default: ""
    t.boolean  "email_2_bad",       default: false
    t.string   "phone_mobile",      default: ""
    t.boolean  "phone_mobile_bad",  default: false
    t.string   "phone_home",        default: ""
    t.boolean  "phone_home_bad",    default: false
    t.string   "phone_alt",         default: ""
    t.boolean  "phone_alt_bad",     default: false
    t.boolean  "do_not_mail",       default: false
    t.boolean  "do_not_call",       default: false
    t.boolean  "do_not_email",      default: false
    t.boolean  "keep_informed",     default: false
    t.integer  "vol_level",         default: 0
    t.string   "employer",          default: ""
    t.string   "occupation",        default: ""
    t.string   "source",            default: ""
    t.text     "notes",             default: ""
    t.string   "sendy_status",      default: ""
    t.datetime "sendy_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporters", ["cim_id"], name: "index_supporters_on_cim_id", using: :btree
  add_index "supporters", ["external_id"], name: "index_supporters_on_external_id", using: :btree
  add_index "supporters", ["sendy_list_id"], name: "index_supporters_on_sendy_list_id", using: :btree
  add_index "supporters", ["supporter_type_id"], name: "index_supporters_on_supporter_type_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "supporter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["supporter_id"], name: "index_taggings_on_supporter_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "task_types", force: true do |t|
    t.string "name", default: ""
    t.string "desc", default: ""
  end

  create_table "tasks", force: true do |t|
    t.integer  "shift_id"
    t.integer  "project_id"
    t.integer  "task_type_id"
    t.string   "legacy_id",                            default: ""
    t.string   "name",                                 default: ""
    t.decimal  "hours",        precision: 8, scale: 2, default: 0.0
    t.string   "desc",                                 default: ""
    t.text     "notes",                                default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id"], name: "index_tasks_on_project_id", using: :btree
  add_index "tasks", ["shift_id"], name: "index_tasks_on_shift_id", using: :btree
  add_index "tasks", ["task_type_id"], name: "index_tasks_on_task_type_id", using: :btree

end
