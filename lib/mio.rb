require 'mio/client'
require 'mio/search'
require 'mio/errors'

require 'mio/model'
require 'mio/model/autoload'

class Mio

  attr_accessor :base_uri, :username, :password, :verify_ssl
  attr_reader :client
  def initialize base_uri=nil, username=nil, password=nil, verify_ssl=nil
    @base_uri = base_uri
    @username = username
    @password = password
    @verify_ssl = verify_ssl

    if block_given?
      yield self
    end

    @client = Mio::Client.new @base_uri, @username, @password, @verify_ssl
  end

end
