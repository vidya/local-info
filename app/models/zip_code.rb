class ZipCode < ActiveRecord::Base
  include ZipCodeHelper

  attr_accessible :city, :state, :latitude, :longitude, :state_code, :zip

  def self.neighbors(query)
    case query[:query_type]
      when 'city_state'
        # find (latitude, longitude) co-ordinates for each zip code in city and state
        lat_long_list = zip_codes_in_city(query[:city], query[:state]).inject([]) do |list, ent|
          list << [ent.latitude, ent.longitude]
        end

        # find zip codes within the specified distance of each (latitude, longitude) pair
        zc_list  = zip_codes_from_lat_long_list lat_long_list, query[:radius]

      when 'zip_code'
        zc_entry  = find_by_zip query[:zip_code]
        zc_list   = zip_codes_from_lat_long zc_entry.latitude, zc_entry.longitude, query[:radius]

      when 'latitude_longitude'
        zc_list   = zip_codes_from_lat_long query[:latitude], query[:longitude], query[:radius]

      else
        raise "--- ERROR: unexpected query_type = #{query[:query_type]}"
    end

    zc_list
  end

  def self.zip_codes_in_city(given_city, given_state)
    where(:city => normalize_name(given_city), :state => normalize_name(given_state)).all
  end

  def self.zip_codes_from_lat_long_list(lat_long_list, radius)
    zc_list = lat_long_list.inject([]) do |list, lat_long|
      list += zip_codes_from_lat_long lat_long.shift, lat_long.shift, radius
    end

    zc_list.uniq!

    zc_list.sort! do |a, b|
      (a.state_code + a.city + a.zip) <=> (b.state_code + b.city + b.zip)
    end

    zc_list
  end

  def self.zip_codes_from_lat_long(lat, long, radius)
    Locality.new(lat, long, radius).find_zip_codes
  end

  def self.valid_zip_code?(zip_code)
    where(:zip => zip_code).exists?
  end

  def self.normalize_name(name)
    name_segments   = name.split(/ /)
    new_segments    = name_segments.map { |seg| seg.downcase.capitalize }

    new_segments.join ' '
  end

  def self.valid_city_and_state?(given_city, given_state)
    exists?(:city => normalize_name(given_city), :state => normalize_name(given_state))
  end
end
