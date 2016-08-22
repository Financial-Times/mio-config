require 'spec_helper'

describe 'Mio::Model::MessageTemplate' do
  subject{ Mio::Model::MessageTemplate }
  let(:model_args){build(:message_template)}
  let(:invalid_model_args){build(:message_template_invalid_data)}
  let(:extra_model_args){build(:message_template_extra_data)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

end