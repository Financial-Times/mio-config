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

  context 'when instantiated with multiple options with the same name' do
    let(:client){build(:valid_client)}
    let(:definition){subject.new(client, build(:definition_multiple_same_name_options))}

    it 'should raise a Mio::Model::DateVariableInvalid error' do
      expect{definition.validate}.to raise_error(Mio::Model::DataValueError)
    end
  end

  context 'when boolean definition instantiated with bad name' do
    let(:client){build(:valid_client)}
    let(:definition){subject.new(client, build(:boolean_bad_name))}

    it 'should raise a Mio::Model::DateVariableInvalid error' do
      expect{definition.validate}.to raise_error(Mio::Model::DataValueError)
    end
  end

  context 'when boolean definition instantiated with name and value miss match' do
    let(:client){build(:valid_client)}
    let(:definition){subject.new(client, build(:boolean_name_value_dont_match))}

    it 'should raise a Mio::Model::DateVariableInvalid error' do
      expect{definition.validate}.to raise_error(Mio::Model::DataValueError)
    end
  end

  context 'when boolean definition instantiated with value not boolean' do
    let(:client){build(:valid_client)}
    let(:definition){subject.new(client, build(:boolean_value_not_boolean))}

    it 'should raise a Mio::Model::DateVariableInvalid error' do
      expect{definition.validate}.to raise_error(Mio::Model::DataValueError)
    end
  end

  context 'when boolean name false value true' do
    let(:client){build(:valid_client)}
    let(:definition){subject.new(client, build(:boolean_name_false_value_not_false))}

    it 'should raise a Mio::Model::DateVariableInvalid error' do
      expect{definition.validate}.to raise_error(Mio::Model::DataValueError)
    end
  end


  context 'when boolean has single option' do
    let(:client){build(:valid_client)}
    let(:definition){subject.new(client, build(:boolean_single_option))}

    it 'should raise a Mio::Model::DateVariableInvalid error' do
      expect{definition.validate}.to raise_error(Mio::Model::DataValueError)
    end
  end

end

describe 'Mio::Model::MetadataDefinition::Definition' do
  subject{ Mio::Model::MetadataDefinition::Definition }
  let(:model_args){build(:complex_definition)}
  let(:invalid_model_args){build(:complex_definition_invalid_data)}
  let(:extra_model_args){build(:complex_definition_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'

end