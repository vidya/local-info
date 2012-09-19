class ZipCodeController < ApplicationController
  def index
  end

  def nearby_zip_codes
    logger.info "87: params = #{params.inspect}"

    @query = {
      :query_type     => params[:query_type],

      :zip_code       => params[:zip_code],
      :city           => params[:city],
      :state          => params[:state],

      :latitude       => params[:latitude],
      :longitude      => params[:longitude],
      :radius         => params[:radius]
    }

    @zc_list = ZipCode.neighbors @query
  end
end
