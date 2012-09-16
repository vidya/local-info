class ZipCode < ActiveRecord::Base
  attr_accessible :city, :state, :latitude, :longitude, :state_code, :zip

  def self.neighbors(lat, long, radius)
    loc = Locality.new(lat, long, radius)

    zc_list = loc.find_zipcodes
    #loc.print_neighbors('zipcodes', zc_list)
  end
end
