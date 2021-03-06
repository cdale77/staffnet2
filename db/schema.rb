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

ActiveRecord::Schema.define(version: 20171211013633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "data_reports", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "data_report_type_name",          default: ""
    t.string   "downloadable_file_file_name"
    t.string   "downloadable_file_content_type"
    t.integer  "downloadable_file_file_size"
    t.datetime "downloadable_file_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "data_reports", ["user_id"], name: "index_data_reports_on_user_id", using: :btree

  create_table "deposit_batches", force: :cascade do |t|
    t.integer  "employee_id"
    t.string   "batch_type",     limit: 255, default: ""
    t.date     "date"
    t.boolean  "deposited",                  default: false
    t.boolean  "approved",                   default: false
    t.string   "receipt_number", limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sub_month",                  default: ""
    t.string   "sub_week",                   default: ""
  end

  add_index "deposit_batches", ["employee_id"], name: "index_deposit_batches_on_employee_id", using: :btree

  create_table "donations", force: :cascade do |t|
    t.integer  "legacy_id"
    t.integer  "supporter_id"
    t.integer  "shift_id"
    t.date     "date"
    t.string   "donation_type",  limit: 255,                         default: ""
    t.string   "source",         limit: 255,                         default: ""
    t.string   "campaign",       limit: 255,                         default: ""
    t.string   "sub_month",      limit: 1,                           default: ""
    t.integer  "sub_week",       limit: 2,                           default: 0
    t.decimal  "amount",                     precision: 8, scale: 2, default: 0.0
    t.boolean  "cancelled",                                          default: false
    t.text     "notes",                                              default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "evolve_ed_fund",                                     default: false
  end

  add_index "donations", ["donation_type"], name: "index_donations_on_donation_type", using: :btree
  add_index "donations", ["evolve_ed_fund"], name: "index_donations_on_evolve_ed_fund", using: :btree
  add_index "donations", ["shift_id"], name: "index_donations_on_shift_id", using: :btree
  add_index "donations", ["sub_month"], name: "index_donations_on_sub_month", using: :btree
  add_index "donations", ["sub_week"], name: "index_donations_on_sub_week", using: :btree
  add_index "donations", ["supporter_id"], name: "index_donations_on_supporter_id", using: :btree

  create_table "duplicate_records", force: :cascade do |t|
    t.integer  "first_record_id"
    t.string   "additional_record_ids", default: [],    array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "resolved",              default: false
    t.string   "record_type_name",      default: "1"
  end

  add_index "duplicate_records", ["first_record_id"], name: "index_duplicate_records_on_first_record_id", using: :btree
  add_index "duplicate_records", ["resolved"], name: "index_duplicate_records_on_resolved", where: "(resolved = false)", using: :btree

  create_table "employees", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "legacy_id",                            limit: 255,                         default: ""
    t.string   "first_name",                           limit: 255,                         default: ""
    t.string   "last_name",                            limit: 255,                         default: ""
    t.string   "email",                                limit: 255,                         default: ""
    t.string   "phone",                                limit: 255,                         default: ""
    t.string   "address1",                             limit: 255,                         default: ""
    t.string   "address2",                             limit: 255,                         default: ""
    t.string   "address_city",                         limit: 255,                         default: ""
    t.string   "address_state",                        limit: 255,                         default: ""
    t.string   "address_zip",                          limit: 255,                         default: ""
    t.string   "title",                                limit: 255,                         default: ""
    t.decimal  "pay_hourly",                                       precision: 8, scale: 2, default: 0.0
    t.decimal  "pay_daily",                                        precision: 8, scale: 2, default: 0.0
    t.date     "hire_date"
    t.date     "term_date"
    t.string   "fed_filing_status",                    limit: 255,                         default: ""
    t.string   "ca_filing_status",                     limit: 255,                         default: ""
    t.integer  "fed_allowances",                                                           default: 0
    t.integer  "ca_allowances",                                                            default: 0
    t.date     "dob"
    t.string   "gender",                               limit: 255,                         default: ""
    t.boolean  "active",                                                                   default: true
    t.text     "notes",                                                                    default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "daily_quota",                                      precision: 8, scale: 2, default: 0.0
    t.decimal  "shifts_lifetime",                                  precision: 8, scale: 2, default: 0.0
    t.decimal  "shifts_this_pay_period",                           precision: 8, scale: 2, default: 0.0
    t.decimal  "shifts_this_week",                                 precision: 8, scale: 2, default: 0.0
    t.decimal  "fundraising_shifts_lifetime",                      precision: 8, scale: 2, default: 0.0
    t.decimal  "fundraising_shifts_this_pay_period",               precision: 8, scale: 2, default: 0.0
    t.decimal  "fundraising_shifts_this_week",                     precision: 8, scale: 2, default: 0.0
    t.decimal  "donations_lifetime",                               precision: 8, scale: 2, default: 0.0
    t.decimal  "donations_this_pay_period",                        precision: 8, scale: 2, default: 0.0
    t.decimal  "donations_this_week",                              precision: 8, scale: 2, default: 0.0
    t.decimal  "successful_donations_lifetime",                    precision: 8, scale: 2, default: 0.0
    t.decimal  "successful_donations_this_pay_period",             precision: 8, scale: 2, default: 0.0
    t.decimal  "successful_donations_this_week",                   precision: 8, scale: 2, default: 0.0
    t.decimal  "raised_lifetime",                                  precision: 8, scale: 2, default: 0.0
    t.decimal  "raised_this_pay_period",                           precision: 8, scale: 2, default: 0.0
    t.decimal  "raised_this_week",                                 precision: 8, scale: 2, default: 0.0
    t.decimal  "average_lifetime",                                 precision: 8, scale: 2, default: 0.0
    t.decimal  "average_this_pay_period",                          precision: 8, scale: 2, default: 0.0
    t.decimal  "average_this_week",                                precision: 8, scale: 2, default: 0.0
  end

  add_index "employees", ["active"], name: "index_employees_on_active", using: :btree
  add_index "employees", ["hire_date"], name: "index_employees_on_hire_date", using: :btree
  add_index "employees", ["term_date"], name: "index_employees_on_term_date", using: :btree
  add_index "employees", ["title"], name: "index_employees_on_title", using: :btree
  add_index "employees", ["user_id"], name: "index_employees_on_user_id", using: :btree

  create_table "full_contact_matches", force: :cascade do |t|
    t.integer  "supporter_id"
    t.json     "payload"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "full_contact_matches", ["supporter_id"], name: "index_full_contact_matches_on_supporter_id", using: :btree

  create_table "migration_errors", force: :cascade do |t|
    t.integer  "record_id"
    t.string   "record_name", limit: 255, default: ""
    t.string   "message",     limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paychecks", force: :cascade do |t|
    t.integer  "payroll_id"
    t.integer  "employee_id"
    t.date     "check_date"
    t.decimal  "shift_quantity",           precision: 8, scale: 2, default: 0.0
    t.decimal  "cv_shift_quantity",        precision: 8, scale: 2, default: 0.0
    t.decimal  "quota_shift_quantity",     precision: 8, scale: 2, default: 0.0
    t.decimal  "office_shift_quantity",    precision: 8, scale: 2, default: 0.0
    t.decimal  "sick_shift_quantity",      precision: 8, scale: 2, default: 0.0
    t.decimal  "vacation_shift_quantity",  precision: 8, scale: 2, default: 0.0
    t.decimal  "holiday_shift_quantity",   precision: 8, scale: 2, default: 0.0
    t.decimal  "total_deposit",            precision: 8, scale: 2, default: 0.0
    t.decimal  "old_buffer",               precision: 8, scale: 2, default: 0.0
    t.decimal  "new_buffer",               precision: 8, scale: 2, default: 0.0
    t.decimal  "total_pay",                precision: 8, scale: 2, default: 0.0
    t.decimal  "bonus",                    precision: 8, scale: 2, default: 0.0
    t.decimal  "travel_reimb",             precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes",                                            default: ""
    t.decimal  "gross_fundraising_credit", precision: 8, scale: 2, default: 0.0
    t.decimal  "credits",                  precision: 8, scale: 2, default: 0.0
    t.decimal  "docks",                    precision: 8, scale: 2, default: 0.0
    t.decimal  "total_quota",              precision: 8, scale: 2, default: 0.0
    t.decimal  "net_fundraising_credit",   precision: 8, scale: 2, default: 0.0
    t.decimal  "over_quota",               precision: 8, scale: 2, default: 0.0
    t.decimal  "temp_buffer",              precision: 8, scale: 2, default: 0.0
    t.decimal  "bonus_credit",             precision: 8, scale: 2, default: 0.0
    t.decimal  "total_salary",             precision: 8, scale: 2, default: 0.0
  end

  add_index "paychecks", ["check_date"], name: "index_paychecks_on_check_date", using: :btree
  add_index "paychecks", ["employee_id"], name: "index_paychecks_on_employee_id", using: :btree
  add_index "paychecks", ["payroll_id"], name: "index_paychecks_on_payroll_id", using: :btree

  create_table "payment_profiles", force: :cascade do |t|
    t.integer  "supporter_id"
    t.string   "cim_payment_profile_id", limit: 255, default: ""
    t.string   "payment_profile_type",   limit: 255, default: ""
    t.hstore   "details",                            default: {}
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "payment_profiles", ["cim_payment_profile_id"], name: "index_payment_profiles_on_cim_payment_profile_id", using: :btree
  add_index "payment_profiles", ["deleted_at"], name: "index_payment_profiles_on_deleted_at", using: :btree
  add_index "payment_profiles", ["supporter_id"], name: "index_payment_profiles_on_supporter_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "donation_id"
    t.integer  "payment_profile_id"
    t.integer  "deposit_batch_id"
    t.string   "legacy_id",          limit: 255,                         default: ""
    t.string   "cim_transaction_id", limit: 255,                         default: ""
    t.string   "cim_auth_code",      limit: 255,                         default: ""
    t.date     "deposited_at"
    t.string   "payment_type",       limit: 255,                         default: ""
    t.boolean  "captured",                                               default: false
    t.boolean  "processed",                                              default: false
    t.decimal  "amount",                         precision: 8, scale: 2, default: 0.0
    t.text     "notes",                                                  default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "receipt_sent_at"
  end

  add_index "payments", ["cim_auth_code"], name: "index_payments_on_cim_auth_code", using: :btree
  add_index "payments", ["cim_transaction_id"], name: "index_payments_on_cim_transaction_id", using: :btree
  add_index "payments", ["deposit_batch_id"], name: "index_payments_on_deposit_batch_id", using: :btree
  add_index "payments", ["donation_id"], name: "index_payments_on_donation_id", using: :btree
  add_index "payments", ["payment_profile_id"], name: "index_payments_on_payment_profile_id", using: :btree
  add_index "payments", ["payment_type"], name: "index_payments_on_payment_type", using: :btree

  create_table "payrolls", force: :cascade do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "check_quantity",                                       default: 0
    t.decimal  "shift_quantity",               precision: 8, scale: 2, default: 0.0
    t.decimal  "cv_shift_quantity",            precision: 8, scale: 2, default: 0.0
    t.decimal  "quota_shift_quantity",         precision: 8, scale: 2, default: 0.0
    t.decimal  "office_shift_quantity",        precision: 8, scale: 2, default: 0.0
    t.decimal  "sick_shift_quantity",          precision: 8, scale: 2, default: 0.0
    t.decimal  "holiday_shift_quantity",       precision: 8, scale: 2, default: 0.0
    t.decimal  "total_deposit",                precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "vacation_shift_quantity",      precision: 8, scale: 2, default: 0.0
    t.text     "notes",                                                default: ""
    t.decimal  "gross_fundraising_credit",     precision: 8, scale: 2, default: 0.0
    t.decimal  "net_fundraising_credit",       precision: 8, scale: 2, default: 0.0
    t.string   "paycheck_report_file_name"
    t.string   "paycheck_report_content_type"
    t.integer  "paycheck_report_file_size"
    t.datetime "paycheck_report_updated_at"
    t.string   "shift_report_file_name"
    t.string   "shift_report_content_type"
    t.integer  "shift_report_file_size"
    t.datetime "shift_report_updated_at"
  end

  add_index "payrolls", ["end_date"], name: "index_payrolls_on_end_date", using: :btree
  add_index "payrolls", ["start_date"], name: "index_payrolls_on_start_date", using: :btree

  create_table "sendy_lists", force: :cascade do |t|
    t.integer  "supporter_type_id"
    t.string   "sendy_list_identifier", limit: 255, default: ""
    t.string   "name",                  limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sendy_lists", ["name"], name: "index_sendy_lists_on_name", using: :btree
  add_index "sendy_lists", ["sendy_list_identifier"], name: "index_sendy_lists_on_sendy_list_identifier", using: :btree
  add_index "sendy_lists", ["supporter_type_id"], name: "index_sendy_lists_on_supporter_type_id", using: :btree

  create_table "sendy_updates", force: :cascade do |t|
    t.integer  "supporter_id"
    t.integer  "sendy_list_id"
    t.integer  "sendy_batch_id"
    t.string   "sendy_email",      limit: 255, default: ""
    t.string   "new_sendy_email",  limit: 255, default: ""
    t.string   "new_sendy_status", limit: 255, default: ""
    t.string   "action",           limit: 255, default: ""
    t.boolean  "success",                      default: false
    t.datetime "completed_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sendy_updates", ["sendy_batch_id"], name: "index_sendy_updates_on_sendy_batch_id", using: :btree
  add_index "sendy_updates", ["sendy_list_id"], name: "index_sendy_updates_on_sendy_list_id", using: :btree
  add_index "sendy_updates", ["success"], name: "index_sendy_updates_on_success", using: :btree
  add_index "sendy_updates", ["supporter_id"], name: "index_sendy_updates_on_supporter_id", using: :btree

  create_table "shift_types", force: :cascade do |t|
    t.string   "name",                    limit: 255,                         default: ""
    t.decimal  "monthly_cc_multiplier",               precision: 8, scale: 2, default: 0.0
    t.decimal  "quarterly_cc_multiplier",             precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "fundraising_shift",                                           default: false
    t.boolean  "quota_shift",                                                 default: true
    t.string   "workers_comp_type",       limit: 255,                         default: ""
  end

  add_index "shift_types", ["fundraising_shift"], name: "index_shift_types_on_fundraising_shift", using: :btree
  add_index "shift_types", ["name"], name: "index_shift_types_on_name", using: :btree
  add_index "shift_types", ["quota_shift"], name: "index_shift_types_on_quota_shift", using: :btree

  create_table "shifts", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "field_manager_employee_id"
    t.integer  "shift_type_id"
    t.string   "legacy_id",                 limit: 255,                         default: ""
    t.date     "date"
    t.time     "time_in"
    t.time     "time_out"
    t.integer  "break_time",                                                    default: 0
    t.text     "notes",                                                         default: ""
    t.decimal  "travel_reimb",                          precision: 8, scale: 2, default: 0.0
    t.hstore   "products",                                                      default: {}
    t.decimal  "reported_raised",                       precision: 8, scale: 2, default: 0.0
    t.integer  "reported_total_yes",                                            default: 0
    t.integer  "reported_cash_qty",                                             default: 0
    t.decimal  "reported_cash_amt",                     precision: 8, scale: 2, default: 0.0
    t.integer  "reported_check_qty",                                            default: 0
    t.decimal  "reported_check_amt",                    precision: 8, scale: 2, default: 0.0
    t.integer  "reported_one_time_cc_qty",                                      default: 0
    t.decimal  "reported_one_time_cc_amt",              precision: 8, scale: 2, default: 0.0
    t.integer  "reported_monthly_cc_qty",                                       default: 0
    t.decimal  "reported_monthly_cc_amt",               precision: 8, scale: 2, default: 0.0
    t.integer  "reported_quarterly_cc_amt",                                     default: 0
    t.decimal  "reported_quarterly_cc_qty",             precision: 8, scale: 2, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "paycheck_id"
    t.string   "site",                      limit: 255,                         default: ""
  end

  add_index "shifts", ["date"], name: "index_shifts_on_date", using: :btree
  add_index "shifts", ["employee_id"], name: "index_shifts_on_employee_id", using: :btree
  add_index "shifts", ["field_manager_employee_id"], name: "index_shifts_on_field_manager_employee_id", using: :btree
  add_index "shifts", ["paycheck_id"], name: "index_shifts_on_paycheck_id", using: :btree
  add_index "shifts", ["shift_type_id"], name: "index_shifts_on_shift_type_id", using: :btree

  create_table "supporter_types", force: :cascade do |t|
    t.string   "name",       limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "supporter_types", ["name"], name: "index_supporter_types_on_name", using: :btree

  create_table "supporters", force: :cascade do |t|
    t.integer  "supporter_type_id"
    t.integer  "sendy_list_id"
    t.string   "legacy_id",         limit: 255, default: ""
    t.string   "external_id",       limit: 255, default: ""
    t.string   "cim_id",            limit: 255, default: ""
    t.string   "prefix",            limit: 255, default: ""
    t.string   "salutation",        limit: 255, default: ""
    t.string   "first_name",        limit: 255, default: ""
    t.string   "last_name",         limit: 255, default: ""
    t.string   "suffix",            limit: 255, default: ""
    t.string   "address1",          limit: 255, default: ""
    t.string   "address2",          limit: 255, default: ""
    t.string   "address_city",      limit: 255, default: ""
    t.string   "address_state",     limit: 255, default: ""
    t.string   "address_zip",       limit: 255, default: ""
    t.string   "address_county",    limit: 255, default: ""
    t.boolean  "address_bad",                   default: false
    t.string   "email_1",           limit: 255, default: ""
    t.boolean  "email_1_bad",                   default: false
    t.string   "email_2",           limit: 255, default: ""
    t.boolean  "email_2_bad",                   default: false
    t.string   "phone_mobile",      limit: 255, default: ""
    t.boolean  "phone_mobile_bad",              default: false
    t.string   "phone_home",        limit: 255, default: ""
    t.boolean  "phone_home_bad",                default: false
    t.string   "phone_alt",         limit: 255, default: ""
    t.boolean  "phone_alt_bad",                 default: false
    t.boolean  "do_not_mail",                   default: false
    t.boolean  "do_not_call",                   default: false
    t.boolean  "do_not_email",                  default: false
    t.boolean  "keep_informed",                 default: false
    t.string   "employer",          limit: 255, default: ""
    t.string   "occupation",        limit: 255, default: ""
    t.string   "source",            limit: 255, default: ""
    t.text     "notes",                         default: ""
    t.string   "sendy_status",      limit: 255, default: ""
    t.datetime "sendy_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cim_customer_id",   limit: 255, default: ""
    t.string   "vol_level",         limit: 255, default: ""
    t.string   "spouse_name",       limit: 255, default: ""
    t.string   "prospect_group",    limit: 255, default: ""
    t.integer  "issue_knowledge",               default: 0
    t.boolean  "sustainer",                     default: false
  end

  add_index "supporters", ["cim_id"], name: "index_supporters_on_cim_id", using: :btree
  add_index "supporters", ["prospect_group"], name: "index_supporters_on_prospect_group", using: :btree
  add_index "supporters", ["sendy_list_id"], name: "index_supporters_on_sendy_list_id", using: :btree
  add_index "supporters", ["supporter_type_id"], name: "index_supporters_on_supporter_type_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "supporter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["supporter_id"], name: "index_taggings_on_supporter_id", using: :btree
  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "failed_attempts",                    default: 0
    t.string   "unlock_token",           limit: 255
    t.datetime "locked_at"
    t.string   "authentication_token",   limit: 255
    t.string   "role",                   limit: 255, default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "employee_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255, null: false
    t.integer  "item_id",                null: false
    t.string   "event",      limit: 255, null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
