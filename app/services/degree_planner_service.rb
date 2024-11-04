# frozen_string_literal: true

# app/services/degree_planner_service.rb
# naive approach

class DegreePlannerService
  def initialize(student, emphasis_area)
    @student = student
    @major = student.major
    @emphasis_area = emphasis_area
    @planned_courses = []
    @semester_credits = Hash.new(0)
  end

  def generate_plan
    # Get all required and emphasis courses
    gather_all_courses

    # Distribute courses across semesters
    distribute_courses

    @planned_courses
  end

  private

  def gather_all_courses
    # Add required major courses
    add_required_courses

    # Add emphasis area courses if specified
    add_emphasis_courses if @emphasis_area.present?

    # Add electives to reach credit requirement
    add_elective_courses
  end

  def add_required_courses
    DegreeRequirement.includes(:course)
                     .where(major: @major)
                     .each do |req|
      @planned_courses << {
        course: req.course,
        semester: nil,
        required: true
      }
    end
  end

  def add_emphasis_courses
    emphasis = Emphasis.find_by(ename: normalize_emphasis_name(@emphasis_area))
    return unless emphasis

    # Get exactly 4 courses for the emphasis area
    CourseEmphasis.includes(:course)
                  .where(emphasis:)
                  .limit(4)
                  .each do |ec|
      next if @planned_courses.any? { |pc| pc[:course].id == ec.course.id }

      @planned_courses << {
        course: ec.course,
        semester: nil,
        required: false,
        is_emphasis: true
      }
    end
  end

  def add_elective_courses
    total_credits = @planned_courses.sum { |pc| pc[:course].credit_hours }
    credits_needed = 120 - total_credits

    return if credits_needed <= 0

    Course.where.not(id: @planned_courses.map { |pc| pc[:course].id })
          .order(:credit_hours)
          .each do |course|
      break if credits_needed <= 0

      @planned_courses << {
        course:,
        semester: nil,
        required: false
      }
      credits_needed -= course.credit_hours
    end
  end

  def distribute_courses
    assign_initial_semesters
    balance_semesters
  end

  def assign_initial_semesters
    # First, assign courses with no prerequisites to early semesters
    no_prereq_courses = @planned_courses.select { |course_info| has_no_prerequisites?(course_info[:course]) }
    no_prereq_courses.each_with_index do |course_info, index|
      course_info[:semester] = (index % 3) + 1 # Distribute across first 3 semesters
    end

    # Then assign remaining courses based on prerequisites
    remaining_courses = @planned_courses.select { |course_info| course_info[:semester].nil? }

    # Keep track of courses we couldn't place due to circular dependencies
    unplaced_courses = []

    remaining_courses.each do |course_info|
      semester = determine_earliest_possible_semester(course_info[:course])
      if semester <= 8
        course_info[:semester] = semester
      else
        unplaced_courses << course_info
      end
    end

    # Force-place any remaining courses that couldn't be placed due to circular dependencies
    unplaced_courses.each_with_index do |course_info, index|
      course_info[:semester] = (index % 4) + 5 # Distribute across later semesters
    end
  end

  def has_no_prerequisites?(course)
    Prerequisite.where(course:).empty?
  end

  def determine_earliest_possible_semester(course)
    prereqs = Prerequisite.where(course:)
    return 1 if prereqs.empty?

    # Find the latest semester among prerequisites
    max_prereq_semester = prereqs.map do |prereq|
      prereq_course_info = @planned_courses.find { |pc| pc[:course].id == prereq.prereq_id }
      prereq_course_info&.fetch(:semester, 1) || 1
    end.max

    max_prereq_semester + 1
  end

  def balance_semesters
    8.times do |semester|
      semester_num = semester + 1
      courses_in_semester = @planned_courses.select { |pc| pc[:semester] == semester_num }
      total_credits = courses_in_semester.sum { |pc| pc[:course].credit_hours }

      # Move courses to next semester if credits exceed maximum
      while total_credits > 18 && semester_num < 8
        course_to_move = courses_in_semester
                         .reject { |pc| pc[:required] }
                         .min_by { |pc| pc[:course].credit_hours }

        break unless course_to_move

        course_to_move[:semester] = semester_num + 1
        total_credits -= course_to_move[:course].credit_hours
        courses_in_semester.delete(course_to_move)

      end
    end
  end

  def prerequisites_met?(course, completed_courses)
    prereqs = Prerequisite.where(course:)
    return true if prereqs.empty?

    completed_course_ids = completed_courses.map { |cc| cc[:course].id }
    prereqs.all? { |prereq| completed_course_ids.include?(prereq.prereq_id) }
  end

  def normalize_emphasis_name(emphasis_area)
    case emphasis_area.to_s
    when 'data_science' then 'Data Science'
    when 'software_engineering' then 'Software Engineering'
    when 'cybersecurity' then 'Cybersecurity'
    else emphasis_area
    end
  end
end
