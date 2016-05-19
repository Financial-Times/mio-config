require 'spec_helper'

describe 'Mio::Model::Variant' do
  subject{ Mio::Model::Variant }
  let(:model_args){build(:variant)}
  let(:invalid_model_args){build(:variant_invalid_data)}
  let(:extra_model_args){build(:variant_extra_data)}

  let(:empty_metadata_definitions){build(:variant_empty_metadata_definitions)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

  context 'when instantiated with invalid options' do
    %w{metadataDefinition}.each do |field|
      let(:variant){subject.new(client, build( "variant_empty_#{field}s".to_sym ))}

      context "when given an empty list of #{field}" do
        it 'should raise a Mio::Model::EmptyField error' do
          expect{variant.go}.to raise_error(Mio::Model::EmptyField)
        end
      end
    end
  end

  context 'when instantiated with valid options' do
    let(:variant){subject.new(client, model_args)}
    [:object_type_id, :metadata_definition_hash, :metadata_definition_id, :metadata_definition_ids].each do |m|
      it "should respond to ##{m.to_s}" do
        expect(variant).to respond_to(m)
      end
    end
  end

end
