require 'spec_helper'

describe 'Mio::Model::Extract' do
  subject{ Mio::Model::Extract }
  let(:model_args){build(:extract)}
  let(:invalid_model_args){build(:extract_invalid_data)}
  let(:extra_model_args){build(:extract_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'
  it_behaves_like 'non_nested_model'

end
