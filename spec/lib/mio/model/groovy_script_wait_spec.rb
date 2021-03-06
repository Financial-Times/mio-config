require 'spec_helper'

describe 'Mio::Model::GroovyScriptWait' do
  subject{ Mio::Model::GroovyScriptWait }
  let(:model_args){build(:groovy_script_wait)}
  let(:invalid_model_args){build(:groovy_script_wait_invalid_data)}
  let(:extra_model_args){build(:groovy_script_wait_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'
  it_behaves_like 'non_nested_model'

end
