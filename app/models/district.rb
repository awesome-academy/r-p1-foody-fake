class District < ApplicationRecord
  scope :district_map, -> (province_id) { where(provinceid: province_id) }
end
