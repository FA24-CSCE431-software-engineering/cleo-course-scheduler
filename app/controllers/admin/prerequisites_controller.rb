module Admin
  class PrerequisitesController < ApplicationController
    before_action :set_prerequisite, only: [:show, :edit, :update, :destroy, :confirm_destroy]

    def index
      @prerequisites = Prerequisite.all
    end

    def show
      # This action will render the show view for a single prerequisite
    end

    def new
      @prerequisite = Prerequisite.new
    end

    def create
      @prerequisite = Prerequisite.new(prerequisite_params)
      if @prerequisite.save
        redirect_to admin_prerequisites_path, notice: 'Prerequisite was successfully created.'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @prerequisite.update(prerequisite_params)
        redirect_to admin_prerequisites_path, notice: 'Prerequisite was successfully updated.'
      else
        render :edit
      end
    end

    def confirm_destroy
    end

    def destroy
      @prerequisite.destroy
      redirect_to admin_prerequisites_path, notice: 'Prerequisite was successfully deleted.'
    end

    private

    def set_prerequisite
      @prerequisite = Prerequisite.find(params[:id])
    end

    def prerequisite_params
      params.require(:prerequisite).permit(:course_id, :prereq_id, :equi_id)
    end
  end
end
