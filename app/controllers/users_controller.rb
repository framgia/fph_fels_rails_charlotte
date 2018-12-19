class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :following, :followers]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:set_admin]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile has been updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def set_admin
    @user = User.find(params[:id])
    if @user.admin?
      @user.update_attribute(:admin, 0)
    else
      @user.update_attribute(:admin, 1)
    end

    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'follow_page'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'follow_page'
  end

  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = "You are not authorized."
        redirect_to users_url
      end
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
    end
end