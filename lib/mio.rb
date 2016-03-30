require 'mio/client'
require 'mio/errors'

require 'mio/model'
require 'mio/model/s3'
require 'mio/model/hotfolder'

class Mio

  attr_accessor :base_uri, :username, :password
  attr_reader :client
  def initialize
    @base_uri = nil
    @username = nil
    @password = nil

    yield self if block_given?
    @client = Mio::Client.new @base_uri, @username, @password
  end

end
