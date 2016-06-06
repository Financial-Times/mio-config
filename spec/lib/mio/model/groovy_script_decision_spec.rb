require 'spec_helper'

describe 'Mio::Model::GroovyScriptDecision' do
  subject{ Mio::Model::GroovyScriptDecision}
  let(:model_args){build(:groovy_script_decision)}
  let(:invalid_model_args){build(:groovy_script_decision_invalid_data)}
  let(:extra_model_args){build(:groovy_script_decision_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'
  it_behaves_like 'non_nested_model'

end
