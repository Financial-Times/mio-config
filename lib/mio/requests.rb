class Mio
  module Requests
    @@content_type = 'application/vnd.nativ.mio.v1+json'

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
