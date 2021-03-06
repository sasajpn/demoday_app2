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

ActiveRecord::Schema.define(version: 20170205094758) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.string   "given_name",   limit: 255
    t.string   "family_name",  limit: 255
    t.string   "postal_code",  limit: 255
    t.string   "prefecture",   limit: 255
    t.string   "municipality", limit: 255
    t.string   "street",       limit: 255
    t.string   "building",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "areas", force: :cascade do |t|
    t.integer  "prefecture_id", limit: 4
    t.string   "postal_code",   limit: 255
    t.string   "municipality",  limit: 255
    t.string   "street",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "areas", ["prefecture_id"], name: "index_areas_on_prefecture_id", using: :btree

  create_table "book_addresses", force: :cascade do |t|
    t.integer  "book_id",      limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "given_name",   limit: 255
    t.string   "family_name",  limit: 255
    t.string   "postal_code",  limit: 255
    t.string   "prefecture",   limit: 255
    t.string   "municipality", limit: 255
    t.string   "street",       limit: 255
    t.string   "building",     limit: 255
  end

  add_index "book_addresses", ["book_id"], name: "index_book_addresses_on_book_id", using: :btree

  create_table "books", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "title",      limit: 255
    t.string   "author",     limit: 255
    t.string   "image",      limit: 255
    t.integer  "condition",  limit: 4
    t.integer  "status",     limit: 1,   default: 0, null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "books", ["user_id", "title", "author"], name: "index_books_on_user_id_and_title_and_author", unique: true, using: :btree
  add_index "books", ["user_id"], name: "index_books_on_user_id", using: :btree

  create_table "deadlines", force: :cascade do |t|
    t.integer  "book_id",    limit: 4
    t.datetime "deadline"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "deadlines", ["book_id"], name: "index_deadlines_on_book_id", using: :btree

  create_table "evals", force: :cascade do |t|
    t.integer  "evaluatee_id", limit: 4
    t.integer  "evaluator_id", limit: 4
    t.integer  "level",        limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "negotiates", force: :cascade do |t|
    t.integer  "parent_id",  limit: 4
    t.integer  "child_id",   limit: 4
    t.text     "recommend",  limit: 65535
    t.boolean  "agree",                    default: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "prefectures", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",               limit: 255
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.date     "birthday"
    t.integer  "icon",                   limit: 4
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "addresses", "users"
  add_foreign_key "areas", "prefectures"
  add_foreign_key "book_addresses", "books"
  add_foreign_key "books", "users"
  add_foreign_key "deadlines", "books"
end
