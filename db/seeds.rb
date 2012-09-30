# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def setup_users
  puts 'SETTING UP DEFAULT USER LOGIN'
  user = User.create! :name => 'First User', :email => 'user@example.com', :password => 'please', :password_confirmation => 'please'
  puts 'New user created: ' << user.name

  user2 = User.create! :name => 'Second User', :email => 'user2@example.com', :password => 'please', :password_confirmation => 'please'
  puts 'New user created: ' << user2.name
  user.add_role :admin
end

ZIP_CODE_DATA_FILE = 'data/http.federalgovernmentzipcodes.us.csv'

def load_zip_codes
  require 'csv'

  puts
  puts "start: load_zip_codes(): data file: #{ZIP_CODE_DATA_FILE}"

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

  puts "end: load_zip_codes()"
end

def load_states
  [
    ["Alabama", 				      "AL"],
    ["Alaska", 				        "AK"],
    ["Arizona", 				      "AZ"],

    ["Arkansas", 				      "AR"],
    ["California", 				    "CA"],
    ["Colorado", 				      "CO"],

    ["Connecticut", 			    "CT"],
    ["Delaware", 				      "DE"],
    ["District of Columbia", 	"DC"],

    ["Florida", 				      "FL"],
    ["Georgia", 				      "GA"],
    ["Hawaii", 				        "HI"],

    ["Idaho", 				        "ID"],
    ["Illinois", 				      "IL"],
    ["Indiana", 				      "IN"],

    ["Iowa", 				          "IA"],
    ["Kansas", 				        "KS"],
    ["Kentucky", 				      "KY"],

    ["Louisiana", 				    "LA"],
    ["Maine", 				        "ME"],
    ["Montana", 				      "MT"],

    ["Nebraska", 				      "NE"],
    ["Nevada", 				        "NV"],
    ["New Hampshire", 		    "NH"],

    ["New Jersey", 				    "NJ"],
    ["New Mexico", 				    "NM"],
    ["New York", 				      "NY"],

    ["North Carolina", 		    "NC"],
    ["North Dakota", 	  	    "ND"],
    ["Ohio", 				          "OH"],

    ["Oklahoma", 				      "OK"],
    ["Oregon", 				        "OR"],
    ["Maryland", 				      "MD"],

    ["Massachusetts", 		    "MA"],
    ["Michigan", 			  	    "MI"],
    ["Minnesota", 				    "MN"],

    ["Mississippi", 			    "MS"],
    ["Missouri", 			  	    "MO"],
    ["Pennsylvania", 			    "PA"],

    ["Rhode Island", 			    "RI"],
    ["South Carolina", 		    "SC"],
    ["South Dakota", 			    "SD"],

    ["Tennessee", 				    "TN"],
    ["Texas", 				        "TX"],
    ["Utah", 				          "UT"],

    ["Vermont", 				      "VT"],
    ["Virginia", 				      "VA"],
    ["Washington", 				    "WA"],

    ["West Virginia", 		    "WV"],
    ["Wisconsin", 				    "WI"],
    ["Wyoming", 			  	    "WY"]

  ].each do |name, code|

    State.create! do |st|
      st.name   = name
      st.code   = code
    end
  end
end

#--------------- main ---------
setup_users

load_zip_codes

load_states
