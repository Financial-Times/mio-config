require 'spec_helper'

describe 'Mio::Model::MetadataDefinition::Option' do
  subject{ Mio::Model::MetadataDefinition::Option }
  let(:model_args){build(:option)}
  let(:invalid_model_args){build(:option_invalid_data)}
  let(:extra_model_args){build(:option_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'

  let(:client){build(:valid_client)}
  let(:option_object){subject.new(client, model_args)}

  it 'responds to #build_xml' do
    expect(option_object).to respond_to(:build_xml)
  end

end