require 'spec_helper'

describe 'Mio::Model::WaitGroovyScript' do
  subject{ Mio::Model::WaitGroovyScript}
  let(:model_args){build(:wait_groovy_script)}
  let(:invalid_model_args){build(:wait_groovy_script_invalid_data)}
  let(:extra_model_args){build(:wait_groovy_script_extra_data)}

  it_behaves_like 'generic_model'
  it_behaves_like 'model_with_config_hash'
  it_behaves_like 'non_nested_model'

  context 'when instantiated with bad timeout' do
    let(:client){build(:valid_client)}
    let(:wait_groovy_script){subject.new(client, build(:wait_groovy_script_bad_timeout))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect{wait_groovy_script.validate}.to raise_error(Mio::Model::ObjectVariableInvalid)
    end
  end

  context 'when instantiated with bad polling period' do
    let(:client){build(:valid_client)}
    let(:wait_groovy_script){subject.new(client, build(:wait_groovy_script_bad_pollingTimePeriod))}

    it 'should raise a Mio::Model::NoSuchResource error' do
      expect{wait_groovy_script.validate}.to raise_error(Mio::Model::ObjectVariableInvalid)
    end
  end

end
