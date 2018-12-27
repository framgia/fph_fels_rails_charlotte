class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @activities = Activity.where(user: current_user.following).or(Activity.where(user: current_user)).paginate(page: params[:page]).order("created_at DESC")
    end
  end
end