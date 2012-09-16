class Locality
  MILES_PER_ARC_DEGREE = 69.09

  def initialize(lat, long, radius)
    @center_lat = lat.to_f
    @center_long = long.to_f
    @radius = radius.to_f

    @rad_center_lat = radians @center_lat
    @rad_center_long = radians @center_long

    puts "initialize(): center = #{@center.inspect}"
  end

  #---- getting a list of neighboring zipcodes  -----------
  # delineate a 'rectangle' on earth's surface that is a
  # superset of the 'circle' on earth's surface with center
  # at (lat, long) and given radius
  #

	def find_zipcodes
	  west_long, east_long, south_lat, north_lat =  calc_geo_rect

    # zip_codes = [zip codes within given radius of (lat, long)]
    ZipCode.all(:conditions =>
        ["longitude  > ? and longitude < ?
        and latitude > ? and latitude < ?",
        west_long, east_long, south_lat, north_lat]).select do |zc|

	    distance(zc.latitude.to_f, zc.longitude.to_f) <= @radius
    end
	end

  def print_neighbors(msg, nzc)
	  puts
	  puts "-------- #{msg} { ----------"
	  puts "nzc.length = #{nzc.length}"

	  nzc.each do |zc|
	    puts "[id, lat, long, zipcode, city, state] = [#{zc.id}, #{zc.latitude}, #{zc.longitude}, #{zc.zip}, #{zc.city}, #{zc.state}]"
	  end
	  
	  puts "nzc.length = #{nzc.length}" 
	  puts "-------- } #{msg} { ----------"
	  puts
  end

  #--------- private helpers --------------
  private

  # geo_rect: 'rectangle' on earth's surface specified by
  #           [west_long, east_long, south_lat, north_lat]
  def calc_geo_rect
	  deg_radius = (@radius / MILES_PER_ARC_DEGREE).ceil
	
	  west_long = (@center_long - deg_radius).floor
	  east_long = (@center_long + deg_radius).ceil
	
	  south_lat = (@center_lat - deg_radius).floor
	  north_lat = (@center_lat + deg_radius).ceil
	
	  [west_long, east_long, south_lat, north_lat]
  end

	def radians(deg)
	  deg * (Math::PI / 180)
	end
	
	def degrees(rad)
	  rad * (180 / Math::PI)
	end
	
	# algorithm adapted from http://zips.sourceforge.net/#dist_calc
	def distance(lat_B, long_B)
    r_lat_B = radians lat_B 
    r_long_B = radians long_B 

	  dist = (  Math::sin(@rad_center_lat) * Math::sin(r_lat_B) +
	            Math::cos(@rad_center_lat) * Math::cos(r_lat_B) * 
              Math::cos(radians(@center_long - long_B)))
	
	  degrees(Math::acos(dist)) * MILES_PER_ARC_DEGREE
	end
end
