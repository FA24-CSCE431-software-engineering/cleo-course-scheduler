# app/services/prerequisite_updater.rb
class PrerequisiteUpdater
    def initialize(course, new_prerequisites)
      @course = course
      @new_prerequisites = new_prerequisites
    end
  
    def call
      update_prerequisites(@new_prerequisites)  
    end
  
    private
  
    def update_prerequisites(new_prerequisites)
        Rails.logger.debug("Current prerequisites: #{@course.prerequisites.inspect}")
      
        current_prerequisites = @course.prerequisites
      
        # Map new prerequisites to their components
        new_prerequisite_entries = new_prerequisites.map do |prereq|
          course_id = find_course_id(prereq[:course])
          { course_id: @course.id, prereq_id: course_id, equi_id: prereq[:equi_id] } if course_id
        end.compact
      
        Rails.logger.debug("New prerequisites entries: #{new_prerequisite_entries.inspect}")
      
        # Determine which prerequisites to remove
        prerequisites_to_remove = current_prerequisites.reject do |prereq|
          new_prerequisite_entries.any? do |new_prereq|
            new_prereq[:prereq_id] == prereq.prereq_id && new_prereq[:equi_id] == prereq.equi_id
          end
        end
      
        Rails.logger.debug("Prerequisites to remove: #{prerequisites_to_remove.inspect}")
      
        # Remove old prerequisites using delete_all based on the unique combination of attributes
        if prerequisites_to_remove.any?
          prereq_ids = prerequisites_to_remove.map(&:prereq_id)
          equi_ids = prerequisites_to_remove.map(&:equi_id)
      
          begin
            Rails.logger.debug("!!!!!!!About to delete prerequisites with IDs: #{prereq_ids.inspect} and equi_ids: #{equi_ids.inspect}")
            @course.prerequisites.where(prereq_id: prereq_ids, equi_id: equi_ids).delete_all
            Rails.logger.debug("Successfully removed prerequisites with IDs: #{prereq_ids.inspect}")
          rescue => e
            Rails.logger.error("Error during deletion of prerequisites, Error: #{e.message}")
          end
        end
      
        # Add new prerequisites
        new_prerequisite_entries.each do |new_prereq|
          next if current_prerequisites.exists?(prereq_id: new_prereq[:prereq_id], equi_id: new_prereq[:equi_id])
      
          @course.prerequisites.create(new_prereq)
          Rails.logger.debug("Added new prerequisite with ID: #{new_prereq[:prereq_id]}")
        end
      end
      
      
      
  
  
      def find_course_id(full_course_code)
        # Split the full course code into its components
        parts = full_course_code.split(" ")
        ccode = parts[0]  # e.g., "CSCE"
        cnumber = parts[1]  # e.g., "350"

        course = Course.find_by(ccode: ccode, cnumber: cnumber)
      
        if course
          course.id
        else
          Rails.logger.warn("No course found for code: #{full_course_code}")
          nil
        end
      end
      
      
  end
  