require 'spec_helper'

describe 'Mio::Model::MetadataDefinition' do
  subject{ Mio::Model::MetadataDefinition }
  let(:model_args){build(:metadata_definition)}
  let(:invalid_model_args){build(:metadata_definition_invalid_data)}
  let(:extra_model_args){build(:metadata_definition_extra_data)}

  let(:empty_definitions){build(:metadata_definition_empty_definitions)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

  context 'when instantiated with invalid options' do
    %w{definition}.each do |field|
      let(:metadata_definition){subject.new(client, build( "metadata_definition_empty_#{field}s".to_sym ))}

      context "when given an empty list of #{field}" do
        it 'should raise a Mio::Model::EmptyField error' do
          expect{metadata_definition.go}.to raise_error(Mio::Model::EmptyField)
        end
      end
    end
  end

  context 'when instantiated with valid options' do
    let(:metadata_definition){subject.new(client, model_args)}
    [:definition_xml, :trim_xml_from_element].each do |m|
      it "should respond to ##{m.to_s}" do
        expect(metadata_definition).to respond_to(m)
      end
    end
  end

end
