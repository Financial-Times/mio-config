$LOAD_PATH.unshift File.join(File.dirname(__FILE__), 'lib')
require 'rake'
require 'rspec/core/rake_task'
require 'mio/migrations'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec
