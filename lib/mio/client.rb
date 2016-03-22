require 'faraday'
require 'hashie/mash'
require 'net/http/persistent'

require 'pp'

class Mio
  class Client

    def initialize base_uri, username, password
      @base_uri = base_uri
      @content_type = 'application/vnd.nativ.mio.v1+json'

      pp username
      pp password

      @agent = Faraday.new(url: base_uri) do |f|
        f.adapter :net_http_persistent
        f.request :basic_auth, username, password
        #f.request :authorization, 'basic', 'bWFzdGVydXNlcjptYXN0ZXJ1c2Vy'
      end
    end

    def find_all uri, opts={}
      response = @agent.get do |req|
        req.url path(uri)
        req.headers = options(opts)
      end

      unless response.success?
        pp response
        p response.headers
        raise Mio::Client::LoadOfBollocks, "#{response.method.to_s.upcase} on #{path(uri)} returned #{response.status}"
      end

      Hashie::Mash.new response.body
    end

    private
    def options o
      o.merge!({content_type: @content_type})
      o
    end

    def path endpoint
      "#{@base_uri}/#{endpoint.sub(/^\//, '')}"
    end

  end
end
