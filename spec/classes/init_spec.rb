require 'spec_helper'
describe 'sslcert' do
  context 'with default values for all parameters' do
    it { should contain_class('sslcert') }
  end
end
