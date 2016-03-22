require 'api_client'
require 'json'
require 'yaml'

class Mio

  class Client < ApiClient::Base
    @@config = YAML.load(File.read( File.join(File.dirname(__FILE__), '..', '..', 'config', 'config.yml')))
    @@resource  = '/api/events'

    connection do |c|
      c.handler.basic_auth(c.options[:user], c.options[:pass])
    end

    always do
      endpoint(@@config['base_url'])
      headers({"Content-Type" => "application/vnd.nativ.mio.v1+json"})
      options(user: @@config['user_name'], pass: @@config['password'])
    end

    def self.all
      Hashie::Mash.new get(@@resource)
    end

    def self.create_or_update(payload)
      p payload
      post(@@resource, payload)
    end

  end
end
