class LoadZipCodes < ActiveRecord::Migration
  require 'csv'

  def up
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
  end

  def down
    connection.execute 'delete from zip_codes'
  end
end
