#
# Cookbook Name:: pma
# Recipe:: default
#
# Copyright 2013, Tikal Knowledge
#
# Apache 2.0 Liscense.
#

attrs = node[:pma]

case node[:platform_family]
when "debian"
  include_recipe "apt"
when "rhel"
  include_recipe "yum"
  include_recipe "yum-epel"
end

# is mysql installed ?
# instsall mysql serever + create the pma database 
include_recipe "pma::mysql" 

# install based on installatoin method - tarball will always be a newer version so ... up 2 you

include_recipe "pma::#{attrs[:install_method]}"

if attrs[:conf][:webserver_skip] == false
	Chef::Log.info ("webserver_skip is: #{node[:pma][:conf][:webserver_skip]} installing #{attrs[:webserver]}")
	# what web server to use - defaults to apache2 ...
	include_recipe "pma::#{attrs[:webserver]}"
end

if attrs[:conf][:iptables_skip] == false
	Chef::Log.info ("iptables_skip is: #{node[:pma][:conf][:iptables_skip]} configuring iptables")
	# enable / adjust / disable iptables ...
	include_recipe "pma::iptables_#{node[:pma][:iptables]}"
end
