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

ActiveRecord::Schema.define(version: 20160616110319) do

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
  end

  create_table "payments", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "amount",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "grade",      limit: 255
    t.string   "address",    limit: 255
    t.string   "phone",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "is_school",  limit: 255
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

  create_table "unit_concept_exercise_solutions", force: :cascade do |t|
    t.integer  "unit_concept_desc_id", limit: 4
    t.string   "code",                 limit: 255
    t.string   "file_name",            limit: 255
    t.string   "memo",                 limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ox",                   limit: 255
  end

  create_table "unit_concepts", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.string   "name",        limit: 255
    t.integer  "level",       limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "concept_id",  limit: 4
    t.integer  "grade",       limit: 4
    t.string   "exercise_yn", limit: 255
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

  create_table "user_types", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type",  limit: 255
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "location",               limit: 255
    t.string   "phone",                  limit: 255
    t.string   "user_name",              limit: 255
    t.string   "grade",                  limit: 255
    t.string   "study_level",            limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
