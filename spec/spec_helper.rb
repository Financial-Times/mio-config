$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
end

require 'factory_girl'
require 'faker'
require 'rspec'
require 'vcr'

require 'mio'

%w{support factories}.each do |d|
  Dir["./spec/#{d}/**/*.rb"].sort.each { |f| require f}
end
