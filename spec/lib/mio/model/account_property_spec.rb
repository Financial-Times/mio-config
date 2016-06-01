require 'spec_helper'

describe 'Mio::Model::AccountProperty' do
  subject{ Mio::Model::AccountProperty }
  let(:model_args){build(:account_property)}
  let(:invalid_model_args){build(:account_property_invalid_data)}
  let(:extra_model_args){build(:account_property_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'non_nested_model'

end