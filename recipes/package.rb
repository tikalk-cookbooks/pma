#
# Cookbook Name:: pma
# Recipe:: package
#
# Copyright 2013, Tikal Knowledge
#
# Apache 2.0 Liscense.
#

# install via yum / apt-get ...
package "phpmyadmin"

template "#{attrs[:conf][:path]}/config.inc.php" do
  source "config.inc.php.erb"
  owner "root"
  group "root"
  mode 0644
end