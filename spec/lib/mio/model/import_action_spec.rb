require 'spec_helper'

describe 'Mio::Model::ImportAction' do
  subject{ Mio::Model::ImportAction }
  let(:model_args){build(:import_action)}
  let(:invalid_model_args){build(:import_action_invalid_data)}
  let(:extra_model_args){build(:import_action_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'
  it_behaves_like 'non_nested_model'

  context 'when instantiated' do
    let(:client){build(:valid_client)}
    let(:import_action){subject.new(client, build(:import_action_unknown_metadata_definition))}

    context "with unknown metadataDefinition" do
      it 'should raise a Mio::Model::NoSuchResource error' do
        expect{import_action.metadata_definition_id(import_action.args.metadataDefinition)}.to raise_error(Mio::Model::NoSuchResource)
      end
    end
  end

end
