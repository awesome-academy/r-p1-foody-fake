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

  mount_uploader :image, RestaurantPictureUploader
  validate :image_size
  def self.search(search)
    if search
      where("LOWER(name) LIKE :search", search: "%#{search.downcase}%")
    else
      Restaurant.first Settings.number_of_restaurants_on_home_page
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
    Rating.where(restaurant_id: self.id).average(name).round(Settings.number_of_round_point)
  end

  def get_average_point
    point_names = get_point_names
    point_array = []

    point_names.each_with_index do |val, index|
      point_array[index] = get_point val
    end

    return point_array.reduce(:+) / point_array.size.to_f
  end

  def total_rating
    Rating.where(restaurant_id: self.id).size
  end

  def image_size
    return unless image.size > Settings.maxmimum_image_size.megabytes
    errors.add(:image, t("image_size_info"))
  end
end
