module HomeHelper
  require 'httparty'
  require 'nokogiri'

  #def get_theatres
  #
  #  api_url = "http://api.citygridmedia.com/content/places/v2/search/"
  #  query_string = "where?format=xml&type=movietheater&where=95014&publisher=test"
  #  #city_grid_api_url = "http://api.citygridmedia.com/content/places/v2/search/where?type=movietheater&where=95014&publisher=test"
  #
  #  #response = HTTParty.get('http://twitter.com/statuses/public_timeline.json')
  #  response = HTTParty.get(api_url + query_string)
  #
  #  doc = Nokogiri::XML::Document.parse(response.body)
  #
  #  #theatre_list = doc.xpath "//name"
  #  theatre_list = doc.xpath "//location/name"
  #
  #  theatre_list.each do |th|
  #    puts "#{th.content}"
  #    binding.pry
  #  end
  #
  #  #binding.pry
  #  theatre_list
  #
  #  #puts response.body, response.code, response.message, response.headers.inspect
  #
  #  #response.each do |item|
  #  #  puts item['user']['screen_name']
  #  #end
  #end

  def get_xml_doc(params)
    api_url         = "http://api.citygridmedia.com/content/places/v2/search/"

    query_string    = "where?format=xml&publisher=#{params[:publisher]}"

    query_string   += "&type=#{params[:type]}"
    query_string   += "&where=#{params[:zipcode]}"

    response = HTTParty.get(api_url + query_string)
    puts response.body, response.code, response.message, response.headers.inspect

    Nokogiri::XML::Document.parse(response.body)
  end

  def get_theatre_info(start_pt)
    doc = start_pt

    name_list         = doc.xpath('//locations/location/name')
    profile_list      = doc.xpath('//locations/location/profile')

    names             = name_list.map { |nm| nm.text }
    profiles          = profile_list.map { |pr| pr.text }

    names.zip profiles
  end

  def get_theatres(params)
    doc = get_xml_doc({
                        publisher:    'test',

                        #zipcode:      '95014',
                        zipcode:      params[:zip_code],
                        type:         'movietheater'
                      })

    name_profiles = get_theatre_info doc

    name_profiles.each { |nm, pr| puts "--- v27: (name, profile) = (#{nm}, #{pr})" }

    #binding.pry
    name_profiles
  end
end
