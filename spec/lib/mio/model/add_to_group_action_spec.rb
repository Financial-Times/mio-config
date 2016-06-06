require 'spec_helper'

describe 'Mio::Model::AddToGroupAction' do
  subject{ Mio::Model::AddToGroupAction }
  let(:model_args){build(:add_to_group_action_empty_config)}
  let(:invalid_model_args){build(:add_to_group_action_empty_config_invalid_data)}
  let(:extra_model_args){build(:add_to_group_action_empty_config_extra_data)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

end

describe 'Mio::Model::AddToGroupAction' do
  subject{ Mio::Model::AddToGroupAction }
  let(:model_args){build(:add_to_group_action_targetAssetId)}
  let(:invalid_model_args){build(:add_to_group_action_empty_config_invalid_data)}
  let(:extra_model_args){build(:add_to_group_action_empty_config_extra_data)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

end

describe 'Mio::Model::AddToGroupAction' do
  subject{ Mio::Model::AddToGroupAction }
  let(:model_args){build(:add_to_group_action_groupName)}
  let(:invalid_model_args){build(:add_to_group_action_empty_config_invalid_data)}
  let(:extra_model_args){build(:add_to_group_action_empty_config_extra_data)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

end

describe 'Mio::Model::AddToGroupAction' do
  subject{ Mio::Model::AddToGroupAction }
  let(:model_args){build(:add_to_group_action_referenceNamePrefix)}
  let(:invalid_model_args){build(:add_to_group_action_empty_config_invalid_data)}
  let(:extra_model_args){build(:add_to_group_action_empty_config_extra_data)}

  let(:client){build(:valid_client)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

end