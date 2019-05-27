module Manager
  class FoodsController < ManagerBaseController
    before_action :find_food, only: [:edit, :update, :destroy]

    def index
      @current_restaurant = current_user.get_restaurant
      @foods = @current_restaurant.foods
    end

    def new
      @food = Food.new
    end

    def create
      current_restaurant = current_user.get_restaurant
      @food = current_restaurant.foods.build(food_params)
      if @food.save
        flash[:success] = t("food_created")
        redirect_to manager_managers_url
      else
        flash[:success] = t("food_created_failure")
        redirect_to new_manager_food_url
      end
    end


    def edit; end

    def update
      if @food.update_attributes(food_params)
        flash[:success] = t("food_updated")
        redirect_to manager_managers_url
      else
        render :edit
      end
    end

    def destroy
      if @food.destroy
        flash[:success] = t("success_deleted")
      else
        flash[:danger] = t("failure_deleted")
      end
      redirect_to managerfoods_url
    end

    private
      def food_params
        params.require(:food).permit(:name, :image, :price)
      end

      def find_food
        return if @food = Food.find_by(id: params[:id])
        render "layouts/notfound"
      end
  end
end
