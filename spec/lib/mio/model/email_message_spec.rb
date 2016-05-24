require 'spec_helper'

describe 'Mio::Model::EmailMessageAction' do
  subject{ Mio::Model::EmailMessageAction }
  let(:model_args){build(:email_message_action)}
  let(:invalid_model_args){build(:email_message_action_invalid_data)}
  let(:extra_model_args){build(:email_message_action_extra_data)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'
  it_behaves_like 'non_nested_model'

end
