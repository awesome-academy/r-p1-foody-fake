module RestaurantsHelper
  def remember_res restaurantid
    cookies.permanent.signed[:restaurant_id] = restaurantid
  end

  def current_restaurant
   @current_restaurant ||= Restaurant.find_by(id: cookies.signed[:restaurant_id])
 end

  def exist_restaurant
    return if current_restaurant
    render "layouts/notfound"
  end

  def get_formatted_name name
    name.gsub(/\s+/m, '_').strip.split("_")[0].capitalize
  end

  def get_point_names
    ["quality_point", "service_point", "location_point", "price_point", "space_point"]
  end
end
