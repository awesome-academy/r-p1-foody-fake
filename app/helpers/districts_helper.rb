module DistrictsHelper
  def get_districts provinceid
    District.district_map(provinceid).map{|c| [c.name, c.districtid]}.to_h
  end
end
