require 'spec_helper'

describe Mio::Config do

 let (:mio_config) {Mio::Config.new}
   context 'when instantiating' do
     it 'should create an instance of Mio::Config' do
        expect(mio_config).to be_instance_of(Mio::Config)     
     end
   end    
end 
