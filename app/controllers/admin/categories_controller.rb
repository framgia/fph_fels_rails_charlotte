class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user

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

  private
    def admin_user
      unless current_user.admin?
        flash[:danger] = "You are not authorized."
        redirect_to root_url
      end
    end

    def cat_params
      params.require(:category).permit(:title, :description)
    end
end
