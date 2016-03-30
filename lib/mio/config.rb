require 'hashie/mash'
require 'yaml'
require 'erb'

class Mio
  class Config
    def self.read filename
      unless File.exist? filename
        raise Mio::Config::FileMissing, "The config file '#{filename}' is missing"
      end
      Hashie::Mash.new YAML.load( ERB.new(File.read(filename)).result )
    end
  end
end
