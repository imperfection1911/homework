# -*- mode: ruby -*-
# vim: set ft=ruby :
# -*- mode: ruby -*-
# vim: set ft=ruby :

MACHINES = {
:inetRouter => {
        :box_name => "centos/6",
        #:public => {:ip => '10.10.10.1', :adapter => 1},
        :net => [
                   {ip: '192.168.255.1', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router-net"},
		   {adapter: 3, virtualbox__intnet: "router-net"},
                ]
  },
  :centralRouter => {
        :box_name => "centos/7",
        :net => [
                   {ip: '192.168.255.2', adapter: 2, netmask: "255.255.255.252", virtualbox__intnet: "router-net"},
                   {ip: '192.168.0.1', adapter: 3, netmask: "255.255.255.240", virtualbox__intnet: "dir-net"},
                   {ip: '192.168.0.33', adapter: 4, netmask: "255.255.255.240", virtualbox__intnet: "hw-net"},
                   {ip: '192.168.0.65', adapter: 5, netmask: "255.255.255.192", virtualbox__intnet: "mgt-net"},
		   {ip: '192.168.100.1', adapter: 6, netmask: "255.255.255.252", virtualbox__intnet: "central_1"},
		   {ip: '192.168.110.1', adapter: 7, netmask: "255.255.255.252", virtualbox__intnet: "central_2"},
		   {adapter: 8, virtualbox__intnet: "router-net"},
                ]
  },
  
#  :centralServer => {
#        :box_name => "centos/7",
#        :net => [
#                   {ip: '192.168.0.2', adapter: 2, netmask: "255.255.255.240", virtualbox__intnet: "dir-net"},
#                   {adapter: 3, auto_config: false, virtualbox__intnet: true},
#                   {adapter: 4, auto_config: false, virtualbox__intnet: true},
#                ]
#  },

# роутер 1 офиса
 :office1Router => {
       :box_name => "centos/7",
       :net => [
                  {ip: '192.168.100.2', adapter: 2, netmask: '255.255.255.252', virtualbox__intnet: "central_1"},
		  {ip: '192.168.2.1', adapter: 3, netmask: '255.255.255.192', virtualbox__intnet: "dev_1"},
                  {ip: '192.168.2.65', adapter: 4, netmask: '255.255.255.192', virtualbox__intnet: "test_1"},
		  {ip: '192.168.2.129', adapter: 5, netmask: '255.255.255.192', virtualbox__intnet: "manager_1"},
		  {ip: '192.168.2.193', adapter: 6, netmask: '255.255.255.192', virtualbox__intnet: "hardware_1"},
               ]
 },

# :office1Server => {
#	:box_name => "centos/7",
#	:net => [
#		  {ip: '192.168.2.2', adapter: 2, netmask: '255.255.255.192', virtualbox__intnet: "dev_1"},
#		  {adapter: 3, auto_config: false, virtualbox__intnet: true},
#                  {adapter: 4, auto_config: false, virtualbox__intnet: true},
#		]
#},

# роутер 2 офиса
# :office2Router => {
#	:box_name => "centos/7",
#	:net => [
#		  {ip: '192.168.110.2', adapter: 2, netmask: '255.255.255.252', virtualbox__intnet: "central_2"},
#		  {ip: '192.168.1.1', adapter: 3, netmask: '255.255.255.128', virtualbox__intnet: "dev_2"},
#		  {ip: '192.168.1.129', adapter: 4, netmask: '255.255.255.192', virtualbox__intnet: "test_2"},
#		  {ip: '192.168.1.193', adapter: 5, netmask: '255.255.255.192', virtualbox__intnet: "hardware_2"},
#		]
#},

# :office2Server => {
#	:box_name => "centos/7",
#	:net => [
#		  {ip: '192.168.1.2', adapter: 2, netmask: '255.255.255.128', virtualbox__intnet: "dev_2"},
#		  {adapter: 3, auto_config: false, virtualbox__intnet: true},
#                  {adapter: 4, auto_config: false, virtualbox__intnet: true}, 
#		]
#},
  :testServer1 => {
  	:box_name => "centos/7",
	:net => [
		 {ip: '192.168.2.66', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "test_1"},
		 {adapter: 3, auto_config: false, virtualbox__intnet: 'vlan0'},
		]
},

  :testClient1 => {
  	:box_name => "centos/7",
	:net => [
		 {ip: '192.168.2.67', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "test_1"},
		 {adapter: 3, auto_config: false, virtualbox__intnet: 'vlan0'},
		]
},
  :testServer2 => {
  	:box_name => "centos/7",
	:net => [
		 {ip: '192.168.2.68', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "test_1"},
		 {adapter: 3, auto_config: false, virtualbox__intnet: 'vlan1'},
		]
},

  :testClient2 => {
  	:box_name => "centos/7",
	:net => [
		 {ip: '192.168.2.69', adapter: 2, netmask: "255.255.255.192", virtualbox__intnet: "test_1"},
		 {adapter: 3, auto_config: false, virtualbox__intnet: 'vlan1'},
		]
},
  
}

Vagrant.configure("2") do |config|

  MACHINES.each do |boxname, boxconfig|

    config.vm.define boxname do |box|

        box.vm.box = boxconfig[:box_name]
        box.vm.host_name = boxname.to_s

        boxconfig[:net].each do |ipconf|
          box.vm.network "private_network", ipconf
        end
        
        if boxconfig.key?(:public)
          box.vm.network "public_network", boxconfig[:public]
        end

        box.vm.provision "shell", inline: <<-SHELL
          mkdir -p ~root/.ssh
                cp ~vagrant/.ssh/auth* ~root/.ssh
        SHELL
        
        case boxname.to_s
        when "inetRouter"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo net.ipv4.conf.all.forwarding=1 > /etc/sysctl.conf
	    echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
	    sysctl -p /etc/sysctl.conf
	    echo -e 'DEVICE="bond0"\nONBOOT=yes\nTYPE=Bond\nBONDING_MASTER=yes\nIPADDR=192.168.255.1\nPREFIX=30\nBOOTPROTO=none\nBONDING_OPTS="mode=1 miimon=100 fail_over_mac=1"' > /etc/sysconfig/network-scripts/ifcfg-bond0
	    echo -e 'DEVICE="eth1"\nONBOOT=yes\nSLAVE=yes\nMASTER=bond0\nBOOTPROTO=none' > /etc/sysconfig/network-scripts/ifcfg-eth1
	    echo -e 'DEVICE="eth2"\nONBOOT=yes\nSLAVE=yes\nMASTER=bond0\nBOOTPROTO=none' > /etc/sysconfig/network-scripts/ifcfg-eth2
	    service network restart
	    iptables -t nat -A POSTROUTING ! -d 192.168.0.0/16 -o eth0 -j MASQUERADE
	    ip route add 192.168.0.0/16 via 192.168.255.2
            SHELL
        when "centralRouter"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo net.ipv4.conf.all.forwarding=1 >> /etc/sysctl.conf
	    echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
	    sysctl -p /etc/sysctl.conf
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            systemctl restart network
            ip route add 192.168.2.0/24 via 192.168.100.2
	    ip route add 192.168.1.0/24 via 192.168.110.2
	    echo -e 'DEVICE="bond0"\nONBOOT=yes\nTYPE=Bond\nBONDING_MASTER=yes\nIPADDR=192.168.255.2\nPREFIX=30\nGATEWAY=192.168.255.1\nBOOTPROTO=none\nBONDING_OPTS="mode=1 miimon=100 fail_over_mac=1"'> /etc/sysconfig/network-scripts/ifcfg-bond0
	    echo -e 'DEVICE="eth1"\nONBOOT=yes\nSLAVE=yes\nMASTER=bond0\nBOOTPROTO=none' > /etc/sysconfig/network-scripts/ifcfg-eth1
	    echo -e 'DEVICE="eth7"\nONBOOT=yes\nSLAVE=yes\nMASTER=bond0\nBOOTPROTO=none' > /etc/sysconfig/network-scripts/ifcfg-eth7
	    systemctl restart network
            SHELL
        when "centralServer"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            echo "GATEWAY=192.168.0.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
            systemctl restart network
            SHELL
	when "office1Router"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
	    echo net.ipv4.conf.all.forwarding=1 >> /etc/sysctl.conf
	    sysctl -p /etc/sysctl.conf
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            echo "GATEWAY=192.168.100.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
            systemctl restart network
            SHELL
	when "office1Server"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            echo "GATEWAY=192.168.2.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
            systemctl restart network
            SHELL
	when "office2Router"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo net.ipv4.ip_forward=1 >> /etc/sysctl.conf
	    sysctl -p /etc/sysctl.conf
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            echo "GATEWAY=192.168.110.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
            systemctl restart network
            SHELL
	when "office2Server"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            echo "GATEWAY=192.168.1.1" >> /etc/sysconfig/network-scripts/ifcfg-eth1
            systemctl restart network
            SHELL
	when "testServer1"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            echo -e 'NM_CONTROLLED=no\nBOOTPROTO=none\nONBOOT=yes\nDEVICE=eth2' > /etc/sysconfig/network-scripts/ifcfg-eth2
	    echo -e 'DEVICE=eth2.2\nVLAN=yes\nBOOTPROTO=static\nONBOOT=yes\nTYPE=Ethernet\nIPADDR=10.10.10.1\nPREFIX=24\nNM_CONTROLLED=no' > /etc/sysconfig/network-scripts/ifcfg-eth2.2
	    echo 'GATEWAY=192.168.2.65' >> /etc/sysconfig/network-scripts/ifcfg-eth1
            systemctl restart network
            SHELL
	when "testClient1"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
            echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
            echo -e 'NM_CONTROLLED=no\nBOOTPROTO=none\nONBOOT=yes\nDEVICE=eth2' > /etc/sysconfig/network-scripts/ifcfg-eth2
	    echo -e 'DEVICE=eth2.2\nVLAN=yes\nBOOTPROTO=static\nONBOOT=yes\nTYPE=Ethernet\nIPADDR=10.10.10.254\nPREFIX=24\nNM_CONTROLLED=no' > /etc/sysconfig/network-scripts/ifcfg-eth2.2
	    echo 'GATEWAY=192.168.2.65' >> /etc/sysconfig/network-scripts/ifcfg-eth1
            systemctl restart network
	    SHELL
	when "testServer2"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
	   echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
           echo -e 'NM_CONTROLLED=no\nBOOTPROTO=none\nONBOOT=yes\nDEVICE=eth2' > /etc/sysconfig/network-scripts/ifcfg-eth2
	   echo -e 'DEVICE=eth2.2\nVLAN=yes\nBOOTPROTO=static\nONBOOT=yes\nTYPE=Ethernet\nIPADDR=10.10.10.1\nPREFIX=24\nNM_CONTROLLED=no' > /etc/sysconfig/network-scripts/ifcfg-eth2.2
	   echo 'GATEWAY=192.168.2.65' >> /etc/sysconfig/network-scripts/ifcfg-eth1
           systemctl restart network
	   SHELL
	when "testClient2"
          box.vm.provision "shell", run: "always", inline: <<-SHELL
	   echo "DEFROUTE=no" >> /etc/sysconfig/network-scripts/ifcfg-eth0 
           echo -e 'NM_CONTROLLED=no\nBOOTPROTO=none\nONBOOT=yes\nDEVICE=eth2' > /etc/sysconfig/network-scripts/ifcfg-eth2
	   echo -e 'DEVICE=eth2.2\nVLAN=yes\nBOOTPROTO=static\nONBOOT=yes\nTYPE=Ethernet\nIPADDR=10.10.10.254\nPREFIX=24\nNM_CONTROLLED=no' > /etc/sysconfig/network-scripts/ifcfg-eth2.2
	   echo 'GATEWAY=192.168.2.65' >> /etc/sysconfig/network-scripts/ifcfg-eth1
           systemctl restart network 
	   SHELL

        end
	

      end

  end
  
  
end
