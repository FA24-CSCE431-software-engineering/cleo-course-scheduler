# app/services/prerequisite_updater.rb
class PrerequisiteUpdater
    attr_reader :error_message
  
    def initialize(course, new_prerequisites)
      @course = course
      @new_prerequisites = new_prerequisites
      @error_message = nil
    end

    def call
        validate_prerequisites
        return if @course.errors.any? 
        update_prerequisites(@new_prerequisites)
    end


    def validate_prerequisites
      @new_prerequisites.each do |prereq|
        unless find_course_id(prereq[:course])
          @course.errors.add(:prerequisites, "Course not found for code: #{prereq[:course]}")
        end
    
        # check that it is not a prereq of itself
        prereq_id = find_course_id(prereq[:course])
        if prereq_id && prereq_id == @course.id
          @course.errors.add(:prerequisites, "A course cannot be a prerequisite of itself: #{prereq[:course]}")
        end
      end
    end
    
  

    private
  
    def update_prerequisites(new_prerequisites)
      
      current_prerequisites = @course.prerequisites
      
      # map new prerequisites 
      new_prerequisite_entries = new_prerequisites.map do |prereq|
        course_id = find_course_id(prereq[:course])
        { course_id: @course.id, prereq_id: course_id, equi_id: prereq[:equi_id] } if course_id
      end.compact
  
      
      # which remove
      prerequisites_to_remove = current_prerequisites.reject do |prereq|
        new_prerequisite_entries.any? do |new_prereq|
          new_prereq[:prereq_id] == prereq.prereq_id && new_prereq[:equi_id] == prereq.equi_id
        end
      end
      
      # remove based on unique 
      if prerequisites_to_remove.any?
        prereq_ids = prerequisites_to_remove.map(&:prereq_id)
        equi_ids = prerequisites_to_remove.map(&:equi_id)
    
        begin
          @course.prerequisites.where(prereq_id: prereq_ids, equi_id: equi_ids).delete_all
          Rails.logger.debug("Successfully removed prerequisites with IDs: #{prereq_ids.inspect}")
        rescue => e
          Rails.logger.error("Error during deletion of prerequisites, Error: #{e.message}")
        end
      end
  
      # create
      new_prerequisite_entries.each do |new_prereq|
        next if current_prerequisites.exists?(prereq_id: new_prereq[:prereq_id], equi_id: new_prereq[:equi_id])
    
        @course.prerequisites.create(new_prereq)
        Rails.logger.debug("Added new prerequisite with ID: #{new_prereq[:prereq_id]}")
      end
    end
  
    def find_course_id(full_course_code)
      # split
      parts = full_course_code.split(" ")
      ccode = parts[0] 
      cnumber = parts[1]
  
      course = Course.find_by(ccode: ccode, cnumber: cnumber)
      
      if course
        course.id
      else
        Rails.logger.warn("No course found for code: #{full_course_code}")
        @error_message = "Course not found for code: #{full_course_code}"
        nil
      end
    end
  end
  
  
  