module Manager
  class ManagersController < ManagerBaseController
    def index
      @current_restaurant = current_user.get_restaurant
      @number_of_ratings = @current_restaurant.ratings.size
      @number_of_foods = @current_restaurant.foods.size
    end
  end
end
