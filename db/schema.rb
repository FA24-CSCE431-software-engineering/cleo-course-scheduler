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

ActiveRecord::Schema[7.2].define(version: 2024_10_26_203159) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "core_categories", force: :cascade do |t|
    t.string "cname", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_core_categories", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "core_category_id", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["core_category_id"], name: "index_course_core_categories_on_core_category_id"
    t.index ["course_id", "core_category_id", "year"], name: "idx_on_course_id_core_category_id_year_3c9f98d245", unique: true
    t.index ["course_id"], name: "index_course_core_categories_on_course_id"
  end

  create_table "course_emphases", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "emphasis_id", null: false
    t.integer "year", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "emphasis_id", "year"], name: "index_course_emphases_on_course_id_and_emphasis_id_and_year", unique: true
    t.index ["course_id"], name: "index_course_emphases_on_course_id"
    t.index ["emphasis_id"], name: "index_course_emphases_on_emphasis_id"
  end

  create_table "course_tracks", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "track_id", null: false
    t.integer "year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "track_id", "year"], name: "index_course_tracks_on_course_id_and_track_id_and_year", unique: true
    t.index ["course_id"], name: "index_course_tracks_on_course_id"
    t.index ["track_id"], name: "index_course_tracks_on_track_id"
  end

  create_table "courses", force: :cascade do |t|
    t.integer "cnumber"
    t.string "cname", limit: 255
    t.text "description"
    t.integer "credit_hours", default: 0
    t.integer "lecture_hours", default: 0
    t.integer "lab_hours", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "ccode", limit: 30
    t.index ["ccode", "cnumber"], name: "index_courses_on_ccode_and_cnumber", unique: true
  end

  create_table "courses_majors", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "major_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_courses_majors_on_course_id"
    t.index ["major_id"], name: "index_courses_majors_on_major_id"
  end

  create_table "courses_students", id: false, force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "student_id"
    t.index ["course_id"], name: "index_courses_students_on_course_id"
    t.index ["student_id"], name: "index_courses_students_on_student_id"
  end

  create_table "degree_requirements", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "major_id", null: false
    t.integer "year", null: false
    t.integer "sem", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "major_id", "year"], name: "index_degree_requirements_on_course_id_and_major_id_and_year", unique: true
    t.index ["course_id"], name: "index_degree_requirements_on_course_id"
    t.index ["major_id"], name: "index_degree_requirements_on_major_id"
  end

  create_table "emphases", force: :cascade do |t|
    t.string "ename", limit: 255, null: false
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
    t.bigint "course_id", null: false
    t.bigint "prereq_id", null: false
    t.integer "equi_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "prereq_id", "equi_id"], name: "index_prerequisites_on_course_id_and_prereq_id_and_equi_id", unique: true
    t.index ["course_id"], name: "index_prerequisites_on_course_id"
    t.index ["prereq_id"], name: "index_prerequisites_on_prereq_id"
  end

  create_table "student_courses", id: false, force: :cascade do |t|
    t.string "student_id", null: false
    t.bigint "course_id", null: false
    t.integer "sem", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.boolean "is_admin", default: false, null: false
    t.index ["email"], name: "index_student_logins_on_email", unique: true
  end

  create_table "students", primary_key: "google_id", id: :string, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "email", limit: 255
    t.integer "enrol_year"
    t.integer "enrol_semester"
    t.integer "grad_year"
    t.integer "grad_semester"
    t.bigint "major_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false, null: false
    t.bigint "track_id"
    t.bigint "emphasis_id"
    t.index ["emphasis_id"], name: "index_students_on_emphasis_id"
    t.index ["major_id"], name: "index_students_on_major_id"
    t.index ["track_id"], name: "index_students_on_track_id"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "tname", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "course_core_categories", "core_categories"
  add_foreign_key "course_core_categories", "courses"
  add_foreign_key "course_emphases", "courses"
  add_foreign_key "course_emphases", "emphases"
  add_foreign_key "course_tracks", "courses"
  add_foreign_key "course_tracks", "tracks"
  add_foreign_key "courses_majors", "courses"
  add_foreign_key "courses_majors", "majors"
  add_foreign_key "degree_requirements", "courses"
  add_foreign_key "degree_requirements", "majors"
  add_foreign_key "prerequisites", "courses"
  add_foreign_key "prerequisites", "courses", column: "prereq_id"
  add_foreign_key "student_courses", "students", primary_key: "google_id"
end
