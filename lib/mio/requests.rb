class Mio
  module Requests
    @@content_type = 'application/vnd.nativ.mio.v1+json'

    def self.get agent, url, opts
      make_request :get, agent, url, opts
    end

    def self.post agent, url, opts, body
      make_request :post, agent, url, opts, body
    end

    private
    def self.make_request type, agent, url, opts, body=nil
      agent.method(type).call do |r|
        r.url url
        unless body.nil?
          r.body = body.to_json
        end
        r.headers[:content_type] = @@content_type
      end
    end

  end
end
