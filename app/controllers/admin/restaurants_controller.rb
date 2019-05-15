module Admin
  class RestaurantsController < AdminBaseController
     before_action :find_restaurant, only: %i(edit update)

    def new
      @restaurant = Restaurant.new
    end

    def create
      @restaurant = Restaurant.new(restaurant_params)
      if @restaurant.save
        flash[:success] = t("create_restaurant_success")
        redirect_to admin_admins_url
      else
        flash[:info] = t("create_restaurant_failure")
        render :new
      end
    end

    def edit
    end

    def update
      if @restaurant.update_attributes restaurant_params
        flash[:success] = t("restaurant_updated")
        redirect_to @restaurant
      else
        render :edit
      end
    end

    def destroy
      if @restaurant.destroy
        flash[:success] = t("success_deleted")
      else
        flash[:danger] = t("failure_deleted")
      end
      redirect_to restaurants_url
    end

    private
      def restaurant_params
        open_time_formatted = Time.parse(params[:restaurant][:open_time]).seconds_since_midnight.to_i
        close_time_formatted = Time.parse(params[:restaurant][:close_time]).seconds_since_midnight.to_i

        params.require(:restaurant).permit(:name, :location, :minprice, :maxprice, :image).merge(open_time: open_time_formatted, close_time: close_time_formatted)
      end

      def find_restaurant
        return if @restaurant = Restaurant.find_by(id: params[:id])
        flash[:error] = t("not_found")
        render "layouts/notfound"
      end
  end
end
