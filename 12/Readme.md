# OSPF
## Поднять OSPF между машинами на базе Quagga
Vagrantfile в каталоге 1

### s1
```
ip a
[vagrant@s1 ~]$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 86025sec preferred_lft 86025sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:49:cf:72 brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:2a:f1:45 brd ff:ff:ff:ff:ff:ff
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:81:00:88 brd ff:ff:ff:ff:ff:ff
    inet 10.1.0.1/24 brd 10.1.0.255 scope global eth3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe81:88/64 scope link 
       valid_lft forever preferred_lft forever
6: eth1.1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:49:cf:72 brd ff:ff:ff:ff:ff:ff
    inet 192.168.16.1/30 brd 192.168.16.3 scope global eth1.1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe49:cf72/64 scope link 
       valid_lft forever preferred_lft forever
7: eth2.2@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:2a:f1:45 brd ff:ff:ff:ff:ff:ff
    inet 192.168.17.1/30 brd 192.168.17.3 scope global eth2.2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe2a:f145/64 scope link 
       valid_lft forever preferred_lft forever

конфиги
/etc/quagga/zebra.conf 
hostname s1
interface eth1
ip address 192.168.16.1/30
interface eth2
ip address 192.168.17.1/30
interface eth3
ip address 10.1.0.1/24
log file /var/log/quagga/zebra.log

cat /etc/quagga/ospfd.conf 
hostname s1
router ospf
	ospf router-id 192.168.16.1
	network 192.168.16.0/30 area 0
	network 192.168.17.0/30 area 0
	network 10.1.0.0/24 area 1
redistribute connected
log file /var/log/quagg/ospfd.log

tracepath

tracepath 10.2.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.2.0.1                                              0.537ms reached
 1:  10.2.0.1                                              0.353ms reached
     Resume: pmtu 1500 hops 1 back 1 

[root@s1 vagrant]# tracepath 10.3.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.3.0.1                                              0.794ms reached
 1:  10.3.0.1                                              0.604ms reached
     Resume: pmtu 1500 hops 1 back 1 
```     
     
### s2
```
[root@s2 vagrant]# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 85356sec preferred_lft 85356sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:43:db:52 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::efbe:a3bf:9eb6:2b85/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:9c:6e:60 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::dd89:ef7a:3153:7ec/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:30:40:c1 brd ff:ff:ff:ff:ff:ff
    inet 10.2.0.1/24 brd 10.2.0.255 scope global eth3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe30:40c1/64 scope link 
       valid_lft forever preferred_lft forever
6: eth1.1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:43:db:52 brd ff:ff:ff:ff:ff:ff
    inet 192.168.16.2/30 brd 192.168.16.3 scope global eth1.1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe43:db52/64 scope link 
       valid_lft forever preferred_lft forever
7: eth2.3@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:9c:6e:60 brd ff:ff:ff:ff:ff:ff
    inet 192.168.18.1/30 brd 192.168.18.3 scope global eth2.3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe9c:6e60/64 scope link 
       valid_lft forever preferred_lft forever

конфиги

[root@s2 vagrant]# find /etc/quagga/* -type f -exec echo {} \; -exec cat {} \;
/etc/quagga/daemons
zebra=yes
bgpd=no
ospfd=yes
ospf6d=no
ripd=no
ripngd=no
/etc/quagga/ospfd.conf
hostname s2
router ospf
	ospf router-id 192.168.16.2
	network 192.168.16.0/30 area 0
	network 192.168.18.0/30 area 0
	network 10.2.0.0/24 area 1
redistribute connected
log file /var/log/quagg/ospfd.log
/etc/quagga/vtysh.conf
/etc/quagga/zebra.conf
hostname s2
interface eth1
ip address 192.168.16.2/30
interface eth2
ip address 192.168.18.1/30
interface eth3
ip address 10.2.0.1/24
log file /var/log/quagga/zebra.log

[root@s2 vagrant]# tracepath 10.1.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.1.0.1                                              0.448ms reached
 1:  10.1.0.1                                              0.335ms reached
     Resume: pmtu 1500 hops 1 back 1 
[root@s2 vagrant]# tracepath 10.3.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.3.0.1                                              0.399ms reached
 1:  10.3.0.1                                              0.331ms reached
     Resume: pmtu 1500 hops 1 back 1 
```
     
### s3

интерфейсы

