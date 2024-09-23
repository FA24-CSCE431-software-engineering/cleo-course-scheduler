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

ActiveRecord::Schema[7.2].define(version: 2024_09_23_012932) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "core_categories", id: false, force: :cascade do |t|
    t.integer "crn", null: false
    t.string "cname", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crn", "cname"], name: "index_core_categories_on_crn_and_cname", unique: true
  end

  create_table "courses", primary_key: "crn", id: :serial, force: :cascade do |t|
    t.string "cname", limit: 255
    t.text "description"
    t.integer "credit_hours", default: 0
    t.integer "lecture_hours", default: 0
    t.integer "lab_hours", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ccode"
    t.integer "cnumber"
  end

  create_table "degree_requirements", id: false, force: :cascade do |t|
    t.bigint "major_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_degree_requirements_on_course_id"
    t.index ["major_id", "course_id"], name: "index_degree_requirements_on_major_id_and_course_id", unique: true
    t.index ["major_id"], name: "index_degree_requirements_on_major_id"
  end

  create_table "emphases", force: :cascade do |t|
    t.integer "crn", null: false
    t.string "ename", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crn", "ename"], name: "index_emphases_on_crn_and_ename", unique: true
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

  create_table "student_courses", force: :cascade do |t|
    t.bigint "student_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "uin"
    t.index ["course_id"], name: "index_student_courses_on_course_id"
    t.index ["student_id", "course_id"], name: "index_student_courses_on_student_id_and_course_id", unique: true
    t.index ["student_id"], name: "index_student_courses_on_student_id"
  end

  create_table "student_logins", force: :cascade do |t|
    t.string "email", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_student_logins_on_email", unique: true
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

  create_table "tracks", id: false, force: :cascade do |t|
    t.integer "crn", null: false
    t.string "tname", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crn", "tname"], name: "index_tracks_on_crn_and_tname", unique: true
  end

  add_foreign_key "core_categories", "courses", column: "crn", primary_key: "crn"
  add_foreign_key "degree_requirements", "courses", primary_key: "crn"
  add_foreign_key "degree_requirements", "majors"
  add_foreign_key "emphases", "courses", column: "crn", primary_key: "crn"
  add_foreign_key "student_courses", "courses", primary_key: "crn"
  add_foreign_key "student_courses", "students", primary_key: "uin"
  add_foreign_key "tracks", "courses", column: "crn", primary_key: "crn"
end
