class ZipCodeController < ApplicationController
  def index
  end

  def nearby_zip_codes
    logger.info "87: params = #{params.inspect}"
    #binding.pry

    #lat = 37
    #long = -122
    #radius = 20

    @zc_list = ZipCode.neighbors params[:latitude], params[:longitude], params[:radius]
    #@zc_list = ZipCode.neighbors lat, long, radius
  end
end
