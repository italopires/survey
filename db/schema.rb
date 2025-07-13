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

ActiveRecord::Schema[8.0].define(version: 2025_07_13_165516) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "division_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["division_id"], name: "index_departments_on_division_id"
    t.index ["name"], name: "index_departments_on_name"
  end

  create_table "divisions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_divisions_on_name"
  end

  create_table "employee_answers", force: :cascade do |t|
    t.bigint "employee_id", null: false
    t.bigint "survey_id", null: false
    t.bigint "question_id", null: false
    t.bigint "question_option_id"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["employee_id", "survey_id", "question_id"], name: "index_unique_answer_per_employee_survey_question", unique: true
    t.index ["employee_id"], name: "index_employee_answers_on_employee_id"
    t.index ["question_id"], name: "index_employee_answers_on_question_id"
    t.index ["question_option_id"], name: "index_employee_answers_on_question_option_id"
    t.index ["survey_id"], name: "index_employee_answers_on_survey_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.string "personal_email"
    t.string "corporate_email"
    t.string "area"
    t.string "role"
    t.string "role_kind"
    t.string "location"
    t.string "company_tenure"
    t.integer "gender"
    t.string "generation"
    t.bigint "sub_team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["corporate_email"], name: "index_employees_on_corporate_email", unique: true
    t.index ["name"], name: "index_employees_on_name"
    t.index ["personal_email"], name: "index_employees_on_personal_email", unique: true
    t.index ["sub_team_id"], name: "index_employees_on_sub_team_id"
  end

  create_table "question_options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.integer "value", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_options_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "survey_id", null: false
    t.string "title", null: false
    t.integer "order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_questions_on_survey_id"
    t.index ["title"], name: "index_questions_on_title"
  end

  create_table "sub_teams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_sub_teams_on_name"
    t.index ["team_id"], name: "index_sub_teams_on_team_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.string "title", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_surveys_on_title"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "department_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_teams_on_department_id"
    t.index ["name"], name: "index_teams_on_name"
  end

  add_foreign_key "departments", "divisions"
  add_foreign_key "employee_answers", "employees"
  add_foreign_key "employee_answers", "question_options"
  add_foreign_key "employee_answers", "questions"
  add_foreign_key "employee_answers", "surveys"
  add_foreign_key "employees", "sub_teams"
  add_foreign_key "question_options", "questions"
  add_foreign_key "questions", "surveys"
  add_foreign_key "sub_teams", "teams"
  add_foreign_key "teams", "departments"
end
