module WardsHelper
  def get_wards districtid
    Ward.ward_map(districtid).map{|c| [c.name, c.wardid]}.to_h
  end
end
