class ZipCode < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :city, :state, :latitude, :longitude, :state_code, :zip
end
