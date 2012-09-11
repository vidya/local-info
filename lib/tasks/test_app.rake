
task :test_models do
  #`dropdb local_info_test`
  #`createdb -O dad -T local_info_development local_info_test`
  #sh 'bundle exec rake test'

  sh <<-STR
    cd #{Rails.root}/test/unit
    ls -aCF

    #dropdb local_info_test
    #createdb local_info_test

    #createdb -O dad -T local_info_development local_info_test
    #bundle exec rake test:units

    pg_dump --data-only local_info_development >~/tmp/local_info_development.dmp

    #psql local_info_test < ~/tmp/local_info_development.dmp

    #bundle exec rake db:migrate
    bundle exec rake test:units
  STR

  puts "DONE"
end
