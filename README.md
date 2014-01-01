PMA Cookbook
=============
Installs [phpmyadmin](http://www.phpmyadmin.net/home_page/index.php) - a.k.a pma

Requirements
------------
* php - well you can't run phpmyadmin without php ...
* apache2 - implemented and is the default web server 
* nginx 	- not implemented yet
*	mysql 	- included and id not installed you must specify the root user password (see below in usage)
*	yum + yum-epel(now seperate from yum cookbook)	- needed for dependency packadges not in 
*	iptables - disble / enable iptabales - default to enable !
*	apt - for ubuntu installation
*	ark - used in tarball installation in order to extract

Attributes [well the importnat ones ...]
----------
* `[:pma][:install_method]`  defaults to `tarball` - it is usually the most recent version and rpm/deb are far behind
* `[:pma][:version] 				 defaults to `4.1.3` (released `31.12.2013`) - 
														 4.1.2/4.1.1 are also included if you override this attribute
* `[:pma][:webserver]` 			 defaults to `apache2`   - creates alias /pma ...
* `[:pma][:iptables]`        defaults to `enable`	- opens port 22 && 80
* `[:pma][:allowed_addrs]`	 defaults to `10.10.10` - see pma.conf.erb it basically allows ip ranges to access pma.
* `[:pma]:conf][:allow_root] defaults to `flase` which means you will not be ableto login to pma with your root & passowrd - this is a security mesurment, usually I set this to true on development systems (which is usually the use case - I wouldn't have this in production !)

___plese consult attributes/default.rb for the full attribute list___

Notice
------
This cookbook will install mysql::server if/when you provide 'server_root_password' in you node attributes, if it dosen't it will fail ! => phpmyadmin will not be able to configure itself without the root password !

Unless you specify as a node attribute:
`'iptables_skip' => true` and or `'webserver_skip' => true` => apache & iptables will be installed ! => so you have a way out if needed :)


Usage
-----
#### pma::default

include `pma` in your node's `run_list`:

	{
	  "name":"my_node",
	  "run_list": [
	    "recipe[pma]"
	  ],

	  default_attributes(
	  'mysql' => {
	  	'server_root_password' => 'mymysqlrootpassword',
	  	'server_repl_password' => 'mymysqlrootpassword',
	  	'server_debian_password' => 'mymysqlrootpassword'
		},
	  'pma' => {
	  	'conf' => { 'allow_root' => true,
	  							'iptables_skip' => false,
	  							'webserver_skip' => false
	  		}
		}
	)
	}


Contributing
------------

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Haggai Philip Zagury <hagzag@tikalk.com>
License: Apache 2.0
