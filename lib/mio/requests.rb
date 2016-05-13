class Mio
  module Requests

    def self.make_request type, agent, url, opts, body=nil, content_type='application/vnd.nativ.mio.v1+json'
      if content_type.nil?
        content_type = 'application/vnd.nativ.mio.v1+json'
      end
      agent.method(type).call do |r|
        r.url url
        unless body.nil?
          if content_type.include? 'json'
            r.body = body.to_json
          else
            r.body = body
          end
        end
        r.headers[:content_type] = content_type
      end
    end

  end
end
