
namespace :db_ops do
  desc 'initialize the database'
  task :init_db  do
    sh <<-STR
      dropdb        local_info_development
      createdb      local_info_development

      bundle exec   rake db:migrate
      bundle exec   rake db:seed
    STR
  end

  desc "load zip_codes table"
  task :load_zip_codes => [:environment] do
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
end