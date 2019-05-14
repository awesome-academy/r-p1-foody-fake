module Admin
  class UsersController < AdminBaseController
    def destroy
      if @user.destroy
        flash[:success] = t("success_deleted")
      else
        flash[:danger] = t("failure_deleted")
      end
      redirect_to users_url
    end
  end
end
