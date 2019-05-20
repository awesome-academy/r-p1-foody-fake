class StaticPageController < ApplicationController
  def home
    @restaurants = Restaurant.first(Settings.number_of_restaurants_on_home_page)
  end

  def help; end

  def about; end

  def contact; end
end
