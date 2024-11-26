# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Course [No dependencies]

# This is here since it would be annoying to refactor and hard to read if we did

# Data scraped using Scrapy
courses_csv = Rails.root.join('lib', 'data', 'courses.csv')
majors_csv = Rails.root.join('lib', 'data', 'majors.csv')
core_categories_csv = Rails.root.join('lib', 'data', 'core_categories.csv')
core_courses_csv = Rails.root.join('lib', 'data', 'core_courses.csv')

# Data manually scraped
major_courses_csv = Rails.root.join('lib', 'data', 'manual', 'major_courses.csv')
track_courses_csv = Rails.root.join('lib', 'data', 'manual', 'track_courses.csv')
tracks_csv = Rails.root.join('lib', 'data', 'manual', 'tracks.csv')
emphasis_csv = Rails.root.join('lib', 'data', 'manual', 'emphasis.csv')
emphasis_courses_csv = Rails.root.join('lib', 'data', 'manual', 'emphasis_courses.csv')

# Seed with courses
CSV.foreach(courses_csv, headers: true) do |row|
  Course.find_or_create_by(
    ccode: row['ccode'],
    cnumber: row['cnumber'],
    cname: row['cname'],
    description: row['description'],
    credit_hours: row['credit_hours'],
    lecture_hours: row['lecture_hours'],
    lab_hours: row['lab_hours']
  )
end

# Seed with majors
CSV.foreach(majors_csv, headers: true) do |row|
  Major.find_or_create_by(
    mname: row['mname'],
    cname: row['cname']
  )
end

# Seed with core categories
CSV.foreach(core_categories_csv, headers: true) do |row|
  CoreCategory.find_or_create_by(
    cname: row['core_categories']
  )
end

# Seed with tracks
CSV.foreach(tracks_csv, headers: true) do |row|
  Track.find_or_create_by(
    tname: row['track_name']
  )
end

# Seed with degree requirements for CSCE
CSV.foreach(major_courses_csv, headers: true) do |row|
  major = Major.find_by(mname: 'Computer Science')

  course_code = row['course_code']
  requirement = Course.find_or_create_by(
    ccode: course_code,
    cnumber: row['course_number']
  )
  DegreeRequirement.find_or_create_by(
    course: requirement,
    major:,
    sem: row['rec_sem']
  )
end

# Seed with track fulfilling courses
CSV.foreach(track_courses_csv, headers: true) do |row|
  CourseTrack.find_or_create_by(
    course: Course.find_or_create_by(ccode: row['course_code'], cnumber: row['course_number']),
    track: Track.find_or_create_by(tname: row['track_name'])
  )
end

# Seed with core fulfilling courses
CSV.foreach(core_courses_csv, headers: true) do |row|
  Course.find_or_create_by(
    ccode: row['course_code'],
    cnumber: row['course_number'],
    cname: row['course_title'],
    credit_hours: row['credit_hours']
  )
end

CSV.foreach(core_courses_csv, headers: true) do |row|
  CourseCoreCategory.find_or_create_by(
    course: Course.find_by(ccode: row['course_code'], cnumber: row['course_number']),
    core_category: CoreCategory.find_by(cname: row['category'])
  )
end

# Seed prerequisite table
CSV.foreach(courses_csv, headers: true) do |row|
  prereq_col = [row['prereq_1'], row['prereq_2'], row['prereq_3']]

  # If prereq_1 is blank, skip to the next iteration
  next if prereq_col[0].blank?

  # Create course record
  course = Course.find_or_create_by(
    ccode: row['ccode'],
    cnumber: row['cnumber']
  )

  def process_prerequisites(prereqs, course, equi_id)
    return if prereqs.blank?

    prereqs.split(';').each do |prereq|
      # Split by whitespace to separate ccode and cnumber
      ccode, cnumber = prereq.strip.split(' ', 2) # Split into ccode and cnumber

      # Find or create the prerequisite course
      prereq_course = Course.find_or_create_by(ccode:, cnumber:)

      # Create prerequisite record
      Prerequisite.find_or_create_by(
        course:,
        prereq: prereq_course,
        equi_id:
      )
    end
  end

  # Process each prerequisite
  prereq_col.each_with_index do |prereqs, index|
    process_prerequisites(prereqs, course, index + 1)
  end
end

# Seed with emphasis
CSV.foreach(emphasis_csv, headers: true) do |row|
  Emphasis.find_or_create_by(
    ename: row['ename']
  )
end

# Seed with emphasis fulfilling courses
CSV.foreach(emphasis_courses_csv, headers: true) do |row|
  Course.find_or_create_by(
    ccode: row['ccode'],
    cnumber: row['cnumber'],
    cname: row['cname'],
    credit_hours: row['credit_hours']
  )
end

CSV.foreach(emphasis_courses_csv, headers: true) do |row|
  CourseEmphasis.find_or_create_by(
    course: Course.find_by(ccode: row['ccode'], cnumber: row['cnumber']),
    emphasis: Emphasis.find_by(ename: row['ename'])
  )
end
