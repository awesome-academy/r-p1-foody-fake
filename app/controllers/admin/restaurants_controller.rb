
module Admin
  class RestaurantsController < AdminBaseController
    before_action :find_restaurant, only: %i(edit update destroy)

    def new
      @restaurant = Restaurant.new
      @provinces = Province.first(Settings.number_of_province)
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

    def show; end

    def search
      @restaurants = Restaurant.search(params[:search])

    end

    def edit
      @provinces = Province.first(Settings.number_of_province)
    end

    def update
      if @restaurant.update_attributes restaurant_params
        flash[:success] = t("restaurant_updated")
        redirect_to searchrestaurant_url
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
      redirect_to searchrestaurant_url
    end

    private
      def restaurant_params
        open_time_formatted = Time.parse(params[:restaurant][:open_time]).seconds_since_midnight.to_i
        close_time_formatted = Time.parse(params[:restaurant][:close_time]).seconds_since_midnight.to_i

        provinceid, districtid, wardid = params[:province_select], params[:district_select] ,params[:ward_select]
        specific_address = params.require(:restaurant)[:location]
        province_name = Province.find_by(provinceid: provinceid).name
        district_name = District.find_by(districtid: districtid).name
        ward_name = Ward.find_by(wardid: wardid).name
        specific_address = specific_address + ", " + ward_name + ", " + district_name + ", " + province_name

        geolocation_api_url = ENV["DOMAIN_GEOLOCATION_API"] + "q="+ specific_address + "&key=" + ENV["API_KEY"]

        result_from_api_call = JSON.parse(HTTParty.get(URI.parse(URI.escape(geolocation_api_url))).to_s)
        longitude_result = result_from_api_call["results"][0]["geometry"]["lng"] || ""
        latitude_result = result_from_api_call["results"][0]["geometry"]["lat"] || ""

        params.require(:restaurant).permit(:name, :minprice, :maxprice, :image).merge(open_time: open_time_formatted, close_time: close_time_formatted, location: specific_address , longitude: longitude_result, latitude: latitude_result)
      end

      def find_restaurant
        return if @restaurant = Restaurant.find_by(id: params[:id])
        flash[:error] = t("not_found")
        render "layouts/notfound"
      end
  end
end
