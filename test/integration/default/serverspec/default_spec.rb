require 'spec_helper'

#describe 'my-elk-stack-cookbook::default' do
#  # Serverspec examples can be found at
#  # http://serverspec.org/resource_types.html
#  it 'does something' do
#    skip 'Replace this with meaningful tests'
#  end
#end

describe user('root') do
  it { should exist }
end

app_user_name = "elkuser"
describe user(app_user_name) do
  it { should exist }
  it { should have_home_directory "/home/#{app_user_name}" }
  it { should have_login_shell '/bin/bash' }
end



