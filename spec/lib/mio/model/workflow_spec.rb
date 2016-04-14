require 'spec_helper'

describe 'Mio::Model::Workflow' do
  subject{ Mio::Model::Workflow }
  let(:model_args){build(:workflow)}
  let(:invalid_model_args){build(:workflow_invalid_data)}
  let(:extra_model_args){build(:workflow_extra_data)}

  let(:empty_nodes){build(:workflow_empty_nodes)}
  let(:empty_transitions){build(:workflow_empty_transitions)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

  context 'when instantiated with invalid options' do
    %w{node transition}.each do |field|
      let(:workflow){subject.new(client, build( "workflow_empty_#{field}s".to_sym ))}

      context "when given an empty list of #{field}" do
        it 'should raise a Mio::Model::EmptyField error' do
          expect{workflow.go}.to raise_error(Mio::Model::EmptyField)
        end
      end
    end
  end

  context 'when instantiated with valid options' do
    let(:workflow){subject.new(client, model_args)}
    [:structure_hash, :transition_lookup, :set_node_layouts].each do |m|
      it "should respond to ##{m.to_s}" do
        expect(workflow).to respond_to(m)
      end
    end
  end

end
