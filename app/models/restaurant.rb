class Restaurant < ApplicationRecord
  require "share_methods"
  include ShareMethods

  has_many :foods, foreign_key: "restaurant_id", dependent: :destroy
  has_many :ratings, foreign_key: "restaurant_id", dependent: :destroy
  has_many :comments, foreign_key: "restaurant_id", dependent: :destroy

  validates :name, presence: true
  validates :location, presence: true
  validates :open_time, presence: true
  validates :close_time, presence: true
  validate :image_size

  mount_uploader :image, RestaurantPictureUploader

  attr_accessor :distance_from_current_user

  class << self

    def search_by_location(province_name, district_name, ward_name)
      query_location = ward_name + ", " + district_name + ", " + province_name
      where("LOWER(location) LIKE :search", search: "%#{query_location.downcase}%")
    end

    def search(search)
      if search
        where("LOWER(name) LIKE :search", search: "%#{search.downcase}%")
      else
        Restaurant.first Settings.number_of_restaurants_on_home_page
      end
    end

    def search_near_me user_latitude, user_longitude
      @restaurants = Restaurant.where.not(latitude: nil, longitude: nil)
      distances = {}
      @restaurants.each do |restaurant|
        distances[restaurant.id] = calcalute_distance_with_coordinate user_latitude.to_f, user_longitude.to_f, restaurant[:latitude].to_f, restaurant[:longitude].to_f
      end
      sorted_distances = distances.sort_by {|_key, value| value}.to_h
      key_restaurants = sorted_distances.first(Settings.number_of_near_restaurants).to_h.keys
      @restaurants = Restaurant.where("id = ?", key_restaurants)
      return @restaurants
    end
  end

  def number_of_rated
    self.ratings.size
  end

  def rated?
    self.number_of_rated > Settings.default_number_of_rated ? true : false
  end

  def number_of_commented
    self.comments.where(comment_id: nil).size
  end

  def get_point name
    average_point = Rating.where(restaurant_id: self.id).average(name)
    if average_point
      return average_point.round(Settings.number_of_round_point)
    else
      return 0
    end
  end

  def get_average_point
    point_names = get_point_names
    point_array = []

    point_names.each_with_index do |val, index|
      point_array[index] = get_point val
    end

    return point_array.reduce(:+) / point_array.size.to_f
  end

  def get_geolocation_embed_url
    ENV["DOMAIN_GEOLOCATION_EMBED_MAP"] + "q=" + latitude.to_s + "," + longitude.to_s+"&key=" + ENV["API_EMBED_MAP_KEY"]
  end

  def image_size
    return unless image.size > Settings.maxmimum_image_size.megabytes
    errors.add(:image, t("image_size_info"))
  end

  def self.calcalute_distance_with_coordinate user_latitude, user_longitude, target_latitude, target_longitude

    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    dlat_rad = (target_latitude - user_latitude) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (target_longitude - user_longitude) * rad_per_deg

    #Convert to radian
    user_latitude *= rad_per_deg
    user_longitude *= rad_per_deg
    target_latitude *= rad_per_deg
    target_longitude *= rad_per_deg

    a = Math.sin(dlat_rad/2)**2 + Math.cos(user_latitude) * Math.cos(target_latitude) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    rm * c
  end
end
