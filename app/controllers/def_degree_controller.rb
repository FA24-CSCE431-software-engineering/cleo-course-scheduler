class DefDegreeController < ApplicationController
    def show
      @student = Student.find_by(google_id: current_student_login.uid)
      @tracks = Track.all.pluck(:tname)
      @emphases = Emphasis.all.pluck(:ename)
      
    end

    def new
      @student = current_student_login
      @tracks = Track.all # Fetch all tracks from the database
      @emphasis_areas = Emphasis.all # Fetch all emphasis areas from the database
    end


    def save
        # Your logic to save the degree plan
    end

    def download
        # Logic to generate and send the degree plan for download
    end

    private

    def generate_degree_plan(student)
      # Fetch the default degree requirements based on the student's major
      DegreeRequirement.where(major_id: student.major_id).includes(:course).order(:year, :sem)
    end


  end
  