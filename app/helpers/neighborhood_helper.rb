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

    def lat_long
      [latitude, longitude]
    end

    def restaurants
      places_api_uri    = "https://maps.googleapis.com/maps/api/place/search/"
      output_format     = "xml"

      # radius is in meters ( 1 mile = 1609.34 meters)
      params            = "?"

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
      next_uri_string        = places_api_uri + output_format + params + "&pagetoken=next_page_token" + api_key

      puts "--- api_key = #{api_key}"
      puts "--- uri_string = #{uri_string}"
      response          = RestClient.get(uri_string)

      print response.body

      doc               = Nokogiri::XML::Document.parse(response.body)
      name_list         = doc.xpath('//result/name')
      #binding.pry

      name_list.each { |nm| puts "restaurant: #{nm.text}" }

      total_list = []
      total_list += name_list

      #count = 1
      #np = doc.xpath '//next_page_token'
      #prev_np_token = np
      #while true
      #  break if np.nil?
      #  puts "--- loop count: #{count}, next_page_token = #{np.text} ----------"
      #
      #  #np_token = np.text
      #  #next_uri_string        = places_api_uri + output_format + params + "&pagetoken=#{np.text}" + api_key
      #  next_uri_string        = places_api_uri + output_format + "&pagetoken=#{np.text}" + api_key
      #  next_response          = RestClient.get next_uri_string
      #  next_doc               = Nokogiri::XML::Document.parse(next_response.body)
      #  next_name_list         = next_doc.xpath('//result/name')
      #
      #  #next_name_list.each { |nm| total_list << nm }
      #  total_list += next_name_list
      #  next_name_list.each { |nm| puts "restaurant: #{nm.text}" }
      #  #binding.pry
      #
      #  np = next_doc.xpath '//next_page_token'
      #  break if np.eql? prev_np_token
      #
      #  prev_np_token = np
      #
      #  count += 1
      #  break if count > 10
      #end
      #
      ##binding.pry
      ##puts "----------------------"
      #puts "total_list: #{total_list.inspect}"
      ##puts "----------------------"


      #binding.pry

      name_list.each { |nm| puts "restaurant: #{nm.text}" }
      name_list.map { |nm| "#{nm.text}" }
    end
  end
end
