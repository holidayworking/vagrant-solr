#
# Cookbook Name:: vagrant-solr
# Recipe:: default
#
# Copyright (C) 2013 Hidekazu Tanaka
#
# All rights reserved - Do Not Redistribute
#

execute "apt-get-update" do
  command "apt-get update"
  ignore_failure true
  not_if { File.exists?('/var/lib/apt/periodic/update-success-stamp') }
end

package "update-notifier-common" do
  notifies :run, 'execute[apt-get-update]', :immediately
end

execute "apt-get-update-periodic" do
  command "apt-get update"
  ignore_failure true
  only_if do
    File.exists?('/var/lib/apt/periodic/update-success-stamp') &&
    File.mtime('/var/lib/apt/periodic/update-success-stamp') < Time.now - 86400
  end
end