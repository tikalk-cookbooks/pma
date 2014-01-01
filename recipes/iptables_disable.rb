if platform_family?('debian', 'rhel')
	service 'iptables' do
	  	action [ :disable, :stop ]
	end
end