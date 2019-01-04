class CategoriesController < ApplicationController
  before_action :logged_in_user
  def index
    if params[:filter].eql?("learned")
      @categories = current_user.categories.where.not(lessons: {result: nil})
    elsif params[:filter].eql?("unlearned")
      @categories = Category.left_outer_joins(:lessons).where.not(id: current_user.categories.where.not(lessons: {result: nil})).group(:id)
    else
      @categories = Category.all
    end
    @categories = @categories.paginate(page: params[:page])
  end
end