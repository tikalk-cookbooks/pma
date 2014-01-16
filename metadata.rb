name             'pma'
maintainer       'Lightapp Technologies, LTD'
maintainer_email 'hagzag@lightapp.com'
license          'Apache 2.0'
description      'Installs/Configures base'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

%w{ php apache2 mysql yum apt line ark yum-epel iptables }.each do |cb|
  depends cb
end

# ubuntu debian => should support haven't tested yet :)
%w{ centos redhat amazon scientific oracle fedora }.each do |os|
  supports os
end
