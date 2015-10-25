require 'spec_helper'

describe 'my-elk-stack-cookbook::default' do
  # Serverspec examples can be found at
  # http://serverspec.org/resource_types.html
  it 'does something' do
    skip 'Replace this with meaningful tests'
  end
end

describe user('root') do
  it { should exist }
end

describe user('elkuser') do
  it { should exist }
  it { should have_home_directory '/home/elkuser' }
end


