require 'faraday'
require 'faraday/detailed_logger'
require 'json'
require 'mio/requests'
require 'net/http/persistent'
require 'nokogiri'
require 'ostruct'
require 'pp'

class Mio
  class Client

    def initialize base_uri, username, password
      @base_uri = base_uri
      @agent = Faraday.new(url: base_uri) do |f|
        f.adapter :net_http_persistent
        f.response :detailed_logger if ENV.fetch('VERBOSE', 'false').to_s.downcase == 'true'
      end
      @agent.basic_auth(username, password)
    end

    def find resource, id, opts={}, accept='application/json'
      url = path resource, id
      response = get url, opts, accept
      unless response.success? || response.status == 404
        raise Mio::Client::LoadOfBollocks, "GET on #{url}, returned #{response.status}"
      end

      h = make_object response.body
      h[:status] = response.status
      h
    end

    def find_all resource, opts={}, accept='application/json'
      url = path(resource)
      response = get url, opts, accept

      unless response.success?
        raise Mio::Client::LoadOfBollocks, "GET on #{url} returned #{response.status}"
      end
      make_object response.body
    end

    def create resource, payload, opts={}
      url = path(resource)
      response = post url, payload, opts
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "POST on #{url}, with #{payload.inspect} returned #{response.status}"
      end

      make_object response.body
    end

    def update resource, payload, opts={}
      url = path(resource)
      response = put url, payload, opts
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "PUT on #{url}, with #{payload.inspect} returned #{response.status}"
      end

      make_object response.body
    end

    def remove resource, id, opts={}
      url = path resource, id
      response = delete url, opts
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "DELETE on #{url} returned #{response.status}"
      end

      response.status
    end

    def configure resource, id, payload, opts={}
      url = path(resource, id, :configuration)
      response = put url, payload, opts
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "PUT on #{url}, with #{payload.inspect} returned #{response.status}"
      end

      make_object response.body
    end

    def definition resource, payload, opts={}
      url = path(resource)
      response = put url, payload, opts, 'application/vnd.nativ.mio.v1+xml'
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "PUT on #{url}, with #{payload.inspect} returned #{response.status}"
      end

      make_object response.body
    end


    def template resource, payload, opts={}
      url = path(resource)
      response = put url, payload, opts, 'text/html', 'text/html'
      unless response.success?
        raise Mio::Client::LoadOfBollocks, "PUT on #{url}, with #{payload.inspect} returned #{response.status}"
      end

      Nokogiri::HTML(response.body)
    end

    def action resource, id, payload, opts={}
      url = path(resource, id, :actions)
      statuses = get url, opts
      unless statuses.success?
        raise Mio::Client::LoadOfBollocks, "GET on #{url} returned #{statuses.status}"
      end

      if JSON.parse(statuses.body).find{|h| h['action'] == payload[:action]}
        response = post url, payload, opts

        unless response.success?
          raise Mio::Client::LoadOfBollocks, "PUT on #{url}, with #{payload.inspect} returned #{response.status}"
        end
        return make_object response.body
      end
    end

    private
    def get url, opts, accept='application/json'
      Mio::Requests.make_request :get, @agent, url, opts, accept
    end

    def post url, payload, opts
      Mio::Requests.make_request :post, @agent, url, opts, payload
    end

    def put url, payload, opts, content_type='application/vnd.nativ.mio.v1+json', accept='application/json'
      Mio::Requests.make_request :put, @agent, url, opts, payload, content_type, accept
    end

    def delete url, opts
      Mio::Requests.make_request :delete, @agent, url, opts
    end

    def make_object response
      JSON.parse(response)
    end

    def path resource, id=nil, endpoint=nil
      path_string = "#{@base_uri}/#{resource.sub(/^\//, '')}"
      path_string += "/#{id}" if id
      path_string += "/#{endpoint.to_s}" if endpoint
      path_string
    end

  end
end
