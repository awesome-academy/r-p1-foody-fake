class RatingsController < ApplicationController
  include RestaurantsHelper

  before_action :logged_in_user, :exist_restaurant

  def index; end

  def create
    @rating = Rating.new(rating_params.merge(user_id: current_user.id, restaurant_id: current_restaurant.id))
    if @rating.save
      redirect_to current_restaurant
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  def destroy; end

  private
    def rating_params
      params.require(:rating).permit(:quality_point,:price_point,:service_point, :space_point, :location_point)
    end
end
