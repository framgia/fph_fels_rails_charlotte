class CategoriesController < ApplicationController
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
      redirect_to categories_url
    else
      render 'new'
    end
  end

  private
    def cat_params
      params.require(:category).permit(:title, :description)
    end
end
