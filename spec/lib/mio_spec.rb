require 'spec_helper'

describe 'Mio' do
  let(:mio){build :mio}

  context 'when instantiating with args' do
    it 'creates an object' do
      expect(mio).not_to be_nil
    end
  end

  context 'when instantiating with a block' do
    let(:mio){Mio.new{|m| m.base_uri='example.com'; m.username='x'; m.password='x'}}
    it 'creates an object' do
      expect(mio).not_to be_nil
    end
  end

  context 'when created' do
    let(:client){mio.client}
    it_behaves_like 'simple_client'
    it_behaves_like 'masteruser_masteruser_client'

    [:base_uri, :base_uri=, :username, :username=, :password, :password=, :client].each do |m|
      it "responds to ##{m.to_s}" do
        expect(mio).to respond_to(m)
      end
    end
  end
end
