class ZipCodeController < ApplicationController
  include ZipCodeHelper

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

    if valid_query? @query
      flash.clear

      @zc_list = ZipCode.neighbors(@query)
      @zc_count = @zc_list.size

      @zc_list = Kaminari.paginate_array(@zc_list).page(params[:page])

    else
      flash[:error] = get_query_error
      render :action => :index
    end
  end
end
