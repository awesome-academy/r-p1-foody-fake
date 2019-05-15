module Admin
  class UsersController < AdminBaseController
    ORDER_BY_ATTRIBUTE = "created_at"
    before_action :find_user, only: %i(destroy)
    def index
      @users = User.order(ORDER_BY_ATTRIBUTE).page(params[:page])
      .per(Settings.items_per_page)
    end

    def destroy
      if @user.destroy
        flash[:success] = t("success_deleted")
      else
        flash[:danger] = t("failure_deleted")
      end
      redirect_to admin_users_url
    end

    private
      def find_user
        return if @user = User.find_by(id: params[:id])
        render "layouts/notfound"
      end
  end
end
