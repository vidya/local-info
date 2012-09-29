
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
end