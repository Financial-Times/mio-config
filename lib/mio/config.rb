require 'client'

class Mio
  class Config

    def initialize
      @client = Mio::Client.new
    end

    def all
      resources
    end

    def resources
      storage
      folders
    end

    def storage

    end

    def folders

    end

  end
end
