#
# Cookbook Name:: my-elk-stack-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

user 'elkuser' do
  comment 'Running Elastic Search, Logstash and Kibana'
  home '/home/elkuser'
  shell '/bin/bash'
end
