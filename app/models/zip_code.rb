class ZipCode < ActiveRecord::Base
  include ZipCodeHelper

  attr_accessible :city, :state, :latitude, :longitude, :state_code, :zip

  def self.neighbors(query)
    #binding.pry

    lat_long_list = []

    case query[:query_type]
      when 'latitude_longitude'
        lat_long_list << [query[:latitude], query[:longitude]]

      when 'zip_code'
        zc_entry  =  find_by_zip query[:zip_code]

        lat_long_list << [zc_entry.latitude, zc_entry.longitude]

      when 'city_state'
        zc_entries = where(:city => query[:city], :state => query[:state]).all

        zc_entries.inject(lat_long_list) { |list, ent| list << [ent.latitude, ent.longitude] }

      else
        logger.info "--- ERROR: unexpected query_type = #{query[:query_type]}"
    end

    zc_list = []

    lat_long_list.each do |lat_long|
      loc = Locality.new(lat_long.shift, lat_long.shift, query[:radius])
      zc_list += loc.find_zip_codes
    end

    zc_list.uniq!

    #loc.print_neighbors('zipcodes', zc_list)
    zc_list
  end

  def self.valid_zip_code?(zip_code)
    where(:zip => zip_code).exists?
  end
end
