module ZipCodeHelper

  def display_form(name)
    name_segments   = name.split(/ /)
    new_segments    = name_segments.map { |seg| seg.downcase.capitalize }

    #binding.pry
    new_segments.join ' '
  end

  class Locality
    MILES_PER_ARC_DEGREE  = 69.09

    # to ensure that acos() is not given an argument > 1
    DELTA_DIFF   = 0.00005

    def initialize(lat, long, radius)
      @center_lat         = lat.to_f
      @center_long        = long.to_f
      @radius             = radius.to_f

      @rad_center_lat     = radians @center_lat
      @rad_center_long    = radians @center_long
    end

    #---- getting a list of neighboring zipcodes  -----------
    # delineate a 'rectangle' on earth's surface that is a
    # superset of the 'circle' on earth's surface with center
    # at (lat, long) and given radius
    #

  	def find_zip_codes
  	  west_long, east_long, south_lat, north_lat =  calc_geo_rect

      zc_list = ZipCode.order("state_code, city, zip").all :conditions => "    longitude > #{west_long} and longitude < #{east_long}
                                            and latitude  > #{south_lat} and latitude  < #{north_lat}"

      zc_list.select { |zc| distance(zc.latitude.to_f, zc.longitude.to_f) <= @radius }
  	end

    #--------- private helpers --------------
    private

    # geo_rect: 'rectangle' on earth's surface specified by
    #           [west_long, east_long, south_lat, north_lat]
    def calc_geo_rect
  	  deg_radius = (@radius / MILES_PER_ARC_DEGREE).ceil

  	  west_long     = (@center_long - deg_radius).floor
  	  east_long     = (@center_long + deg_radius).ceil

  	  south_lat     = (@center_lat - deg_radius).floor
  	  north_lat     = (@center_lat + deg_radius).ceil

  	  [west_long, east_long, south_lat, north_lat]
    end

  	def radians(deg)
  	  deg * (Math::PI / 180)
  	end

  	def degrees(rad)
  	  rad * (180 / Math::PI)
  	end

  	# algorithm adapted from http://zips.sourceforge.net/#dist_calc
    def distance(dest_latitude, dest_longitude)
      rad_dest_latitude = radians dest_latitude

  	  dist    = Math::sin(@rad_center_lat) * Math::sin(rad_dest_latitude)
      dist   += Math::cos(@rad_center_lat) * Math::cos(rad_dest_latitude) * Math::cos(radians(@center_long - dest_longitude))

      if dist > 1
        raise "(dist = #{dist}) > 1" if dist > (1 + DELTA_DIFF)

        dist = 1
      end

  	  degrees(Math::acos(dist)) * MILES_PER_ARC_DEGREE
  	end
  end
end
