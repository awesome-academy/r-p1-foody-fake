module Admin
  class AdminsController < AdminBaseController
    def index
      @number_of_users = User.all.size
      @number_of_orders = Order.all.size
      @number_of_ratings = Rating.all.size
    end
  end
end
