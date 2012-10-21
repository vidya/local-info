class ZipCodeController < ApplicationController
  before_filter :authenticate_user!

  attr_accessor :query_error

  def index
  end

  def nearby_zip_codes
    logger.info "params = #{params.inspect}"

    @query = {
      query_type:      params[:query_type],

      zip_code:        params[:zip_code],
      city:            params[:city],
      state:           params[:state],

      latitude:       params[:latitude],
      longitude:       params[:longitude],
      radius:          params[:radius]
    }

    if valid_query? @query
      flash.clear

      @zc_list    = ZipCode.neighbors(@query)
      @zc_count   = @zc_list.size

      @zc_list    = Kaminari.paginate_array(@zc_list).page(params[:page])

    else
      flash[:error] = query_error
      render action: :index
    end
  end

  private
  def valid_query?(query)
    @query_error = nil

    errors = []
    case query[:query_type]
      when 'zip_code'
        zip_code   = query[:zip_code]
        errors    << "invalid zip code (= #{zip_code})" unless ZipCode.valid_zip_code?(zip_code)

      when 'city_state'
        city       = query[:city]
        state      = query[:state]

        errors    << "invalid city (= #{city}) or state (= #{state})" unless ZipCode.valid_city_and_state?(city, state)

      when 'latitude_longitude'
        latitude   = query[:latitude].to_f
        longitude  = query[:longitude].to_f

        errors    << "invalid latitude (= #{latitude})" unless (-90.0..90.0).include?(latitude)
        errors    << "invalid longitude (= #{longitude})" unless (-180.0..180.0).include?(longitude)

      else
        raise "--- ERROR: unexpected query_type = #{query[:query_type]}"
    end

    radius   = query[:radius]
    errors  << "radius (= #{radius}) needs to be greater than 0" if radius.to_f <= 0

    @query_error = 'ERROR(S): [ ' + errors.join(', ') + ' ]' unless errors.empty?

    errors.empty?
  end
end
