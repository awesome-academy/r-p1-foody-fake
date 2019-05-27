class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  def average_point
    (space_point + location_point + service_point + price_point + quality_point) / 5
  end
end
