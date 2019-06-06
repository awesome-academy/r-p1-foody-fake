class DistrictsController < ApplicationController
  include DistrictsHelper
  def search
    @districts = get_districts params[:provinceid]
    render json: @districts
  end
end
