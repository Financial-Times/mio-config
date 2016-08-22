require 'spec_helper'

describe 'Mio::Model::LaunchWorkflowAction::WorkflowVariable' do
  subject{ Mio::Model::LaunchWorkflowAction::WorkflowVariable }
  let(:model_args){build(:workflowvariable)}
  let(:invalid_model_args){build(:workflowvariable_invalid_data)}
  let(:extra_model_args){build(:workflowvariable_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'


  context 'when instantiated with object type' do
    let(:client){build(:valid_client)}
    let(:workflowvariable){subject.new(client, build(:workflowvariable_object_variable))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect(workflowvariable.validate).to be(true)
    end
  end


  context 'when instantiated with date type' do
    let(:client){build(:valid_client)}
    let(:workflowvariable){subject.new(client, build(:workflowvariable_date_variable))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect(workflowvariable.validate).to be(true)
    end
  end

  context 'when instantiated with object type which is not a number' do
    let(:client){build(:valid_client)}
    let(:workflowvariable){subject.new(client, build(:workflowvariable_not_number_object_variable))}

    it 'should raise a Mio::Model::ObjectVariableInvalid error' do
      expect{workflowvariable.validate}.to raise_error(Mio::Model::ObjectVariableInvalid)
    end
  end

  context 'when instantiated with object type which is not a number' do
    let(:client){build(:valid_client)}
    let(:workflowvariable){subject.new(client, build(:workflowvariable_not_known_object_variable))}

    it 'should raise a Mio::Model::ObjectVariableInvalid error' do
      expect{workflowvariable.validate}.to raise_error(Mio::Model::NoSuchResource)
    end
  end

  Mio::Model::DateVariableInvalid

  context 'when instantiated with date type which is not a date' do
    let(:client){build(:valid_client)}
    let(:workflowvariable){subject.new(client, build(:workflowvariable_bad_date_variable))}

    it 'should raise a Mio::Model::DateVariableInvalid error' do
      expect{workflowvariable.validate}.to raise_error(Mio::Model::DateVariableInvalid)
    end
  end


end