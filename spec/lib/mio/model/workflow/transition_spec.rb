require 'spec_helper'

describe 'Mio::Model::Workflow::Transition' do
  subject{ Mio::Model::Workflow::Transition }
  let(:model_args){build(:transition)}
  let(:invalid_model_args){build(:transition_invalid_data)}
  let(:extra_model_args){build(:transition_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'nested_model'

end