```
[root@s3 vagrant]# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 85378sec preferred_lft 85378sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:ca:f1:fd brd ff:ff:ff:ff:ff:ff
    inet6 fe80::5d6f:fc1b:ed84:d3b5/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:6d:ce:c3 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::16d6:5b66:a38c:c780/64 scope link tentative 
       valid_lft forever preferred_lft forever
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:78:30:08 brd ff:ff:ff:ff:ff:ff
    inet 10.3.0.1/24 brd 10.3.0.255 scope global eth3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe78:3008/64 scope link 
       valid_lft forever preferred_lft forever
6: eth1.2@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:ca:f1:fd brd ff:ff:ff:ff:ff:ff
    inet 192.168.17.2/30 brd 192.168.17.3 scope global eth1.2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feca:f1fd/64 scope link 
       valid_lft forever preferred_lft forever
7: eth2.3@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:6d:ce:c3 brd ff:ff:ff:ff:ff:ff
    inet 192.168.18.2/30 brd 192.168.18.3 scope global eth2.3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe6d:cec3/64 scope link 
       valid_lft forever preferred_lft forever
       
  конфиги
  
  [root@s3 vagrant]# find /etc/quagga/* -type f -exec echo {} \; -exec cat {} \;
/etc/quagga/daemons
zebra=yes
bgpd=no
ospfd=yes
ospf6d=no
ripd=no
ripngd=no
/etc/quagga/ospfd.conf
hostname s3
router ospf
	ospf router-id 192.168.17.2
	network 192.168.17.0/30 area 0
	network 192.168.18.0/30 area 0
	network 10.3.0.0/24 area 1
redistribute connected
log file /var/log/quagg/ospfd.log
/etc/quagga/vtysh.conf
/etc/quagga/zebra.conf
hostname s3
interface eth1
ip address 192.168.17.2/30
interface eth2
ip address 192.168.18.2/30
interface eth3
ip address 10.3.0.1/24
log file /var/log/quagga/zebra.log

[root@s3 vagrant]# tracepath 10.1.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.1.0.1                                              0.915ms reached
 1:  10.1.0.1                                              0.596ms reached
     Resume: pmtu 1500 hops 1 back 1 
[root@s3 vagrant]# tracepath 10.2.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.2.0.1                                              0.464ms reached
 1:  10.2.0.1                                              0.381ms reached
     Resume: pmtu 1500 hops 1 back 1
```
## Изобразить ассиметричный роутинг
 
### s1
 ```
 [root@s1 vagrant]# tracepath 10.3.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  192.168.16.2                                          0.689ms 
 1:  192.168.16.2                                          1.080ms 
 2:  10.3.0.1                                              1.403ms reached
     Resume: pmtu 1500 hops 2 back 2 
[root@s1 vagrant]# tracepath 10.2.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.2.0.1                                              0.526ms reached
 1:  10.2.0.1                                              0.457ms reached
     Resume: pmtu 1500 hops 1 back 1 
[root@s1 vagrant]# ip a 
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 85978sec preferred_lft 85978sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:23:cb:dc brd ff:ff:ff:ff:ff:ff
    inet6 fe80::55e4:ad12:2a30:49eb/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:e2:b2:98 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::3f32:5e79:51b4:29bc/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:9d:f0:d3 brd ff:ff:ff:ff:ff:ff
    inet 10.1.0.1/24 brd 10.1.0.255 scope global eth3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe9d:f0d3/64 scope link 
       valid_lft forever preferred_lft forever
6: eth1.1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:23:cb:dc brd ff:ff:ff:ff:ff:ff
    inet 192.168.16.1/30 brd 192.168.16.3 scope global eth1.1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe23:cbdc/64 scope link 
       valid_lft forever preferred_lft forever
7: eth2.2@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:e2:b2:98 brd ff:ff:ff:ff:ff:ff
    inet 192.168.17.1/30 brd 192.168.17.3 scope global eth2.2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fee2:b298/64 scope link 
       valid_lft forever preferred_lft forever
[root@s1 vagrant]# find /etc/quagga/ -type f -exec echo {} \; -exec cat {} \;
/etc/quagga/zebra.conf
hostname s1
interface eth1
ip address 192.168.16.1/30
interface eth2
ip address 192.168.17.1/30
interface eth3
ip address 10.1.0.1/24
log file /var/log/quagga/zebra.log
/etc/quagga/vtysh.conf
/etc/quagga/daemons
zebra=yes
bgpd=no
ospfd=yes
ospf6d=no
ripd=no
ripngd=no
/etc/quagga/ospfd.conf
hostname s1
router ospf
	ospf router-id 192.168.16.1
	network 192.168.16.0/30 area 0
	network 192.168.17.0/30 area 0
	network 10.1.0.0/24 area 1
	redistribute connected
interface eth2.2
ip ospf cost 300
log file /var/log/quagg/ospfd.log
```
На остальных ничего не поменялось


## Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным

