require 'spec_helper'

#######################################################################
# standard values
#
app_user_name = "elkuser"
elasticsearch_default_port = 9200

#######################################################################
# tests
#

# required users ######################################################
describe user('root') do
  it { should exist }
end

describe user(app_user_name) do
  it { should exist }
  it { should have_home_directory "/home/#{app_user_name}" }
  it { should have_login_shell '/bin/bash' }
end

# required packages ######################################################
describe package('java-1.8.0-openjdk-devel') do
  it { should be_installed }
end

# Required for testing a bit later in the spec
describe package('curl') do
  it { should be_installed }
end

# logstash test ######################################################
describe command('/opt/logstash/bin/logstash --version') do
  its(:stdout) { should match /logstash 1.5.4/ }
end

# elasticsearch tests ######################################################
describe service('elasticsearch'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe port(elasticsearch_default_port) do
  it { should be_listening }
end

# This test will look something like this (but a fresh install should have a green status)
#epoch      timestamp cluster       status node.total node.data shards pri relo init unassign pending_tasks 
#1445777835 12:57:15  elasticsearch yellow          1         1     15  15    0    0       15             0 
describe command("curl 'localhost:#{elasticsearch_default_port}/_cat/health?v'") do
  its(:stdout) { should match /green/ }
end

# get the elasticsearch version from the api ############################################
# the call returns something like this:
#{
#  "status" : 200,
#  "name" : "Kleinstocks",
#  "cluster_name" : "elasticsearch",
#  "version" : {
#    "number" : "1.7.3",
#    "build_hash" : "05d4530971ef0ea46d0f4fa6ee64dbc8df659682",
#    "build_timestamp" : "2015-10-15T09:14:17Z",
#    "build_snapshot" : false,
#    "lucene_version" : "4.10.4"
#  },
#  "tagline" : "You Know, for Search"
#}
describe command("curl 'localhost:#{elasticsearch_default_port}'") do
  its(:stdout) { should match /"number" : "1.7.3"/ }
end

