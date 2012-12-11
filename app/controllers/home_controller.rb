class HomeController < ApplicationController
  include HomeHelper
  include NeighborhoodHelper

  before_filter :authenticate_user!

  def index
    @user = current_user
    flash.delete :notice
  end

  def show_area
    @params                   = params
    @user                     = current_user

    @query = {
      query_type:      'zip_code',

      zip_code:        params[:zip_code],
    }

    if valid_query? @query
      flash.clear

      @params[:theatre_profiles]   = get_theatres params

    else
      flash[:error] = @query_error
      redirect_to  action: :index
    end
  end

  def neighborhood

  end

  def show_places
    @params                   = params
    @user                     = current_user

    @query = {
      query_type:      'zip_code',

      zip_code:        params[:zip_code],
    }

    nb = Neighborhood.new params
    nb.set_lat_long

    list = nb.restaurants

    render :text => "SHOW PLACES: #{params.inspect}: #{list.inspect}"

    #if valid_query? @query
    #  flash.clear
    #
    #  @params[:theatre_profiles]   = get_theatres params
    #
    #else
    #  flash[:error] = @query_error
    #  redirect_to  action: :index
    #end
  end

  def add_neighbor
    render :text => 'FROM add_neighbor'
  end

  private
  def valid_query?(query)
    @query_error = nil

    errors = []
    case query[:query_type]
      when 'zip_code'
        zip_code   = query[:zip_code]
        errors    << "invalid zip code (= #{zip_code})" unless ZipCode.valid_zip_code?(zip_code)

      else
        raise "--- ERROR: unexpected query_type = #{query[:query_type]}"
    end

    @query_error = 'ERROR(S): [ ' + errors.join(', ') + ' ]' unless errors.empty?

    errors.empty?
  end
end
