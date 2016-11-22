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


  context 'when instantiated with valid options' do
    let(:variant){subject.new(client, model_args)}
    [:metadata_definition_hash, :metadata_definition_id, :metadata_definition_ids].each do |m|
      it "should respond to ##{m.to_s}" do
        expect(variant).to respond_to(m)
      end
    end
  end

  context 'when instantiated with unknown object type' do
    let(:client){build(:valid_client)}
    let(:variant){subject.new(client, build(:variant_unknown_object_type))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect{variant.create_hash}.to raise_error(Mio::Model::NoSuchResource)
    end
  end

  context 'when instantiated with unknown metadata definition' do
    let(:client){build(:valid_client)}
    let(:variant){subject.new(client, build(:variant_unknown_metadata_definition))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect{variant.create_hash}.to raise_error(Mio::Model::NoSuchResource)
    end
  end

end
