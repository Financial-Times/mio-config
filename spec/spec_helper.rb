$LOAD_PATH.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
end

require 'rspec'
require 'mio/config'

%w{support factories}.each do |d|
  Dir["./spec/#{d}/**/*.rb"].sort.each { |f| require f}
end
