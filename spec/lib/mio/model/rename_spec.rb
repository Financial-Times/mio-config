require 'spec_helper'

describe 'Mio::Model::Rename' do
  subject{ Mio::Model::Rename }
  let(:model_args){build(:rename)}
  let(:invalid_model_args){build(:rename_invalid_data)}
  let(:extra_model_args){build(:rename_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'

end
