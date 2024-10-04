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

# rubocop:disable Layout/LineLength
# This is here since it would be annoying to refactor and hard to read if we did

require 'csv'

# Data scraped using Scrapy
courses_csv = Rails.root.join('lib', 'data', 'courses.csv')
majors_csv = Rails.root.join('lib', 'data', 'majors.csv')
core_categories_csv = Rails.root.join('lib', 'data', 'core_categories.csv')
core_courses_csv = Rails.root.join('lib', 'data', 'core_courses.csv')

# Data manually scraped
major_courses_csv = Rails.root.join('lib', 'data', 'manual', 'major_courses.csv')
track_courses_csv = Rails.root.join('lib', 'data', 'manual', 'track_courses.csv')
tracks_csv = Rails.root.join('lib', 'data', 'manual', 'tracks.csv')

# Seed with courses
CSV.foreach(courses_csv, headers: true) do |row|
    Course.find_or_create_by(
        ccode: row['ccode'],
        cnumber: row['cnumber'],
        cname: row['cname'],
        description: row['description'],
        credit_hours: row['credit_hours'],
        lecture_hours: row['lecture_hours'],
        lab_hours: row['lab_hours'],
    )
end

# Seed with majors
CSV.foreach(majors_csv, headers: true) do |row|
    Major.find_or_create_by(
        mname: row['mname'],
        cname: row['cname'],
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
    major = Major.find_by(mname: "Computer Science")
    
    course_code = row['course_code']

    if row['course_number'].blank?
        last_dummy = Course.where(ccode: course_code).order(cnumber: :desc).first
        next_cnumber = last_dummy ? last_dummy.cnumber.to_i + 1 : 1
    else
        next_cnumber = 000
    end

    requirement = Course.find_or_create_by(
        ccode: course_code,
        cnumber: row['course_number'] || next_cnumber
    )
    DegreeRequirement.find_or_create_by(
        course: requirement,
        major: major,
        sem: row['rec_sem']
    )
end
