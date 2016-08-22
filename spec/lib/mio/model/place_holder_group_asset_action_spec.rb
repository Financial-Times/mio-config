require 'spec_helper'

describe 'Mio::Model::PlaceHolderGroupAssetAction' do
  subject{ Mio::Model::PlaceHolderGroupAssetAction }
  let(:model_args){build(:place_holder_group_asset_action)}
  let(:invalid_model_args){build(:place_holder_group_asset_action_invalid_data)}
  let(:extra_model_args){build(:place_holder_group_asset_action_extra_data)}


  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

  context 'when instantiated with unknown metadata definition' do
    let(:client){build(:valid_client)}
    let(:place_holder_group_asset_action){subject.new(client, build(:place_holder_group_asset_action_unknown_metadata_definition))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect{place_holder_group_asset_action.config_hash}.to raise_error(Mio::Model::NoSuchResource)
    end
  end



end
