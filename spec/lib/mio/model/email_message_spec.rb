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


  context 'when instantiated with unknown message template' do
    let(:client){build(:valid_client)}
    let(:email_message_action){subject.new(client, build(:email_message_action_unknown_message_template))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect{email_message_action.get_message_template_id(email_message_action.args.template)}.to raise_error(Mio::Model::NoSuchResource)
    end
  end
end
