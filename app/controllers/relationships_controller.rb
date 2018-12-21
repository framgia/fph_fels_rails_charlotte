class RelationshipsController < ApplicationController
  before_action :logged_in_user
  after_action :create_activity, only: [:create]

  def create
    @user = User.find(params[:followed_id])
    @relationship = @current_user.active_relationships.build(followed_id: @user.id)
    @relationship.save

    redirect_to @user
  end

  def destroy
    @relationship = Relationship.find(params[:id])
    @user = @relationship.followed
    current_user.active_relationships.destroy(@relationship)

    redirect_to @user
  end

  def create_activity
    @activity = Activity.new(action: @relationship, user_id: current_user.id)
    @activity.save
  end
end