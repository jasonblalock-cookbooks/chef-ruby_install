# -*- encoding : utf-8 -*-
#
# Cookbook Name:: ruby_install
# Recipe:: default
#
# Author:: Ross Timson <ross@rosstimson.com>
#
# Copyright 2013, Ross Timson
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Relying on ruby-install to grab build dependencies for Rubies but it will
# fail unless package index files are not up to date.
case node['platform_family']
when 'debian'
  include_recipe 'apt'
  packages = []

  case node[:lsb][:codename]
  when "lucid"
      packages |= %w{ libssl0.9.8 }
  when "precise"
      packages |= %w{ libssl1.0.0 libssl1.0.0-dbg }
  else
    packages = %w{ libssl1.0.0 libssl1.0.0-dbg }
  end
  packages.each do |pkg|
      package pkg do
        action :upgrade
      end
  end
when 'rhel'
  include_recipe 'yum'
end

file_name = "ruby-install-#{node['ruby_install']['checksum']}"
dir_path = "#{Chef::Config['file_cache_path']}/ruby-install"
file_path = "#{dir_path}/#{file_name}.tar.gz"

#directory "#{dir_path}/#{file_name}" do
#  recursive true
#  action :create
#end

remote_file file_path do
  source node['ruby_install']['url']
  checksum node['ruby_install']['checksum']
  owner 'root'
  group 'root'
  mode '0755'
end

execute 'Install ruby-install' do
  cwd "#{dir_path}/#{file_name}"
  command %{make uninstall && make clean && make install}
  action :nothing
end

bash 'extract_tarball' do
  cwd dir_path
  code <<-EOH
    mkdir -p #{dir_path}/#{file_name}
    tar xzvf #{file_name}.tar.gz -C #{dir_path}/#{file_name} --strip-components=1
    EOH
  not_if { ::File.exist?("#{dir_path}/#{file_name}") }
  notifies :run, resources(execute: 'Install ruby-install'), :immediately
end

# Make sure ruby-install has correct ownership, Debian doesn't seem to use
# group 'root' when it is installed unlike all the others including Ubuntu.
file '/usr/local/bin/ruby-install' do
  owner 'root'
  group 'root'
end
