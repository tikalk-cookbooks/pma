#
# Cookbook Name:: pma
# Recipe:: apache2
#
# Copyright 2013, Tikal Knowledge
#
# Apache 2.0 Liscense.
#

attrs = node[:pma]
include_recipe "apache2"

template 	"#{node[:apache][:dir]}/sites-available/pma" do
  source 	'pma.conf.erb'
  owner 	'root'
  group 	'root'
  mode 		'0600'
  action 	:create
end

# link "#{node[:apache][:dir]}/sites-available/pma" do
#     action :create
#     to "#{attrs[:apache2][:site_config]}"
# end

# replace_or_add "Allow ip ranges to access pma" do
#   path "#{node[:apache][:dir]}/sites-available/pma"
#   pattern "Allow from 127.0.0.1.*"
#   line "Allow from 127.0.0.1 192.168.5"
# end

apache_site "pma"

service "apache2" do
  action :restart 
end