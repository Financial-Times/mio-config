require 'spec_helper'

describe 'Mio::Search' do
  let(:client){build :valid_client}
  let(:searcher){Mio::Search.new(client)}

  context 'when instantiated' do
    it 'initialises correctly' do
      expect(searcher).not_to be_nil
    end
  end

  context 'delegating to #method_missing' do
    it 'dynamically responds to #find_something_by_field' do
      expect(searcher).to respond_to(:find_something_by_field)
    end

    it 'searches for resources by key correctly' do
      expect(searcher.find_resources_by_name('some shit')).to be_a(Array)
    end

    context 'when regular expressions misses' do
      it 'returns true correctly for registered methods' do
        expect(searcher).to respond_to(:all)
      end

      it 'returns false for unregistered methods' do
        expect(searcher).not_to respond_to(:i_am_a_fake_method)
      end

      it 'throws an error when calling an unregistered method' do
        expect{ searcher.i_am_a_fake_method }.to raise_error(NoMethodError)
      end
    end

  end
end
