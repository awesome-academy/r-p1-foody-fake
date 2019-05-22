class RestaurantsController < ApplicationController

  include CommentsHelper
  include RestaurantsHelper

  before_action :find_restaurant, only: %i(show)

  def index ;end

  def search
    @restaurants = Restaurant.search(params[:search])
  end

  def show
    remember_res params[:id]

    @rated = @restaurant.rated?
    @point_names = get_point_names

    # For show
    @foods = @restaurant.foods
    if current_user
      @avatar = get_avatar_url(current_user.id)
    end
    @comments = @restaurant.comments.where(comment_id: nil).ordered_by_created_at

    # For create
    @rating = Rating.new
    @comment = Comment.new
    @order_detail = OrderDetail.new
    byebug
  end

  private
    def find_restaurant
      @restaurant = Restaurant.find_by(id: params[:id])

      return unless @restaurant.nil?
      render "layouts/notfound"
    end
end



