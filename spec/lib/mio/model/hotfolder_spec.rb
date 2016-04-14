require 'spec_helper'

describe 'Mio::Model::Hotfolder' do
  subject{ Mio::Model::Hotfolder }
  let(:model_args){build(:hotfolder)}
  let(:invalid_model_args){build(:hotfolder_invalid_data)}
  let(:extra_model_args){build(:hotfolder_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'

end
