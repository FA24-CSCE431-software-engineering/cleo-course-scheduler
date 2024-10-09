class MajorsController < ApplicationController
  
  def index
    @majors = Major.all
    render 'admin/majors/index'
  end

  def _form
  end

  def confirm_destroy
  end

  def edit
  end

  def show; end

  def new
    @major = Major.new
    render 'admin/majors/index'
  end

  def destroy
  end

  def create
  end

  private

  def set_major
    @major = Major.find(params[:id])
  end

  def major_params
    params.require(:major).permit(:name, :description)  # Add other relevant attributes as needed
  end

end



