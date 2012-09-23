class ZipCodeController < ApplicationController
  def index
  end

  def nearby_zip_codes
    logger.info "params = #{params.inspect}"

    @query = {
      :query_type     => params[:query_type],

      :zip_code       => params[:zip_code],
      :city           => params[:city],
      :state          => params[:state],

      :latitude       => params[:latitude],
      :longitude      => params[:longitude],
      :radius         => params[:radius]
    }

    if @query[:radius].to_f <= 0
      flash[:error] = 'ERROR: radius needs to be greater than 0'

    else
      flash.clear

      @zc_list = ZipCode.neighbors(@query)
      @zc_list = Kaminari.paginate_array(@zc_list).page(params[:page])
    end
  end
end
