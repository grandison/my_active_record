require "my_active_record"
require 'models/user.rb'
require 'models/car.rb'
require 'pry'

RSpec.configure do |config|
  config.before do
    MyActiveRecord::Database.establish_connection(:adapter => "csv", :db_path => "spec/database")
  end
end

