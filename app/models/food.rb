class Food < ApplicationRecord
  belongs_to :restaurant

  mount_uploader :image, FoodPictureUploader

  validates :name, presence: true, length: { maximum: Settings.maximum_food_name }
  validates :price, presence: true
  validates :restaurant_id, presence: true
  validate :image_size

  def image_size
    return unless image.size > Settings.maxmimum_image_size.megabytes
    errors.add(:image, t("image_size_info"))
  end
end
