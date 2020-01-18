# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_18_063705) do

  create_table "users", force: :cascade do |t|
    t.string "login_id", null: false
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0, null: false
    t.string "name"
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
    t.index ["token"], name: "index_users_on_token", unique: true
  end

  create_table "workspace_emotions", force: :cascade do |t|
    t.integer "workspace_id"
    t.integer "emotion"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workspace_emotions_on_user_id"
    t.index ["workspace_id"], name: "index_workspace_emotions_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.string "xml"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "created_by", null: false
    t.boolean "share", default: false, null: false
    t.boolean "pin", default: false, null: false
    t.index ["created_by"], name: "index_workspaces_on_created_by"
    t.index ["pin"], name: "index_workspaces_on_pin"
  end

  add_foreign_key "workspace_emotions", "users"
  add_foreign_key "workspace_emotions", "workspaces"
end
