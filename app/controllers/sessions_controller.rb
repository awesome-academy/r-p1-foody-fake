class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      unless user.check_type("admin")
        unless user.check_type("manager")
          if user.get_order_id
            cookies.permanent.signed[:order_id] = user.get_order_id
          else
            order = Order.create(user_id: user.id, status: "pending")
            cookies.permanent.signed[:order_id] = order.id
          end
          redirect_back_or user
        else
          redirect_to manager_managers_url
        end

      else
        redirect_to admin_admins_url
      end

    else
      flash[:danger] = t("invalid_login")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
