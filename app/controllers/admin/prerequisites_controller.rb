module Admin
  class PrerequisitesController < ApplicationController
    before_action :set_prerequisite, only: [:show, :edit, :update, :destroy, :confirm_destroy]

    def index
      @course_pairs = Prerequisite.map_course_pairs
    end

    def show
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

    end

    def confirm_destroy
      @prerequisite = Prerequisite.find(params[:id])
    end
    

    def destroy

    end
    


  


    def set_prerequisite
      @prerequisite = Prerequisite.find(params[:id])
    end

    def prerequisite_params
      params.require(:prerequisite).permit(:course_id, :prereq_id, :equi_id)
    end
  end
end
