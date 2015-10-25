#
# Cookbook Name:: my-elk-stack-cookbook
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package 'java-1.8.0-openjdk-devel'
package 'curl'
package 'logrotate'

user node['elk']['user'] do
  comment 'Running Elastic Search, Logstash and Kibana'
  home "/home/#{node['elk']['user']}"
  shell '/bin/bash'
end

directory node['elk']['user'] do
  owner node['elk']['user'] 
  group node['elk']['user'] 
  mode '0755'
  action :create
end

################################################################################
# Logstash installation

ls_rpm_temp_loc = '/tmp/logstash.rpm' 

remote_file ls_rpm_temp_loc do
  source "https://download.elastic.co/logstash/logstash/packages/centos/logstash-#{node['elk']['logstash']['version']}-1.noarch.rpm"
  checksum node['elk']['logstash']['checksum'] 
  owner node['elk']['user'] 
  group node['elk']['user'] 
  mode '0755'
  action :create
end

rpm_package 'logstash' do
  source ls_rpm_temp_loc
end

################################################################################
# Elastic Search installation

es_rpm_temp_loc = '/tmp/elasticsearch.rpm'

remote_file es_rpm_temp_loc do
  source "https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-#{node['elk']['elasticsearch']['version']}.noarch.rpm"
  checksum node['elk']['elasticsearch']['checksum'] 
  owner node['elk']['user'] 
  group node['elk']['user'] 
  mode '0755'
  action :create
end

rpm_package 'elasticsearch' do
  source es_rpm_temp_loc
end

service 'elasticsearch' do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

