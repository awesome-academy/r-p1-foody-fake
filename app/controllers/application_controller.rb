class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  def admin_user
    return if current_user.check_type "admin"
    redirect_to root_url
  end

  def manager_user
    return if current_user.check_type "manager"
    redirect_to root_url
  end

  private
    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t("pls_log_in")
      redirect_to login_url
    end
end
