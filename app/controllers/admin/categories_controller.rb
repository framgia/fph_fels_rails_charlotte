class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

  def show
    @category = Category.find(params[:id])
  end

  def index
    @categories = Category.paginate(page: params[:page])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(cat_params)
    if @category.save
      flash[:success] = "Category successfully created!"
      redirect_to admin_categories_url
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(cat_params)
      flash[:success] = "Category has been updated"
      redirect_to admin_category_url
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = "Category has been successfully deleted"
    redirect_to admin_categories_url
  end

  private
    def cat_params
      params.require(:category).permit(:title, :description)
    end
end