### s1
```
[root@s1 vagrant]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 85846sec preferred_lft 85846sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:f4:6a:3b brd ff:ff:ff:ff:ff:ff
    inet6 fe80::629b:5ea3:15a2:4386/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:96:09:f1 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::7646:75a2:7d56:9eed/64 scope link noprefixroute 
       valid_lft forever preferred_lft forever
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:ea:19:22 brd ff:ff:ff:ff:ff:ff
    inet 10.1.0.1/24 brd 10.1.0.255 scope global eth3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:feea:1922/64 scope link 
       valid_lft forever preferred_lft forever
6: eth1.1@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:f4:6a:3b brd ff:ff:ff:ff:ff:ff
    inet 192.168.16.1/30 brd 192.168.16.3 scope global eth1.1
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fef4:6a3b/64 scope link 
       valid_lft forever preferred_lft forever
7: eth2.2@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:96:09:f1 brd ff:ff:ff:ff:ff:ff
    inet 192.168.17.1/30 brd 192.168.17.3 scope global eth2.2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe96:9f1/64 scope link 
       valid_lft forever preferred_lft forever
[root@s1 vagrant]# tracepath 10.3.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  192.168.16.2                                          0.692ms 
 1:  192.168.16.2                                          0.608ms 
 2:  10.3.0.1                                              1.022ms reached
     Resume: pmtu 1500 hops 2 back 2 
[root@s1 vagrant]# tracepath 10.2.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.2.0.1                                              0.669ms reached
 1:  10.2.0.1                                              0.434ms reached
     Resume: pmtu 1500 hops 1 back 1 
[root@s1 vagrant]# find /etc/quagga/ -type f -exec echo {} \; -exec cat {} \;
/etc/quagga/zebra.conf
hostname s1
interface eth1
ip address 192.168.16.1/30
interface eth2
ip address 192.168.17.1/30
interface eth3
ip address 10.1.0.1/24
log file /var/log/quagga/zebra.log
/etc/quagga/vtysh.conf
/etc/quagga/daemons
zebra=yes
bgpd=no
ospfd=yes
ospf6d=no
ripd=no
ripngd=no
/etc/quagga/ospfd.conf
hostname s1
router ospf
	ospf router-id 192.168.16.1
	network 192.168.16.0/30 area 0
	network 192.168.17.0/30 area 0
	network 10.1.0.0/24 area 1
	redistribute connected
interface eth2.2
ip ospf cost 300
log file /var/log/quagg/ospfd.log

### s3

[root@s3 vagrant]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 52:54:00:c9:c7:04 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 brd 10.0.2.255 scope global noprefixroute dynamic eth0
       valid_lft 86042sec preferred_lft 86042sec
    inet6 fe80::5054:ff:fec9:c704/64 scope link 
       valid_lft forever preferred_lft forever
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:20:9f:f9 brd ff:ff:ff:ff:ff:ff
4: eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:bd:82:77 brd ff:ff:ff:ff:ff:ff
5: eth3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP group default qlen 1000
    link/ether 08:00:27:57:3c:3e brd ff:ff:ff:ff:ff:ff
    inet 10.3.0.1/24 brd 10.3.0.255 scope global eth3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe57:3c3e/64 scope link 
       valid_lft forever preferred_lft forever
6: eth1.2@eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:20:9f:f9 brd ff:ff:ff:ff:ff:ff
    inet 192.168.17.2/30 brd 192.168.17.3 scope global eth1.2
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:fe20:9ff9/64 scope link 
       valid_lft forever preferred_lft forever
7: eth2.3@eth2: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
    link/ether 08:00:27:bd:82:77 brd ff:ff:ff:ff:ff:ff
    inet 192.168.18.2/30 brd 192.168.18.3 scope global eth2.3
       valid_lft forever preferred_lft forever
    inet6 fe80::a00:27ff:febd:8277/64 scope link 
       valid_lft forever preferred_lft forever
[root@s3 vagrant]# tracepath 10.1.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  192.168.18.1                                          0.760ms 
 1:  192.168.18.1                                          0.620ms 
 2:  10.1.0.1                                              0.931ms reached
     Resume: pmtu 1500 hops 2 back 2 
[root@s3 vagrant]# tracepath 10.2.0.1
 1?: [LOCALHOST]                                         pmtu 1500
 1:  10.2.0.1                                              0.387ms reached
 1:  10.2.0.1                                              0.371ms reached
     Resume: pmtu 1500 hops 1 back 1 
 [root@s3 vagrant]# find /etc/quagga/ -type f -exec  echo {} \; -exec cat {} \;
/etc/quagga/zebra.conf
hostname s3
interface eth1
ip address 192.168.17.2/30
interface eth2
ip address 192.168.18.2/30
interface eth3
ip address 10.3.0.1/24
log file /var/log/quagga/zebra.log
/etc/quagga/vtysh.conf
/etc/quagga/daemons
zebra=yes
bgpd=no
ospfd=yes
ospf6d=no
ripd=no
ripngd=no
/etc/quagga/ospfd.conf
hostname s3
router ospf
	ospf router-id 192.168.17.2
	network 192.168.17.0/30 area 0
	network 192.168.18.0/30 area 0
	network 10.3.0.0/24 area 1
	redistribute connected
interface eth1.2
ip ospf cost 300
log file /var/log/quagg/ospfd.log
```
