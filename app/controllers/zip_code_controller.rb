class ZipCodeController < ApplicationController
  def index
  end

  def nearby_zip_codes
    puts '87: params = ', params.inspect

    lat = params[:lat]
    long = params[:long]
    radius = params[:radius]

    lat = 37
    long = -122
    radius = 20

    loc = Locality.new(lat, long, radius)

    @zc_list = loc.find_zipcodes
    loc.print_neighbors('zipcodes', @zc_list)
  end
end
