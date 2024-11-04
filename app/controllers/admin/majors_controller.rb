# frozen_string_literal: true

module Admin
  class MajorsController < ApplicationController
    include AdminAuthentication

    skip_before_action :authenticate_student_login! if Rails.env.test?
    before_action :set_major, only: %i[show edit update destroy confirm_destroy]

    def index
      @majors = Major.all
      render 'admin/majors/index'
    end

    def show; end

    def new
      @major = Major.new
      render 'admin/majors/new'
    end

    def create
      @major = Major.new(major_params)
      if @major.save
        redirect_to admin_majors_path, notice: 'Major added successfully.'
      else
        render :new
      end
    end

    def edit
      render 'admin/majors/edit'
    end

    def update
      if @major.update(major_params)
        redirect_to admin_majors_path, notice: 'Major updated successfully.'
      else
        render :edit
      end
    end

    def destroy
      @major.destroy
      redirect_to admin_majors_path, notice: 'Major deleted successfully.'
    end

    def confirm_destroy
      @major = Major.find(params[:id])
      render 'admin/majors/confirm_destroy'
    end

    private

    def set_major
      @major = Major.find(params[:id])
    end

    def major_params
      params.require(:major).permit(:mname, :cname)
    end
  end
end
