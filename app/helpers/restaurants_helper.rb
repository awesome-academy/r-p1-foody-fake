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

  def get_number_of_ratings_each_category ratings
    no_excellent, no_good, no_medium, no_bad = 0, 0, 0, 0
    ratings.each do |rating|
      avg_point = rating.average_point
      if avg_point >= 8.0
        no_excellent += 1
      elsif avg_point >= 6.0
        no_good += 1
      elsif avg_point >= 4.0
        no_medium += 1
      else
        no_bad += 1
      end
    end
    return no_excellent, no_good, no_medium, no_bad
  end
end
