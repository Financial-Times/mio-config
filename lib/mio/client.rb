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

    def configure resource, id, payload, opts={}
      url = path(resource, id, :configuration)
      response = put url, payload, opts
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "PUT on #{url}, with #{payload.inspect} returned #{response.status}"
      end

      make_object response.body
    end

    def action resource, id, payload, opts={}
      url = path(resource, id, :actions)
      statuses = get url, opts

      if JSON.parse(statuses.body).find{|h| h['action'] == payload[:action]}
        response = post url, payload, opts

        unless response.success?
          raise Mio::Client::LoadOfBollocks, "PUT on #{url}, with #{payload.inspect} returned #{response.status}"
        end

        make_object response.body
      end
    end

    private
    def get url, opts
      Mio::Requests.make_request :get, @agent, url, opts
    end

    def post url, payload, opts
      Mio::Requests.make_request :post, @agent, url, opts, payload
    end

    def put url, payload, opts
      Mio::Requests.make_request :put, @agent, url, opts, payload
    end

    def make_object response
      Hashie::Mash.new JSON.parse(response)
    end

    def path resource, id=nil, endpoint=nil
      path_string = "#{@base_uri}/#{resource.sub(/^\//, '')}"
      path_string += "/#{id}" if id
      path_string += "/#{endpoint.to_s}" if endpoint
      path_string
    end

  end
end
