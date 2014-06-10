require 'bundler/setup'
Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'mafia'
)
Dir[File.join(__dir__, "../app/models", "*.rb")].each {|f| require f}
