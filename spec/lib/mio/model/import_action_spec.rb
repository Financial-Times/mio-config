require 'spec_helper'

describe 'Mio::Model::ImportAction' do
  subject{ Mio::Model::ImportAction }
  let(:model_args){build(:import_action)}
  let(:invalid_model_args){build(:import_action_invalid_data)}
  let(:extra_model_args){build(:import_action_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'

end
