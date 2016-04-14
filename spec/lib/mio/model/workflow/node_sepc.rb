require 'spec_helper'

describe 'Mio::Model::Workflow::Node' do
  subject{ Mio::Model::Workflow::Node }
  let(:model_args){build(:node)}
  let(:invalid_model_args){build(:node_invalid_data)}
  let(:extra_model_args){build(:node_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'

end
