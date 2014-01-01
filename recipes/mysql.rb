#
# Cookbook Name:: pma
# Recipe:: mysql
#
# Copyright 2013, Tikal Knowledge
#
# Apache 2.0 Liscense.
#

include_recipe "mysql::server"

sql_file = "#{Chef::Config[:file_cache_path]}/create_pma_tables.sql"

# use template file ... for create db
template sql_file do
  source "create_pma_tables.sql.erb"
  owner "root"
  group node['mysql']['root_group']
  mode "0600"
  action :create
end

# run mysql cli to create tables
execute "phpmyadmin-create-tables" do
  command "\"#{node['mysql']['server']['mysql_bin']}\" -u root #{node['mysql']['server_root_password'].empty? ? '' : '-p' }\"#{node['mysql']['server_root_password']}\" < \"#{sql_file}\""
end

# remove temp file (if exists)
file sql_file do
  action :delete
  only_if { File.exists?(sql_file) }
end