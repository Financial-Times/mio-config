class Mio
  class Events < Mio::Client
    def self.all
      Hashie::Mash.new get('/api/events')
    end
  end
end
