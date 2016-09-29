shared_examples 'simple_client' do
  it 'instantiates' do
    expect(client).not_to be_nil
  end

  it 'creates a faraday object' do
    expect(client.instance_variable_get(:@agent)).to be_a(Faraday::Connection)
  end

  [:find_all, :create, :configure, :action].each do |public_method|
    it "responds to ##{public_method}" do
      expect(client).to respond_to(public_method)
    end
  end

  [:get, :post, :put, :make_object, :path].each do |private_method|
    it "has, but doesn't respond to, private method ##{private_method}" do
      expect(client.private_methods).to include(private_method)
    end
  end
end

shared_examples 'masteruser_masteruser_client' do
  it 'configures basic auth correctly' do
    expect(client.instance_variable_get(:@agent).headers['Authorization']).should_not eq(nil)
  end
end
