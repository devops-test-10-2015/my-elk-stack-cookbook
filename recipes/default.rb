#
# Cookbook Name:: my-elk-stack-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

user node[:elk][:user] do
  comment 'Running Elastic Search, Logstash and Kibana'
  home "/home/#{node[:elk][:user]}"
  shell '/bin/bash'
end
