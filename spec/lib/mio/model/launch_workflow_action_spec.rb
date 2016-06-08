require 'spec_helper'

describe 'Mio::Model::LaunchWorkflowAction' do
  subject{ Mio::Model::LaunchWorkflowAction }
  let(:model_args){build(:launch_workflow_action)}
  let(:invalid_model_args){build(:launch_workflow_action_invalid_data)}
  let(:extra_model_args){build(:launch_workflow_action_extra_data)}

  let(:empty_workflows){build(:launch_workflow_action_empty_workflows)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

  context 'when instantiated with invalid options' do
    let(:launch_workflow_action){subject.new(client, build( :launch_workflow_action_empty_workflows ))}

    context "when given an empty list of launch workflows" do
      it 'should raise a Mio::Model::EmptyField error' do
        expect{launch_workflow_action.validate}.to raise_error(Mio::Model::EmptyField)
      end
    end
  end

end
