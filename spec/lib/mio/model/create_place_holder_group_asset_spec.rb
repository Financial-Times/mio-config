require 'spec_helper'

describe 'Mio::Model::CreatePlaceHolderGroupAsset' do
  subject{ Mio::Model::CreatePlaceHolderGroupAsset }
  let(:model_args){build(:create_place_holder_group_asset)}
  let(:invalid_model_args){build(:create_place_holder_group_asset_invalid_data)}
  let(:extra_model_args){build(:create_place_holder_group_asset_extra_data)}


  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'


  context 'when instantiated with valid options' do
    let(:create_place_holder_group_asset){subject.new(client, model_args)}
    [:metadata_definition_id].each do |m|
      it "should respond to ##{m.to_s}" do
        expect(create_place_holder_group_asset).to respond_to(m)
      end
    end
  end

end
