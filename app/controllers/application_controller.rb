class ApplicationController < ActionController::Base
  include SessionsHelper

  private
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def logged_out_user
      if logged_in?
        flash[:danger] = "You are still logged in."
        redirect_to root_url
      end
    end

    def admin_user
      unless current_user.admin?
        flash[:danger] = "You are not authorized."
        redirect_to root_url
      end
    end
end
