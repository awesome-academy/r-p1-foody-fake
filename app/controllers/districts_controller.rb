class DistrictsController < ApplicationController
  def search
    @districts = District.where(provinceid: params[:provinceid]).map{|c| [c.name, c.districtid]}.to_h
    render json: @districts
  end
end
