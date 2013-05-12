require "my_active_record"
require 'models/user.rb'
require 'models/car.rb'
require 'models/detail.rb'
require 'pry'
require 'fileutils'

SPEC_ROOT = File.expand_path(File.dirname(__FILE__))

RSpec.configure do |config|
  config.before do
    FileUtils.copy_file("#{SPEC_ROOT}/database/cars.csv.sample", "#{SPEC_ROOT}/database/cars.csv")
    FileUtils.copy_file("#{SPEC_ROOT}/database/users.csv.sample", "#{SPEC_ROOT}/database/users.csv")
    FileUtils.copy_file("#{SPEC_ROOT}/database/details.csv.sample", "#{SPEC_ROOT}/database/details.csv")
    MyActiveRecord::Database.establish_connection(:adapter => "csv", :db_path => "spec/database")
  end

  config.after do
    FileUtils.rm("#{SPEC_ROOT}/database/cars.csv")
    FileUtils.rm("#{SPEC_ROOT}/database/users.csv")
    FileUtils.rm("#{SPEC_ROOT}/database/details.csv")
  end
end