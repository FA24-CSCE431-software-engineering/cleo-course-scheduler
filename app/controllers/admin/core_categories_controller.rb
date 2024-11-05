# frozen_string_literal: true

module Admin
  class CoreCategoriesController < ApplicationController
    include AdminAuthentication

    before_action :set_core_category, only: %i[edit update destroy confirm_destroy]
    skip_before_action :authenticate_student_login! if Rails.env.test?

    def index
      @core_categories = CoreCategory.all
      render 'admin/core_categories/index'
    end

    def new
      @core_category = CoreCategory.new
      render 'admin/core_categories/new'
    end

    def create
      @core_category = CoreCategory.new(core_category_params)
      if @core_category.save
        redirect_to admin_core_categories_path, notice: 'Core category added successfully.'
      else
        render 'admin/core_categories/new'
      end
    end

    def edit
      render 'admin/core_categories/edit'
    end

    def update
      if @core_category.update(core_category_params)
        redirect_to admin_core_categories_path, notice: 'Core category updated successfully.'
      else
        render :edit
      end
    end

    def destroy
      @core_category.destroy
      redirect_to admin_core_categories_path, notice: 'Core category deleted successfully.'
    end

    def confirm_destroy
      @core_category = CoreCategory.find(params[:id])
      render 'admin/core_categories/confirm_destroy'
    end

    private

    def set_core_category
      @core_category = CoreCategory.find(params[:id])
    end

    def core_category_params
      params.require(:core_category).permit(:cname)
    end
  end
end
