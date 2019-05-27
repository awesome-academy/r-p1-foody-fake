class OrderDetailsController < ApplicationController
  include OrdersHelper
  include RestaurantsHelper

  before_action :find_order_details, only: %i(create)
  before_action :find_foods, only: %i(index)
  before_action :logged_in_user, only: %i(index new create show edit update)

  def index
    order_id = get_order_id
    if !Order.where(id: order_id).present? || !Order.where(id: order_id, status: "pending").present?
      @order = Order.create(user_id: current_user.id, status: "pending")
      cookies.permanent.signed[:order_id] = @order.id
    else
      @order = Order.find_by(id: order_id, status: "pending")
    end
    @order_detail = OrderDetail.new
    @order_details = @order.order_details
    @id_to_name = @order.get_food_names_images
    @total_value = @order.get_total_value
  end

  def new
    @order_detail = OrderDetail.new
  end

  def create
    if @order_detail
      @order_detail.update_quantity order_detail_params[:quantity]
    else
      @order_detail = OrderDetail.new order_detail_params
      if @order_detail.save
        flash[:success] = t("success_order")
      else
        flash[:danger] = t("failure_order")
      end

    end
    redirect_to mycart_url
  end

  private
    def order_detail_params
      order_id = get_order_id || session[:order_id]
      params.require(:order_detail).permit(:quantity, :price, :food_id).merge(order_id: order_id)
    end

    def find_order_details
      @order_detail = OrderDetail.find_by(order_id: get_order_id, food_id: order_detail_params[:food_id])
    end

    def find_foods
      @foods = current_restaurant.foods
    end

    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t("please_log_in")
      redirect_to login_url
    end
end
