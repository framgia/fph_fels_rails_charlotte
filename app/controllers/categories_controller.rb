class CategoriesController < ApplicationController
  before_action :logged_in_user
  def index
    if params[:filter].eql?("learned")
      @categories = Category.joins(:lessons).where.not(lessons: {result: nil})
    elsif params[:filter].eql?("unlearned")
      @categories = Category.includes(:lessons).where(lessons: {result: nil})
    else
      @categories = Category.all
    end
    @categories = @categories.paginate(page: params[:page])
  end
end