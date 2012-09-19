class ZipCode < ActiveRecord::Base
  attr_accessible :city, :state, :latitude, :longitude, :state_code, :zip

  def self.neighbors(query)
    #binding.pry

    #zc_list = []
    radius        = query[:radius]
    case query[:query_type]
      when 'latitude_longitude'
        lat       = query[:latitude]
        long      = query[:longitude]
        radius    = query[:radius]

        loc = Locality.new(lat, long, radius)

        zc_list = loc.find_zipcodes

      when 'zip_code'
        zip_code_entry =  find_by_zip query[:zip_code]

        lat            = zip_code_entry.latitude
        long           = zip_code_entry.longitude
        radius        = query[:radius]

        loc = Locality.new(lat, long, radius)

        zc_list = loc.find_zipcodes
        #binding.pry

      when 'city_state'
        city = query[:city]
        state = query[:state]
        city_state_entries = where(:city => city, :state => state).all

        lat_long_list = city_state_entries.inject([]) { |list, ent|  list << [ent.latitude, ent.longitude] }

        zc_list = []

        lat_long_list.each do |lat_long|
          loc = Locality.new(lat_long.shift, lat_long.shift, radius)
          zc_list += loc.find_zipcodes
        end
        zc_list.uniq!
        #binding.pry

      else
        logger.info "--- ERROR: unexpected query_type = #{query[:query_type]}"
    end

    #loc.print_neighbors('zipcodes', zc_list)
    zc_list
  end

  def self.valid_zip_code?(zip_code)
    where(:zip => zip_code).exists?
  end
end
