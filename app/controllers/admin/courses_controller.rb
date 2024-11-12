# frozen_string_literal: true

module Admin
  class CoursesController < ApplicationController
    include CoursesHelper
    include AdminAuthentication

    skip_before_action :authenticate_student_login! if Rails.env.test?
    before_action :set_course, only: %i[edit update destroy confirm_destroy]

    EXPECTED_COURSE_HEADERS = ['Course Code', 'Course Number', 'Course Name', 'Credit Hours', 'Lecture Hours',
                               'Lab Hours', 'Description', 'Prereq 1', 'Prereq 2', 'Prereq 3'].freeze

    def confirm_destroy
      @course = Course.find(params[:id])
      render 'admin/courses/confirm_destroy'
    end

    def view_template
      file_path = Rails.root.join('public', 'templates', 'upload_course_template.csv')
      csv_content = File.read(file_path)
      render plain: csv_content, content_type: 'text/plain'
    end

    def edit
      render 'admin/courses/edit'
    end

    def index
      @courses = Course.all
      render 'admin/courses/index'
    end

    def new
      @course = Course.new
      render 'admin/courses/new'
    end

    def destroy
      @course.destroy
      redirect_to admin_courses_path, notice: 'Course deleted succesfully.'
    end

    def create
      @course = Course.new(course_params)
      if @course.save
        redirect_to admin_courses_path, notice: 'Course added succesfully.'
      else
        render 'admin/courses/new'
      end
    end

    def show
      @course = Course.find(params[:id])
      @prerequisites = Prerequisite.where(course_id: @course.id).includes(:prereq)
      render 'admin/courses/show'
    end
    
    def update
      # get prerequisites string
      prerequisites_string = params[:course][:prerequisites]
    
      # make into array
      new_prerequisites = parse_prerequisites(prerequisites_string)

      course_updated = @course.update(course_params.except(:prerequisites)) 
        
      # pass course and the new prerequisites array to the updater
      updater = PrerequisiteUpdater.new(@course, new_prerequisites)
      updater.call
    
      # error checking
      if !course_updated || @course.errors.any?
        # group errors
        render :edit
      else
        redirect_to admin_course_path(@course), notice: 'Course updated successfully.'
      end
    end
      

    def import
      if params[:file].present?
        process_course_csv(params[:file])
      else
        flash[:error] = 'Please upload a CSV file.'
        redirect_to admin_courses_path
      end
    end

    private

    def parse_prerequisites(prerequisites_string)
      return [] if prerequisites_string.blank?  # Return an empty array if the input is blank
    
      # Split the string into groups based on 'and'
      prerequisite_groups = prerequisites_string.split(/\s+and\s+/).map(&:strip)
    
      # Create an array to hold the parsed prerequisites with their respective equi_ids
      parsed_prerequisites = []
    
      prerequisite_groups.each_with_index do |group, index|
        # Split by 'or' and assign a unique equi_id for each course in the group
        group.split(/\s+or\s+/).each do |course|
          parsed_prerequisites << { course: course.strip, equi_id: index + 1 }
        end
      end
    
      parsed_prerequisites
    end
    


    def set_course
      @course = Course.find(params[:id])
    end

    def course_params
      params.require(:course).permit(:ccode, :cnumber, :cname, :description, :credit_hours, :lecture_hours, :lab_hours, :prerequisites)
    end


    def process_course_csv(file)
      csv_file = CSV.read(file.path, headers: true)

      if valid_course_csv?(csv_file)
        import_courses_from_csv(file)
        flash[:success] = 'Course catalog uploaded successfully.'
      else
        flash[:error] =
          "CSV format is incorrect. Please ensure the file has headers: #{EXPECTED_COURSE_HEADERS.join(', ')}."
      end

      redirect_to admin_courses_path
    rescue StandardError
      flash[:error] = 'The CSV file is malformed or unreadable. Please upload a valid CSV file.'
      redirect_to admin_courses_path
    end

    def valid_course_csv?(csv_file)
      (csv_file.headers & EXPECTED_COURSE_HEADERS).size == EXPECTED_COURSE_HEADERS.size
    end

    def import_courses_from_csv(file)
      CSV.foreach(file.path, headers: true) do |row|
        course = Course.create(
          ccode: row['Course Code'],
          cnumber: row['Course Number'],
          cname: row['Course Name'],
          description: row['Description'],
          credit_hours: row['Credit Hours'],
          lecture_hours: row['Lecture Hours'],
          lab_hours: row['Lab Hours']
        )

        ['Prereq 1', 'Prereq 2', 'Prereq 3'].each do |prereq_column|
          prereq_code = row[prereq_column]
          next if prereq_code.blank?

          prerequisite_course = Course.find_by(ccode: prereq_code)

          if prerequisite_course
            Prerequisite.create!(
              course_id: course.id,
              prereq_id: prerequisite_course.id
            )
          else
            Rails.logger.warn "Prerequisite course with code #{prereq_code} not found for course #{course.cname}"
          end
        end
      end
    end
  end
end
