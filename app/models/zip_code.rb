class ZipCode < ActiveRecord::Base
  include ZipCodeHelper

  attr_accessible :city, :state, :latitude, :longitude, :state_code, :zip

  def self.neighbors(query)
    case query[:query_type]
      when 'latitude_longitude'
        zc_list   = zip_codes_from_lat_long query[:latitude], query[:longitude], query[:radius]

      when 'zip_code'
        zc_entry  = find_by_zip query[:zip_code]
        zc_list   = zip_codes_from_lat_long zc_entry.latitude, zc_entry.longitude, query[:radius]

      when 'city_state'
        zc_entries    = where(:city => query[:city], :state => query[:state]).all

        lat_long_list = zc_entries.inject([]) { |list, ent| list << [ent.latitude, ent.longitude] }

        zc_list       = zip_codes_from_lat_long_list lat_long_list, query[:radius]

      else
        logger.info "--- ERROR: unexpected query_type = #{query[:query_type]}"
    end

    zc_list
  end

  def self.zip_codes_from_lat_long_list(lat_long_list, radius)
    zc_list = lat_long_list.inject([]) do |list, lat_long|
      list += zip_codes_from_lat_long lat_long.shift, lat_long.shift, radius
    end

    zc_list.uniq!

    zc_list
  end

  def self.zip_codes_from_lat_long(lat, long, radius)
    Locality.new(lat, long, radius).find_zip_codes
  end

  def self.valid_zip_code?(zip_code)
    where(:zip => zip_code).exists?
  end
end
