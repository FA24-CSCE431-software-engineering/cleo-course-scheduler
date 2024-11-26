# frozen_string_literal: true

# app/services/degree_planner_service.rb
# naive approach

class DegreePlannerService
  def initialize(student, emphasis_area, track_area)
    @student = student
    @track_area = track_area
    @emphasis_area = emphasis_area
    @courses = []
    @semester_credits = Hash.new(0)

    @category_min = {
      'Creative Arts' => 1,
      'Social and Behavioral Sciences' => 1,
      'American History' => 2,
      'Government/Political Science' => 2
    }
  end

  def generate_plan
    # Get all required and emphasis courses
    search_courses
    @courses
  end

  private

  def group_requirements_by_type(degree_requirements)
    degree_requirements.group_by do |record|
      case record.course.ccode
      when 'UCC Elective'
        :ucc_elective
      when 'Science Elective'
        :science_elective
      when 'General Elective'
        :general_elective
      when 'Emphasis Area Elective'
        :emphasis_elective
      when 'Computer Science Elective'
        :cs_elective
      else
        :compulsory
      end
    end
  end

  def search_courses
    degree_requirements = DegreeRequirement.where(major_id: @student.major_id)
    grouped_requirements = group_requirements_by_type(degree_requirements)

    # Add all compulsory degree requirements
    grouped_requirements[:compulsory].each do |record|
      @courses << { course_id: record.course_id, sem: record.sem }
    end

    add_ucc_courses(grouped_requirements[:ucc_elective])
    add_emphasis_courses(grouped_requirements[:emphasis_elective])
    add_track_courses(grouped_requirements[:cs_elective])
    add_general_courses(grouped_requirements[:general_elective])
    add_science_courses(grouped_requirements[:science_elective])
  end

  def add_ucc_courses(ucc_elective)
    category_count = Hash.new(0)

    # Fulfills the minimum requirements from each core category
    @category_min.each do |category, min_courses|
      core_category = CoreCategory.find_by(cname: category)
      courses_core_category = CourseCoreCategory.where(core_category_id: core_category.id)
      ordered_eligible_courses = order_min_prereqs('course_core_categories', 'core_category_id', courses_core_category)

      ordered_eligible_courses.each do |course_core_category|
        break if category_count[category] >= min_courses

        course_id = course_core_category.course_id
        elective = ucc_elective[category_count.values.sum]

        unless @courses.any? { |c| c[:course_id] == course_id }
          @courses << { course_id:, sem: elective.sem }
          category_count[category] += 1
        end
      end
    end

    # Select courses outside of the minimum requirements i.e. leftover slots
    num_courses_left = ucc_elective.size - 6
    all_courses = order_min_prereqs('course_core_categories', 'core_category_id', CourseCoreCategory.all)

    all_courses.each do |course_core_category|
      break if num_courses_left <= 0

      course_id = course_core_category.course_id
      elective = ucc_elective[category_count.values.sum]

      next if @courses.any? { |c| c[:course_id] == course_id }

      @courses << { course_id:, sem: elective.sem }
      category_count['Creative Arts'] += 1
      num_courses_left -= 1
    end
  end

  def add_emphasis_courses(emphasis_elective)
    if @emphasis_area
      emphasis_id = Emphasis.where(ename: @emphasis_area)
      eligible_courses = CourseEmphasis.where(emphasis_id:)
      ordered_eligible_courses = order_min_prereqs('course_emphases', 'emphasis_id', eligible_courses)

      emphasis_elective.each_with_index do |elective, index|
        course = ordered_eligible_courses[index]
        break unless course
        
        if @courses.none? { |c| c[:course_id] == course.course_id }
          @courses << { course_id: course.course_id, sem: elective.sem }
        else
          next
        end
      end
    else # If there is no emphasis area, we insert back the placeholder modules
      emphasis_elective.each do |elective|
        @courses << { course_id: elective.course_id, sem: elective.sem }
      end
    end
  end

  def add_track_courses(cs_elective)
    if @track_area
      track_id = Track.where(tname: @track_area)
      eligible_courses = CourseTrack.where(track_id:)
      ordered_eligible_courses = order_min_prereqs('course_tracks', 'track_id', eligible_courses)

      cs_elective.each_with_index do |elective, index|
        puts ordered_eligible_courses[index].inspect
        course = ordered_eligible_courses[index]
        break unless course
        
        if @courses.none? { |c| c[:course_id] == course.course_id }
          @courses << { course_id: course.course_id, sem: elective.sem }
        else
          next
        end
      end
    else # If there is no track area, we insert back the placeholder modules
      cs_elective.each do |elective|
        @courses << { course_id: elective.course_id, sem: elective.sem }
      end
    end
  end

  def add_general_courses(general_elective)
    general_elective.each do |elective|
      @courses << { course_id: elective.course_id, sem: elective.sem }
    end
  end

  def add_science_courses(science_elective)
    science_elective.each do |elective|
      @courses << { course_id: elective.course_id, sem: elective.sem }
    end
  end

  # def order_min_prereqs(table_name, id_name, courses)
  #   courses
  #     .joins("LEFT JOIN prerequisites ON #{table_name}.course_id = prerequisites.course_id")
  #     .select("#{table_name}.course_id, #{table_name}.#{id_name}, COUNT(prerequisites.prereq_id) AS prereq_count")
  #     .group("#{table_name}.course_id, #{table_name}.#{id_name}")
  #     .order('prereq_count ASC')
  # end
  def order_min_prereqs(table_name, id_name, courses)
    safe_table_name = ActiveRecord::Base.connection.quote_table_name(table_name)
    safe_id_name = ActiveRecord::Base.connection.quote_column_name(id_name)
  
    courses
      .joins("LEFT JOIN prerequisites ON #{safe_table_name}.course_id = prerequisites.course_id")
      .select("#{safe_table_name}.course_id", "#{safe_table_name}.#{safe_id_name}", 'COUNT(prerequisites.prereq_id) AS prereq_count')
      .group("#{safe_table_name}.course_id", "#{safe_table_name}.#{safe_id_name}")
      .order('prereq_count ASC')
  end
  
end
