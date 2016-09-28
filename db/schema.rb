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

ActiveRecord::Schema.define(version: 20160922100934) do

  create_table "admins", force: :cascade do |t|
    t.string   "name",                  limit: 255
    t.string   "email",                 limit: 255
    t.string   "password",              limit: 255
    t.string   "salt",                  limit: 255
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "org_name",              limit: 255
    t.string   "admin_type",            limit: 255
    t.integer  "school_id",             limit: 4
    t.string   "init_password_changed", limit: 255
  end

  create_table "blogs", force: :cascade do |t|
    t.string   "blog_type",  limit: 255
    t.string   "title",      limit: 255
    t.text     "content",    limit: 65535
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "admin_yn",   limit: 255
    t.string   "file_name",  limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "concept_exercises", force: :cascade do |t|
    t.integer "concept_id", limit: 4
    t.string  "file_name",  limit: 255
    t.string  "memo",       limit: 255
    t.string  "desc_type",  limit: 255
    t.string  "video",      limit: 255
    t.string  "link",       limit: 255
  end

  create_table "concepts", force: :cascade do |t|
    t.string   "category",     limit: 255
    t.string   "sub_category", limit: 255
    t.string   "concept_code", limit: 255
    t.string   "concept_name", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "exercise_yn",  limit: 255
    t.integer  "grade",        limit: 4
    t.integer  "level",        limit: 4
  end

  create_table "explanations", force: :cascade do |t|
    t.string   "code",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "unit_concept_id", limit: 4
    t.string   "file_name",       limit: 255
  end

  create_table "grade_unit_concepts", force: :cascade do |t|
    t.string   "grade",           limit: 255
    t.string   "chapter",         limit: 255
    t.string   "category",        limit: 255
    t.string   "sub_category",    limit: 255
    t.string   "code",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "name",            limit: 255
    t.integer  "unit_concept_id", limit: 4
    t.integer  "concept_id",      limit: 4
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "inicis_payments", force: :cascade do |t|
    t.string   "version",       limit: 255
    t.string   "mid",           limit: 255
    t.string   "oid",           limit: 255
    t.string   "good_name",     limit: 255
    t.decimal  "price",                     precision: 10
    t.decimal  "tax",                       precision: 10
    t.decimal  "tax_free",                  precision: 10
    t.string   "currency",      limit: 255
    t.string   "buyer_name",    limit: 255
    t.string   "buyer_tel",     limit: 255
    t.string   "buyer_email",   limit: 255
    t.string   "parent_email",  limit: 255
    t.float    "timestamp",     limit: 53
    t.string   "signature",     limit: 255
    t.string   "return_url",    limit: 255
    t.string   "m_key",         limit: 255
    t.string   "go_pay_method", limit: 255
    t.string   "offer_period",  limit: 255
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "payment_logs", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "pg",             limit: 255
    t.string   "result_code",    limit: 255
    t.string   "result_message", limit: 255
    t.text     "result_detail",  limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "moid",           limit: 255
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "amount",          limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id",         limit: 4
    t.string   "service_name",    limit: 255
    t.string   "payment_status",  limit: 255
    t.string   "oid",             limit: 255
    t.string   "pay_method",      limit: 255
    t.string   "paypal_token",    limit: 255
    t.string   "paypal_payer_id", limit: 255
    t.string   "pay_gateway",     limit: 255
    t.string   "currency",        limit: 255
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "unit_concept_id", limit: 4
    t.integer  "to_user_id",      limit: 4
    t.integer  "user_id",         limit: 4
    t.string   "title",           limit: 255
    t.text     "content",         limit: 65535
    t.string   "file_name",       limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "confirm_yn",      limit: 255
    t.integer  "like",            limit: 4
  end

  create_table "replies", force: :cascade do |t|
    t.integer  "question_id",     limit: 4
    t.integer  "user_id",         limit: 4
    t.text     "comment",         limit: 65535
    t.integer  "group_id",        limit: 4
    t.integer  "parent_reply_id", limit: 4
    t.integer  "depth",           limit: 4
    t.integer  "order_no",        limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "file_name",       limit: 255
  end

  add_index "replies", ["parent_reply_id"], name: "dddd", using: :btree

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "grade",      limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "is_school",  limit: 255
  end

  create_table "study_histories", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "unit_concept_id", limit: 4
    t.string   "segment",         limit: 255
    t.string   "status",          limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.integer  "study_count",     limit: 4,   default: 1
  end

  create_table "sub_categories", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "code",        limit: 255
    t.integer  "category_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "sub_units", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "code",       limit: 255
    t.integer  "unit_id",    limit: 4
    t.string   "grade",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "teachers", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "school_id",    limit: 4
    t.string   "confirm_yn",   limit: 255
    t.datetime "confirmed_at"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "confirmed_id", limit: 4
  end

  create_table "unit_concept_descs", force: :cascade do |t|
    t.integer  "unit_concept_id", limit: 4
    t.string   "file_name",       limit: 255
    t.string   "memo",            limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "desc_type",       limit: 255
    t.string   "video",           limit: 255
    t.string   "link",            limit: 255
  end

  create_table "unit_concept_exercise_histories", force: :cascade do |t|
    t.integer  "user_id",              limit: 4
    t.integer  "unit_concept_desc_id", limit: 4
    t.string   "ox",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_concept_exercise_solutions", force: :cascade do |t|
    t.integer  "unit_concept_desc_id", limit: 4
    t.string   "code",                 limit: 255
    t.string   "file_name",            limit: 255
    t.string   "memo",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ox",                   limit: 255
    t.integer  "link",                 limit: 4
  end

  create_table "unit_concept_self_evaluations", force: :cascade do |t|
    t.integer  "unit_concept_id", limit: 4
    t.string   "evaluation",      limit: 255
    t.string   "comment",         limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "user_id",         limit: 4
  end

  create_table "unit_concepts", force: :cascade do |t|
    t.string   "code",                    limit: 255
    t.string   "name",                    limit: 255
    t.integer  "level",                   limit: 4
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "concept_id",              limit: 4
    t.integer  "grade",                   limit: 4
    t.string   "exercise_yn",             limit: 255
    t.integer  "related_unit_concept_id", limit: 4
  end

  add_index "unit_concepts", ["code"], name: "index_unit_concepts_on_code", unique: true, using: :btree
  add_index "unit_concepts", ["concept_id", "code"], name: "index_unit_concepts_on_concept_id_and_code", unique: true, using: :btree

  create_table "units", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.string   "code",            limit: 255
    t.integer  "sub_category_id", limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "user_relations", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.integer  "related_user_id", limit: 4
    t.string   "relation_type",   limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "confirm_status",  limit: 255
    t.datetime "request_date",                null: false
    t.datetime "confirmed_at"
  end

  create_table "user_types", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type",  limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "location",               limit: 255
    t.string   "phone",                  limit: 255
    t.string   "user_name",              limit: 255
    t.string   "grade",                  limit: 255
    t.string   "study_level",            limit: 255
    t.integer  "join_channel_sales_id",  limit: 4
    t.integer  "school_id",              limit: 4
    t.string   "user_auth",              limit: 255
    t.datetime "expire_date"
    t.string   "user_img",               limit: 255
    t.text     "user_desc",              limit: 65535
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.string   "oauth_token",            limit: 255
    t.datetime "oauth_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
end
