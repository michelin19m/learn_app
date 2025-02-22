# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_25_192630) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.bigint "user_id", null: false
    t.json "answers"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["test_id"], name: "index_attempts_on_test_id"
    t.index ["user_id"], name: "index_attempts_on_user_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "name"
    t.bigint "resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_parts_on_resource_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "test_id", null: false
    t.string "content"
    t.string "correct_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "answer_options", default: [], array: true
    t.index ["test_id"], name: "index_questions_on_test_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.bigint "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_resources_on_skill_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_skills_on_user_id"
  end

  create_table "tests", force: :cascade do |t|
    t.datetime "scheduled_at"
    t.bigint "part_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["part_id"], name: "index_tests_on_part_id"
    t.index ["user_id"], name: "index_tests_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attempts", "tests"
  add_foreign_key "attempts", "users"
  add_foreign_key "parts", "resources"
  add_foreign_key "questions", "tests"
  add_foreign_key "resources", "skills"
  add_foreign_key "skills", "users"
  add_foreign_key "tests", "parts"
  add_foreign_key "tests", "users"
end
