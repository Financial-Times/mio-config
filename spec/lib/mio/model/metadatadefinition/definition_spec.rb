require 'spec_helper'

describe 'Mio::Model::MetadataDefinition::Definition' do
  subject{ Mio::Model::MetadataDefinition::Definition }
  let(:model_args){build(:text_metadata_definition)}
  let(:invalid_model_args){build(:text_metadata_definition_invalid_data)}
  let(:extra_model_args){build(:text_metadata_definition_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'

  let(:client){build(:valid_client)}
  let(:text_metadata_definition_object){subject.new(client, model_args)}

  it 'responds to #build_xml' do
    expect(text_metadata_definition_object).to respond_to(:build_xml)
  end

  it 'responds to #validation_handler_by_type' do
    expect(text_metadata_definition_object).to respond_to(:validation_handler_by_type)
  end

end