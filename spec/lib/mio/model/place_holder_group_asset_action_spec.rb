require 'spec_helper'

describe 'Mio::Model::PlaceHolderGroupAssetAction' do
  subject{ Mio::Model::PlaceHolderGroupAssetAction }
  let(:model_args){build(:place_holder_group_asset_action)}
  let(:invalid_model_args){build(:place_holder_group_asset_action_invalid_data)}
  let(:extra_model_args){build(:place_holder_group_asset_action_extra_data)}


  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'


  context 'when instantiated with valid options' do
    let(:create_place_holder_group_asset_action){subject.new(client, model_args)}
    [:metadata_definition_id].each do |m|
      it "should respond to ##{m.to_s}" do
        expect(create_place_holder_group_asset_action).to respond_to(m)
      end
    end
  end

end
