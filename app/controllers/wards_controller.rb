class WardsController < ApplicationController
  include WardsHelper
  def search
    @wards = get_wards params[:districtid]
    render json: @wards
  end
end
