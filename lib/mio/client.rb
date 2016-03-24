require 'faraday'
require 'hashie/mash'
require 'net/http/persistent'
require 'json'

require 'pp'

require 'mio/requests'

class Mio
  class Client

    def initialize base_uri, username, password
      @base_uri = base_uri
      @agent = Faraday.new(url: base_uri) do |f|
        f.adapter :net_http_persistent
      end
      @agent.basic_auth(username, password)
    end

    def find_all resource, opts={}
      url = path(resource)
      response = get url, opts

      unless response.success?
        raise Mio::Client::LoadOfBollocks, "GET on #{url} returned #{response.status}"
      end

      make_object response.body
    end

    def find resource, id, opts={}
      obj = find_all(resource, opts).find{|f| f.id == id}
    end

    def create resource, payload, opts={}
      url = path(resource)
      response = post url, payload, opts
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "POST on #{url}, with #{payload.inspect} returned #{response.status}"
      end

      make_object response.body
    end

    def update resource, id, payload, opts={}

    end

    private
    def get url, opts
      Mio::Requests.get @agent, url, opts
    end

    def post url, payload, opts
      Mio::Requests.post @agent, url, opts, payload
    end

    def make_object response
      Hashie::Mash.new JSON.parse(response)
    end

    def path resource
      "#{@base_uri}/#{resource.sub(/^\//, '')}"
    end

  end
end
