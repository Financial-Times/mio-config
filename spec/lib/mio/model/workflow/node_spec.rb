require 'spec_helper'

describe 'Mio::Model::Workflow::Node' do
  subject{ Mio::Model::Workflow::Node }
  let(:model_args){build(:node)}
  let(:invalid_model_args){build(:node_invalid_data)}
  let(:extra_model_args){build(:node_extra_data)}
  let(:action_model_args){build(:action_node)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'

  let(:client){build(:valid_client)}
  let(:node_object){subject.new(client, model_args)}

  it 'responds to #normalize_action' do
    expect(node_object).to respond_to(:normalize_action)
  end

  context 'when adding a node without an action' do
    let(:node_object){subject.new(client,build(:action_node))}
    let(:node_hash){node_object.create_hash}

    it 'creates a hash with an ACTION object' do
      expect(node_hash).to include(:action)
    end

    [:id, :name, :pluginClass].each do |k|
      it "creates an ACTION object with key #{k.to_s}" do
        expect(node_hash[:action]).to include(k)
      end
    end
  end

end
