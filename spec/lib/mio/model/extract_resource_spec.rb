require 'spec_helper'

describe 'Mio::Model::ExtractResource' do
  subject{ Mio::Model::ExtractResource }
  let(:model_args){build(:extractresouce)}
  let(:invalid_model_args){build(:extractresouce_invalid_data)}
  let(:extra_model_args){build(:extractresouce_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

end