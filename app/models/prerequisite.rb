# frozen_string_literal: true

class Prerequisite < ApplicationRecord
  # Validations
  validates :course_id, :prereq_id, :equi_id, presence: true
  validates :course_id, uniqueness: { scope: %i[prereq_id equi_id] }
  validates :equi_id, numericality: { only_integer: true }

  # Prerequisites associations
  belongs_to :course, foreign_key: :course_id, class_name: 'Course'
  belongs_to :prereq, foreign_key: :prereq_id, class_name: 'Course'

  # method to map course pairs based on equi_id
  def self.map_course_pairs
    prerequisites = all.includes(:prereq)
  
    # return an empty hash if there are no prerequisites
    return {} if prerequisites.empty?
  
    # create a hash to map courses to their prerequisites by equi_id
    course_pairs = {}
  
    prerequisites.each do |prerequisite|
      course_id = prerequisite.course_id
      prereq_id = prerequisite.prereq_id
      equi_id = prerequisite.equi_id
  
      # initialize the array if it doesn't exist
      course_pairs[course_id] ||= {}
  
      # group prerequisites by equi_id
      course_pairs[course_id][equi_id] ||= []
      course_pairs[course_id][equi_id] << prereq_id
    end
  
    # format output with cnumber and ccode
    formatted_pairs = {}
    course_pairs.each do |course_id, grouped_prereqs|
      formatted_prereqs = grouped_prereqs.map do |equi_id, ids|
        # get cnumber and ccode instead of cname
        course_identifiers = ids.map do |id|
          course = Course.find(id)
          "#{course.ccode} #{course.cnumber}" # format as "cnumber ccode"
        end
        course_identifiers.length > 1 ? "#{course_identifiers.join(' or ')}" : course_identifiers.first
      end
  
      # include the course identifier for the main course
      main_course = Course.find(course_id)
      formatted_pairs["#{main_course.ccode} #{main_course.cnumber}"] = formatted_prereqs
    end
  
    formatted_pairs
  end
  
  
end
