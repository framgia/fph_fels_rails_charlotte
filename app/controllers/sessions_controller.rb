class SessionsController < ApplicationController
  before_action :logged_out_user, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      flash[:success] = "You have successfully logged in."
      redirect_to root_path
    else
      flash.now[:danger] = "Invalid Email/Password Combination."
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end