class CoreCategoriesController < ApplicationController
  def index
    @core_categories = CoreCategory.all
    render 'admin/core_categories/index'
  end

  def _form
  end

  def confirm_destroy
  end

  def edit
  end

  def new
    @core_categories = CoreCategory.all
    render 'admin/core_categories/index'
  end

  def destroy
  end

  def create
  end
end
