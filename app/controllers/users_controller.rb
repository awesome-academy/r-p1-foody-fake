class UsersController < ApplicationController
  include UsersHelper
  include SessionsHelper
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(edit update)
  before_action :find_user, only: %i(show edit update destroy)

  def new
    @user = User.new
  end

  def show
    @orders = @user.orders
    return unless @user.nil?
    render "layouts/notfound"
  end

  def create
    @user = User.new user_params
    if @user.save
      redirect_to login_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t("profile_updated")
      redirect_to @user
    else
      render :edit
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t("please_log_in")
      redirect_to login_url
    end

    def correct_user
      @user = User.find_by(id: params[:id])
      return if current_user?(@user)
      redirect_to root_url
    end

    def find_user
      return if @user = User.find_by(id: params[:id])
      render "layouts/notfound"
    end
end
