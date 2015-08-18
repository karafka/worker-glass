require 'spec_helper'

# This file basically only requires stuff
RSpec.describe 'SidekiqGlass' do
  it 'should be defined' do
    expect(defined?(SidekiqGlass)).to eq 'constant'
  end
end
