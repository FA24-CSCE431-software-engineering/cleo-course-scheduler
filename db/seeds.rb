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