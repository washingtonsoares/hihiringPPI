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

ActiveRecord::Schema.define(version: 20150715135938) do

  create_table "admin_comments", force: true do |t|
    t.text     "comment"
    t.integer  "publication_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",      default: true
  end

  add_index "admin_comments", ["publication_id"], name: "index_admin_comments_on_publication_id", using: :btree
  add_index "admin_comments", ["user_id"], name: "index_admin_comments_on_user_id", using: :btree

  create_table "admin_dashboards", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "admin_friends", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user1"
    t.integer  "user2"
    t.boolean  "accept",     default: false
    t.boolean  "new",        default: false
    t.boolean  "rejected",   default: false
  end

  create_table "admin_institutions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "acronym"
  end

  create_table "admin_publications", force: true do |t|
    t.string   "title"
    t.text     "resume"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumb"
    t.string   "author"
    t.string   "video"
    t.string   "archive"
  end

  add_index "admin_publications", ["user_id"], name: "index_admin_publications_on_user_id", using: :btree

  create_table "admin_users_institutions", force: true do |t|
    t.integer  "user_id"
    t.integer  "institution_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users_institutions", ["institution_id"], name: "index_admin_users_institutions_on_institution_id", using: :btree
  add_index "admin_users_institutions", ["user_id"], name: "index_admin_users_institutions_on_user_id", using: :btree

  create_table "front_homes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "users_id"
    t.integer  "admin_publications_id"
    t.integer  "nota"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["admin_publications_id"], name: "index_ratings_on_admin_publications_id", using: :btree
  add_index "ratings", ["users_id"], name: "index_ratings_on_users_id", using: :btree

  create_table "users", force: true do |t|
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
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "username"
    t.string   "ocupation"
    t.integer  "idade"
    t.string   "faculdade"
    t.string   "curso"
    t.string   "avatar"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
