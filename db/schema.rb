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

ActiveRecord::Schema[7.2].define(version: 2024_09_16_231041) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", primary_key: "crn", id: :serial, force: :cascade do |t|
    t.string "cname", limit: 255
    t.text "description"
    t.integer "credit_hours", default: 0
    t.integer "lecture_hours", default: 0
    t.integer "lab_hours", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "emphases", force: :cascade do |t|
    t.string "ename", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "majors", force: :cascade do |t|
    t.string "mname", limit: 255
    t.string "cname", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mname", "cname"], name: "index_majors_on_mname_and_cname", unique: true
  end

  create_table "prerequisites", id: false, force: :cascade do |t|
    t.integer "course_crn"
    t.integer "prereq_crn"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_crn", "prereq_crn"], name: "index_prerequisites_on_course_crn_and_prereq_crn", unique: true
    t.index ["course_crn"], name: "index_prerequisites_on_course_crn"
    t.index ["prereq_crn"], name: "index_prerequisites_on_prereq_crn"
  end

  create_table "student_courses", id: false, force: :cascade do |t|
    t.integer "uin", null: false
    t.integer "crn", null: false
    t.index ["uin", "crn"], name: "index_student_courses_on_uin_and_crn", unique: true
  end

  create_table "students", primary_key: "uin", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255
    t.integer "enrol_year"
    t.integer "enrol_semester"
    t.integer "grad_year"
    t.integer "grad_semester"
    t.integer "major_id"
    t.integer "degree_plan_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tracks", force: :cascade do |t|
    t.string "tname", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "student_courses", "courses", column: "crn", primary_key: "crn"
  add_foreign_key "student_courses", "students", column: "uin", primary_key: "uin"
end
