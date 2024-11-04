# app/services/prerequisite_updater.rb
class PrerequisiteUpdater
    def initialize(course, new_prerequisites)
      @course = course
      @new_prerequisites = new_prerequisites
    end
  
    def call
      update_prerequisites(@new_prerequisites)  # Ensure this line is correct
    end
  
    private
  
    def update_prerequisites(new_prerequisites)
        Rails.logger.debug("Current prerequisites IDs: #{@course.prerequisites.pluck(:prereq_id)}")
      
        current_prerequisites_ids = @course.prerequisites.pluck(:prereq_id)
      
        # Find IDs of the new prerequisites based on their codes
        new_prerequisite_ids = new_prerequisites.map { |code| find_course_id(code) }.compact
        Rails.logger.debug("New prerequisite IDs: #{new_prerequisite_ids.inspect}")
      
        # Determine which prerequisites to remove
        prerequisites_to_remove = current_prerequisites_ids - new_prerequisite_ids
        Rails.logger.debug("Prerequisites to remove: #{prerequisites_to_remove.inspect}")
      
        prerequisites_to_remove.each do |prereq_id|
            Rails.logger.debug("Attempting to find prerequisite with ID: #{prereq_id}")
            prerequisite_to_delete = @course.prerequisites.find_by(prereq_id: prereq_id)
            if prerequisite_to_delete
              Rails.logger.debug("Found prerequisite for deletion: #{prerequisite_to_delete.inspect}")
              begin
                prerequisite_to_delete.destroy
                Rails.logger.debug("Successfully removed prerequisite with ID: #{prereq_id}")
              rescue => e
                Rails.logger.error("Error during destruction of prerequisite ID: #{prereq_id}, Error: #{e.message}")
              end
            else
              Rails.logger.warn("Prerequisite with ID: #{prereq_id} not found for deletion.")
            end
        end
          
      
        # Add new prerequisites
        new_prerequisite_ids.each do |prereq_id|
          next unless prereq_id  # Skip if no valid ID
      
          unless current_prerequisites_ids.include?(prereq_id)
            @course.prerequisites.create(prereq_id: prereq_id)
            Rails.logger.debug("Added new prerequisite with ID: #{prereq_id}")
          end
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
  