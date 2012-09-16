class ZipCodeController < ApplicationController
  def index
  end

  def nearby_zip_codes
    logger.info "87: params = #{params.inspect}"
    #binding.pry

    #lat = 37
    #long = -122
    #radius = 20

    @query = {
      :latitude      => params[:latitude],
      :longitude     => params[:longitude],
      :radius        => params[:radius]
    }

    @zc_list = ZipCode.neighbors params[:latitude], params[:longitude], params[:radius]
  end
end
