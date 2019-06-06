class OrdersController < ApplicationController
  include OrdersHelper
  before_action :find_order, only: %i(new show edit update update_status destroy)
  before_action :logged_in_user, only: %i(new create show edit update)

  def new; end

  def create; end

  def show
    @order_details = @order.order_details
    @id_to_name = @order.get_food_names_images
    @total_value = @order.get_total_value
  end

  def update_status
    @order.update_attributes(status: "delivering")
  end

  def edit
    @provinces = Province.first(Settings.number_of_province)
  end

  def update
    if @order.update_attributes order_params
      flash[:success] = t("address_updated")
      redirect_to order_url
    else
      render :new
    end
  end

  def destroy
      if @order.destroy
        flash[:success] = t("success_deleted")
        cookies.delete :order_id
      else
        flash[:danger] = t("failure_deleted")
      end
      redirect_to current_user
    end

  private


    def find_order
      order_id = params[:id] || get_order_id
      @order = Order.find_by(id: order_id)
    end

    def order_params
      provinceid, districtid, wardid = params[:province_select], params[:district_select] ,params[:ward_select]
      specific_address = params.require(:order)[:address]
      province_name = Province.find_by(provinceid: provinceid).name
      district_name = District.find_by(districtid: districtid).name
      ward_name = Ward.find_by(wardid: wardid).name
      specific_address = specific_address + ", " + ward_name + ", " + district_name + ", " + province_name
      params.require(:order).permit(:name, :phone).merge(address: specific_address)
    end
end
