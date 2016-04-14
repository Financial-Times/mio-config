shared_examples 'generic_model' do
  context 'when interrogating the class object' do
    [:set_resource, :field, :mappings, :fields, :fields=, :resource_name, :resource_name=].each do |m|
      it "responds to public method ##{m.to_s}" do
        expect(subject).to respond_to(m)
      end
    end

    it 'correctly loads self into mappings' do
      expect(subject.mappings.values).to include(subject)
    end
  end

  context 'when creating an object' do
    let(:client){build :valid_client}
    let(:valid_model){subject.new(client, model_args)}

    it 'instantiates' do
      expect(valid_model).not_to be_nil
    end

    [:create_hash].each do |m|
      it "provides a hash from ##{m}" do
        expect(valid_model.method(m).call).to be_an(Hash)
      end
    end

    context 'when validating configuration' do
      let(:empty_model){subject.new(client, {})}
      let(:bad_data){subject.new(client, invalid_model_args)}
      let(:extra_data){subject.new(client, extra_model_args)}

      it 'returns true for #valid? for valid configuration' do
        expect(valid_model.valid?).to be true
      end

      it 'throws Mio::Model::MissingField when configuration misses a required field' do
        expect{empty_model.valid?}.to raise_error(Mio::Model::MissingField)
      end

      it 'throws Mio::Model::DataTypeError when configuration contains a bad data type' do
        expect{bad_data.valid?}.to raise_error(Mio::Model::DataTypeError)
      end

      it 'throws Mio::Model::NoSuchField when configuration contains unexpected data' do
        expect{extra_data.valid?}.to raise_error(Mio::Model::NoSuchField)
      end

    end
  end
end

shared_examples 'model_with_config_hash' do
  let(:client){build :valid_client}
  let(:valid_model){subject.new(client, model_args)}

  [:config_hash].each do |m|
    it "provides a hash from ##{m}" do
      expect(valid_model.method(m).call).to be_an(Hash)
    end
  end
end

shared_examples 'nested_model' do
  let(:client){build :valid_client}
  let(:valid_model){subject.new(client, model_args)}

  it "returns true for #nested?" do
    expect(subject.nested?).to be(true)
  end
end

shared_examples 'non_nested_model' do
  let(:client){build :valid_client}
  let(:valid_model){subject.new(client, model_args)}

  it "returns false for #nested?" do
    expect(subject.nested?).to be(false)
  end

  context 'when creating a mio resource' do
    it 'Goes through the complete flow with #go' do
      expect(valid_model.go).to be_a(Hash)
    end
  end

end
