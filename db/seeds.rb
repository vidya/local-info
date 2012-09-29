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

def load_zip_codes
  require 'csv'

  puts "start: load_zip_codes"

  ZipCode.transaction do
    CSV.foreach "data/zip_codes.csv" do |values|
      values.shift

      ZipCode.create! do |zc_row|
        zc_row[:zip]          = values.shift.strip
        zc_row[:state_code]   = values.shift.strip

        zc_row[:latitude]     = values.shift.strip.to_f
        zc_row[:longitude]    = values.shift.strip.to_f

        zc_row[:city]         = values.shift.strip
        zc_row[:state]        = values.shift.strip
      end
    end
  end

  puts "end: load_zip_codes"
end

#--------------- main ---------
setup_users

load_zip_codes
