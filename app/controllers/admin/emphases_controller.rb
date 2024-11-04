# frozen_string_literal: true

module Admin
  class EmphasesController < ApplicationController
    include AdminAuthentication

    skip_before_action :authenticate_student_login! if Rails.env.test?
    before_action :set_emphasis, only: %i[show edit update destroy]

    def confirm_destroy; end

    def destroy
      @emphasis.destroy
      redirect_to admin_emphases_path, notice: 'Emphasis successfully deleted.'
    end

    def edit; end

    def index
      @emphases = Emphasis.all
      @emphasis = params[:id] ? Emphasis.find(params[:id]) : Emphasis.new
    end

    def new; end

    def show; end

    def update
      if @emphasis.update(emphasis_params)
        redirect_to admin_emphases_path, notice: 'Emphasis successfully updated.'
      else
        @emphases = Emphasis.all
        render :index
      end
    end

    def create
      @emphasis = Emphasis.new(emphasis_params)
      if @emphasis.save
        redirect_to admin_emphases_path, notice: 'Emphasis successfully created.'
      else
        @emphases = Emphasis.all
        render :index
      end
    end

    private

    def set_emphasis
      @emphasis = Emphasis.find(params[:id])
    end

    def emphasis_params
      params.require(:emphasis).permit(:ename)
    end
  end
end
