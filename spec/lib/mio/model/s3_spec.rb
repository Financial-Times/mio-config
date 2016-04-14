require 'spec_helper'

describe 'Mio::Model::S3' do
  subject{ Mio::Model::S3 }
  let(:model_args){build(:s3)}
  let(:invalid_model_args){build(:s3_invalid_data)}
  let(:extra_model_args){build(:s3_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'

end
