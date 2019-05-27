class RestaurantsController < ApplicationController

  include CommentsHelper
  include RestaurantsHelper

  before_action :find_restaurant, only: %i(show)

  def index
    if cookies.signed[:search_near_me]
      latitude = cookies.signed[:latitude]
      longitude = cookies.signed[:longitude]
      @restaurants = Restaurant.search_near_me(latitude, longitude)
    else
      province_name = cookies.signed[:province_name]
      district_name = cookies.signed[:district_name]
      ward_name = cookies.signed[:ward_name]
      @restaurants = Restaurant.search_by_location(province_name, district_name, ward_name)
    end
  end

  def search
    @restaurants = Restaurant.search params[:search]
  end

  def search_by_location
    cookies.permanent.signed[:province_name] = params[:province_name]
    cookies.permanent.signed[:district_name] = params[:district_name]
    cookies.permanent.signed[:ward_name] = params[:ward_name]
    cookies.permanent.signed[:search_near_me] = false
  end

  def search_near_me
    cookies.permanent.signed[:latitude] = params[:latitude]
    cookies.permanent.signed[:longitude] = params[:longitude]
    cookies.permanent.signed[:search_near_me] = true
  end

  def show
    store_location
    remember_res params[:id]

    # For show
    @foods = @restaurant.foods
    @rated = @restaurant.rated?
    @point_names = get_point_names

    @average_point = @restaurant.get_average_point
    @ratings = @restaurant.ratings
    if current_user
      @avatar = get_avatar_url(current_user.id)
    end
    @comments = @restaurant.comments.where(comment_id: nil).ordered_by_created_at
    @embed_location_map_url = @restaurant.get_geolocation_embed_url
    # For create
    @rating = Rating.new
    @comment = Comment.new
    @order_detail = OrderDetail.new
  end

  private
    def find_restaurant
      @restaurant = Restaurant.find_by(id: params[:id])

      return unless @restaurant.nil?
      render "layouts/notfound"
    end
end
