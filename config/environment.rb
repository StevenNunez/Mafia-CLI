require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'mafia'
)
