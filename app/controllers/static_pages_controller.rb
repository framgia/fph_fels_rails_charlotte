class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = Activity.paginate(page: params[:page]).order("created_at DESC")
  	end
  end
end