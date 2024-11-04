# frozen_string_literal: true

class DefDegreeController < ApplicationController
  skip_before_action :authenticate_student_login! if Rails.env.test?
  def show
    @student = Student.find_by(google_id: current_student_login.uid)
    @tracks = Track.all.pluck(:tname)
    @emphases = Emphasis.all.pluck(:ename)
  end

  def new
    @student = current_student_login
    @tracks = Track.all
    @emphasis_areas = Emphasis.all
  end

  def save; end

  def download; end

  private

  def generate_degree_plan(student)
    # Fetch the default degree requirements based on the student's major
    DegreeRequirement.where(major_id: student.major_id).includes(:course).order(:year, :sem)
  end
end
