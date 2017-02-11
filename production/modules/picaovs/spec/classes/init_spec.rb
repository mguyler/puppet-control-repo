require 'spec_helper'
describe 'picaovs' do

  context 'with defaults for all parameters' do
    it { should contain_class('picaovs') }
  end
end
