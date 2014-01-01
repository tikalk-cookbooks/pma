
default[:pma][:install_method] = 'tarball'
default[:pma][:webserver] = 'apache2'
default[:pma][:iptables] = 'enable' # or disable to disable iptables

default[:pma][:mirror] = 'http://sourceforge.net/projects/phpmyadmin/files/phpMyAdmin'
default[:pma][:version] = '4.1.3'
  
case node[:pma][:version]
when '4.1.1'
  default[:pma][:checksum] = '098ffaab0199f8bf88c98a42ca906af34b66b35820d2919f865e5b05d10602b2'
when '4.1.2'
  default[:pma][:checksum] = '878ac096e312284f79b676966594df0a39e707f06165d1143c1b8bfaef0d2504'
when '4.1.3'
	default[:pma][:checksum] = '6843953b09babd392a48f85e7afb5ac6826bd7e2fd1c8e0c15456f42060386dc'	
end

default[:pma][:full_url] = "#{node[:pma][:mirror]}/#{node[:pma][:version]}/phpMyAdmin-#{node[:pma][:version]}-all-languages.tar.gz"

case node[:platform_family]
when 'rhel'
  # package
  default[:pma][:conf][:cfg_path] =   '/etc/phpMyAdmin'
  default[:pma][:conf][:path] =   '/usr/share/phpMyAdmin'
  default[:pma][:apache2][:site_config] =   '/etc/httpd/conf.d/phpMyAdmin.conf'

  # tarball
  default[:pma][:upload_dir] = '/var/lib/php/uploads'
  default[:pma][:save_dir] = '/var/lib/php/uploads'

  # php modules
  default[:pma][:php_modules] = [ 'php-mbstring', 'php-mcrypt', 'php-gd', 'php-mysql',   ]
when 'debian'
  # package
  default[:pma][:conf][:cfg_path] = '/etc/phpmyadmin'
  default[:pma][:conf][:path] = '/usr/share/phpmyadmin'
  default[:pma][:apache2][:site_config] = '/etc/phpmyadmin/apache.conf'

  # tarball  
  default[:pma][:upload_dir] = '/var/lib/php5/uploads'
  default[:pma][:save_dir] = '/var/lib/php5/uploads'

  # php modules
  default[:pma][:php_modules] = [ 'php5-mcrypt', 'php5-gd', 'php5-mysqlnd']
end

default[:pma][:maxrows] = '100'
default[:pma][:protect_binary] = 'blob'
default[:pma][:default_lang] = 'en'
default[:pma][:default_display] = 'horizontal'
default[:pma][:query_history] = true
default[:pma][:query_history_size] = '100'

default[:pma][:conf][:auth_type] = 'cookie'
default[:pma][:conf][:allow_root] = false
default[:pma][:conf][:allow_no_password] = false

default[:pma][:conf][:control_database] = 'pma'
default[:pma][:conf][:control_user] = 'pma'
#default[:pma][:conf][:control_user_password] = '' not needed ... it will be set to an automatically generated password unless specified



default[:pma][:home] = node[:pma][:conf][:path]
default[:pma][:user] = 'root'
default[:pma][:group] = 'root'
default[:pma][:socket] = '/tmp/phpmyadmin.sock'

default[:pma][:allowed_addrs] = [ '192.168.5', '10.10.10' ]

