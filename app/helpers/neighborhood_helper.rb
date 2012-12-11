module NeighborhoodHelper
  class Neighborhood
    include ActiveModel::Validations

    validates_presence_of :street_address, :city, :state, :zipcode, :radius

    attr_accessor :street_address, :city, :state, :zipcode, :radius, :latitude, :longitude


    def initialize(params)
      @street_address     = params['street_address']
      @city               = params['city']
      @state              = params['state']
      @zipcode            = params['zipcode']
      @radius             = params['radius']

      puts "@street_address = #{@street_address}"
    end

    def set_lat_long
      addr = addr_string
      puts "create_from_address: addr = #{addr}"

      geo_addr      = Geocoder.search addr

      @latitude     = geo_addr[0].geometry['location']['lat']
      @longitude    = geo_addr[0].geometry['location']['lng']
    end

    def addr_string
      "#{street_address}, #{city},  #{state} #{zipcode}"
    end

    def addr_coordinates(addr)
      geo_addr       = Geocoder.search addr

      latitude     = geo_addr[0].geometry['location']['lat']
      longitude    = geo_addr[0].geometry['location']['lng']

      [latitude, longitude]
    end

    #def addresses_in_radius(radius)
    #  addr = "#{street_address}, #{city},  #{state} #{zipcode}"
    #  hc1 = addr_coordinates addr
    #
    #  addr_list = []
    #
    #  LocalAddress.all.each do |loc_addr|
    #    hc2 = [loc_addr.lat_long[0].to_f, loc_addr.lat_long[1].to_f]
    #
    #    dist = Geocoder::Calculations.distance_between(hc1, hc2)
    #
    #    addr_list << [loc_addr.name_addr, dist] if dist <= radius
    #  end
    #  binding.pry
    #
    #  addr_list
    #end

    def lat_long
      [latitude, longitude]
    end

    def restaurants
      places_api_uri    = "https://maps.googleapis.com/maps/api/place/search/"
      output_format     = "xml"

      # radius is in meters ( 1 mile = 1609.34 meters)
      params            = "?"
      #params           += "location=#{latitude},#{longitude}&radius=5000"
      binding.pry
      #
      radius_in_meters  = @radius.to_f * 1609.34
      params           += "location=#{latitude},#{longitude}&radius=#{radius_in_meters}"

      params           += "&types=restaurant&sensor=false"

      # api key from https://code.google.com/apis/console/#project:785982572829:access
      #api_key           = "&key=AIzaSyDTGrWDoR1HTdRVV6r5NmC-hS2AZk3o71c"

      #api_key           = "&key=AIzaSyBVx-36OJa0F0Gxej9cw7jmtkQ8FiHOZ2U"
      #api_key           = "&key=AIzaSyCIzdWGT-VWZDwegNVUpG5yEL_DJbv65gM"
      #api_key           = "&key=AIzaSyA3zjZvZkjDOZNXVI-VZRWToI9kXQM89C0"
      api_key           = "&key=AIzaSyDTGrWDoR1HTdRVV6r5NmC-hS2AZk3o71c"

      uri_string        = places_api_uri + output_format + params + api_key

      puts "--- api_key = #{api_key}"
      puts "--- uri_string = #{uri_string}"
      response          = RestClient.get(uri_string)

      print response.body

      doc               = Nokogiri::XML::Document.parse(response.body)
      name_list         = doc.xpath('//result/name')
      #binding.pry

      name_list.each { |nm| puts "restaurant: #{nm.text}" }
      name_list.map { |nm| "#{nm.text}" }
    end
  end
end
