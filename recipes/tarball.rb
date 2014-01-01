#
# Cookbook Name:: pma
# Recipe:: tarball
#
# Copyright 2013, Tikal Knowledge
#
# Apache 2.0 Liscense.
#

require 'digest/sha1'
attrs = node[:pma]

# PHP Recipe php modules
include_recipe 'php'

attrs[:php_modules].each do |pkg|
	package pkg do
	  action :install
	end
end

[ "#{attrs[:upload_dir]}", "#{attrs[:save_dir]}" ].each do |cd|
	directory cd do
		owner 'root'
		group 'root'
		mode 01777
		recursive true
		action :create
	end
end

ark "phpMyAdmin" do
  path "/usr/share"
  url attrs[:full_url]
  checksum attrs[:checksum]
  action :put
end

node.set[:pma][:conf][:blowfish_secret] = Digest::SHA1.hexdigest(IO.read('/dev/urandom', 2048))

Chef::Log.info ("allow root is: #{node[:pma][:conf][:allow_root]}")

template "#{attrs[:home]}/config.inc.php" do
  source 'config.inc.php.erb'
  owner user
  group group
  mode 00644
end