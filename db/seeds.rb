# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'

def setup_users
  puts 'SETTING UP DEFAULT USER LOGIN'
  user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
  puts 'New user created: ' << user.name

  user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please'
  puts 'New user created: ' << user2.name
  user.add_role :admin
end

ZIP_CODE_DATA_FILE    = 'data/http.federalgovernmentzipcodes.us.csv'
STATES_DATA_FILE      = 'data/states.csv'

def load_zip_codes
  puts
  puts "loading zip codes from:  #{ZIP_CODE_DATA_FILE}"

  ZipCode.transaction do
    CSV.foreach ZIP_CODE_DATA_FILE, {:headers => true} do |values|

      next unless values['ZipCodeType'].eql? 'STANDARD'

      ZipCode.create! do |zc_row|
        zc_row[:zip]          = values['Zipcode']
        zc_row[:state_code]   = values['State']

        zc_row[:latitude]     = values['Lat'].to_f
        zc_row[:longitude]    = values['Long'].to_f

        zc_row[:city]         = values['City']
        zc_row[:state]        = values['State']
      end
    end
  end
end

def load_states
  puts
  puts "loading states from:  #{STATES_DATA_FILE}"

  State.transaction do
    CSV.foreach STATES_DATA_FILE, {:headers => true} do |values|

      State.create! do |st|
        st[:name]          = values['State']
        st[:code]          = values['Abbreviation']
      end
    end
  end
end

#--------------- main ---------
setup_users

load_states

load_zip_codes
