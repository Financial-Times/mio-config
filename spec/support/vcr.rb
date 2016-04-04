VCR.configure do |c|
  c.cassette_library_dir = File.join(File.dirname(__FILE__),
                                     '..',
                                     'fixtures',
                                     'vcr_cassettes')
  c.hook_into :faraday
  c.default_cassette_options = {record: :new_episodes}

  c.around_http_request do |request|
    VCR.use_cassette('client', match_requests_on: [:method, :uri, :body], &request)
  end
end
