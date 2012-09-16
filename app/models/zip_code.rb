class ZipCode < ActiveRecord::Base
  attr_accessible :city, :state, :latitude, :longitude, :state_code, :zip

  def self.neighbors(lat, long, radius)
    loc = Locality.new(lat, long, radius)

    zc_list = loc.find_zipcodes
    #loc.print_neighbors('zipcodes', zc_list)
  end

  #MILES_PER_ARC_DEGREE = 69.09
  #
  ##---- getting a list of neighboring zipcodes  -----------
  ## delineate a 'rectangle' on earth's surface that is a
  ## superset of the 'circle' on earth's surface with center
  ## at (lat, long) and given radius
  ##
  #
  #def self.find_zip_codes(in_latitude, in_longitude, radius)
	 # west_long, east_long, south_lat, north_lat =  calc_geo_rect(in_latitude, in_longitude, radius)
  #  #binding.pry
  #  # zip_codes = [zip codes within given radius of (lat, long)]
  #  ZipCode.find(:all, :conditions =>
  #      ["longitude  > ? and longitude < ?
  #      and latitude > ? and latitude < ?",
  #      west_long, east_long, south_lat, north_lat]).select do |zc|
  #
  #    #binding.pry
	 #   #distance(zc.latitude.to_f, zc.longitude.to_f) <= @radius
  #
  #    logger.info "zc = #{zc.inspect}"
	 #   distance(zc.latitude.to_f, zc.longitude.to_f) <= radius
  #  end
  #end
  #
  ## geo_rect: 'rectangle' on earth's surface specified by
  ##           [west_long, east_long, south_lat, north_lat]
  #def self.calc_geo_rect(in_latitude, in_longitude, in_radius)
	 # deg_radius = (in_radius / MILES_PER_ARC_DEGREE).ceil
  #
	 # west_long = (in_longitude - deg_radius).floor
	 # east_long = (in_longitude + deg_radius).ceil
  #
	 # south_lat = (in_latitude - deg_radius).floor
	 # north_lat = (in_latitude + deg_radius).ceil
  #
	 # [west_long, east_long, south_lat, north_lat]
  #end
  #
  #
  ##---- distance between two points on earth { -----------
  #
  ##-- python algorithm for distance calculation
  ##-- at http://zips.sourceforge.net/#dist_calc
  ##def calcDist(lat_A, long_A, lat_B, long_B):
  ##  distance = (sin(radians(lat_A)) *
  ##              sin(radians(lat_B)) +
  ##              cos(radians(lat_A)) *
  ##              cos(radians(lat_B)) *
  ##              cos(radians(long_A - long_B)))
  ##
  ##  distance = (degrees(acos(distance))) * 69.09
  ##
  ##  return distance
  #
  #def self.radians(deg)
	 # deg * (Math::PI / 180)
  #end
  #
  #def self.degrees(rad)
	 # rad * (180 / Math::PI)
  #end
  #
  ## algorithm adapted from http://zips.sourceforge.net/#dist_calc
  #def self.distance(lat_B, long_B)
  #  r_lat_B = radians lat_B
  #  r_long_B = radians long_B
  #
	 # dist = (  Math::sin(@rad_center_lat) * Math::sin(r_lat_B) +
	 #           Math::cos(@rad_center_lat) * Math::cos(r_lat_B) *
  #            Math::cos(radians(@center_long - long_B)))
  #
	 # self.degrees(Math::acos(dist)) * MILES_PER_ARC_DEGREE
  #end
  ##---- } distance between two points on earth -----------


end
