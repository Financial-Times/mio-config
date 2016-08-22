require 'spec_helper'

describe 'Mio::Model::LaunchWorkflowAction::LaunchWorkflow' do
  subject{ Mio::Model::LaunchWorkflowAction::LaunchWorkflow }
  let(:model_args){build(:launchworkflow)}
  let(:invalid_model_args){build(:launchworkflow_invalid_data)}
  let(:extra_model_args){build(:launchworkflow_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'

  context 'when instantiated with unknown metadata definition' do
    let(:client){build(:valid_client)}
    let(:launchworkflow){subject.new(client, build(:launchworkflow_unknown_metadata_definition))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect{launchworkflow.create_hash}.to raise_error(Mio::Model::NoSuchResource)
    end
  end


end