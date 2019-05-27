class Ward < ApplicationRecord
  scope :ward_map, -> (district_id) { where(districtid: district_id) }
end
