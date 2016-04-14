require 'spec_helper'

describe 'Mio::Client' do
  let(:mio_client){build :valid_client}
  let(:mio_client_invalid_user){build :invalid_user_client}
  let(:mio_client_invalid){build :invalid_client}

  let(:create_payload){build(:create_json).to_h}
  let(:configure_payload){ {'vfs-location' => build(:configure_json).to_h} }
  let(:action_payload){build(:action_json).to_h}

  context 'with correct credentials' do
    let(:client){mio_client}
    it_behaves_like 'simple_client'
    it_behaves_like 'masteruser_masteruser_client'

    context 'when searching for a resource' do
      context 'with a valid resource' do
        let(:resource){'resources'}

        it '#find_all returns a Hashie::Mash' do
          expect(client.find_all(resource)).to be_a(Hash)
        end
      end

      context 'with an invalid resource' do
        let(:resource){'no-such-resource'}

        it '#find_all throws Mio::Client::LoadOfBollocks' do
          expect{ client.find_all('no-such-resource') }.to raise_error(Mio::Client::LoadOfBollocks)
        end
      end
    end

    context 'when creating a valid resource' do
      let(:resource){'resources'}

      xit 'successfully creates a new resource' do
        expect(client.create(resource, create_payload)).to be_a(Hash)
      end

      it 'successfully configures a new resource' do
        expect(client.configure(resource, 10943, configure_payload)).to be_an(Hash)
      end

      it 'successfully enables a new resource' do
        expect(client.action(resource, 10943, action_payload)).to be_an(Hash)
      end

    end

    context 'when creating an invalid resource' do
      let(:resource){'no-such-resource'}

      it 'successfully creates a new resource' do
        expect{client.create(resource, create_payload)}.to raise_error(Mio::Client::LoadOfBollocks)
      end

      it 'successfully configures a new resource' do
        expect{client.configure(resource, 0, configure_payload)}.to raise_error(Mio::Client::LoadOfBollocks)
      end

      it 'successfully enables a new resource' do
        expect{client.action(resource, 0, action_payload)}.to raise_error(Mio::Client::LoadOfBollocks)
      end

    end
  end

  context 'with invalid credentials' do
    let(:client){mio_client}
    it_behaves_like 'simple_client'
  end

  context 'with an invalid @base_uri' do
    let(:client){mio_client}
    it_behaves_like 'simple_client'
  end
end
