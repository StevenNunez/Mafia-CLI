require_relative 'config/environment'

namespace :db do
  # rake db:migrate
  desc "Runs all the migrations"
  task :migrate do
    ActiveRecord::Migrator.migrate('db/migrations')
  end

  desc "Rolls db back to version 0"
  task :rollback do
    ActiveRecord::Migrator.migrate('db/migrations', 0)
  end

  desc "Adds Seed data to the db"
  task :seed do
    puts "Loading Seed"
    require_relative 'db/seed'
    puts "Done loading seed"
  end

  desc "rollsback db, runs all migrations"
  task :reset => [:rollback, :migrate, :seed]
end
