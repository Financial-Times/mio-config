require 'spec_helper'

describe 'Mio::Model::Workflow' do
  subject{ Mio::Model::Workflow }
  let(:model_args){build(:workflow)}
  let(:invalid_model_args){build(:workflow_invalid_data)}
  let(:extra_model_args){build(:workflow_extra_data)}

  it_behaves_like 'generic_model'

end
