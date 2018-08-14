# Vagrant DNS Lab

A Bind's DNS lab with Vagrant and Ansible, based on CentOS 7.

# Playground

<code>
    vagrant ssh client
</code>

  * zones: dns.lab, reverse dns.lab and ddns.lab
  * ns01 (192.168.50.10)
    * master, recursive, allows update to ddns.lab
  * ns02 (192.168.50.11)
    * slave, recursive
  * client (192.168.50.15)
    * used to test the env, runs rndc and nsupdate
  * zone transfer: TSIG key

# Результат

client

```
[vagrant@client ~]$ dig web1.dns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7 <<>> web1.dns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 7257
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web1.dns.lab.			IN	A

;; ANSWER SECTION:
web1.dns.lab.		3600	IN	A	192.168.50.15

;; AUTHORITY SECTION:
dns.lab.		3600	IN	NS	ns02.dns.lab.
dns.lab.		3600	IN	NS	ns01.dns.lab.

;; ADDITIONAL SECTION:
ns01.dns.lab.		3600	IN	A	192.168.50.10
ns02.dns.lab.		3600	IN	A	192.168.50.11

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue Aug 14 15:08:34 UTC 2018
;; MSG SIZE  rcvd: 127

[vagrant@client ~]$ dig web2.dns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7 <<>> web2.dns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 29186
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web2.dns.lab.			IN	A

;; AUTHORITY SECTION:
dns.lab.		600	IN	SOA	ns01.dns.lab. root.dns.lab. 2711201407 3600 600 86400 600

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue Aug 14 15:08:43 UTC 2018
;; MSG SIZE  rcvd: 87

[vagrant@client ~]$ dig www.newdns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7 <<>> www.newdns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 48854
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 2, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.newdns.lab.			IN	A

;; ANSWER SECTION:
www.newdns.lab.		3600	IN	A	192.168.50.14
www.newdns.lab.		3600	IN	A	192.168.50.15

;; AUTHORITY SECTION:
newdns.lab.		3600	IN	NS	ns02.newdns.lab.
newdns.lab.		3600	IN	NS	ns01.newdns.lab.

;; ADDITIONAL SECTION:
ns01.newdns.lab.	3600	IN	A	192.168.50.10
ns02.newdns.lab.	3600	IN	A	192.168.50.11

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue Aug 14 15:09:13 UTC 2018
;; MSG SIZE  rcvd: 145

```


client2

```
[vagrant@client2 ~]$ dig web1.dns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7 <<>> web1.dns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 24835
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web1.dns.lab.			IN	A

;; ANSWER SECTION:
web1.dns.lab.		3600	IN	A	192.168.50.15

;; AUTHORITY SECTION:
dns.lab.		3600	IN	NS	ns01.dns.lab.
dns.lab.		3600	IN	NS	ns02.dns.lab.

;; ADDITIONAL SECTION:
ns01.dns.lab.		3600	IN	A	192.168.50.10
ns02.dns.lab.		3600	IN	A	192.168.50.11

;; Query time: 2 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue Aug 14 15:11:10 UTC 2018
;; MSG SIZE  rcvd: 127

[vagrant@client2 ~]$ dig web2.dns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7 <<>> web2.dns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 41146
;; flags: qr aa rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 2, ADDITIONAL: 3

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;web2.dns.lab.			IN	A

;; ANSWER SECTION:
web2.dns.lab.		3600	IN	A	192.168.50.14

;; AUTHORITY SECTION:
dns.lab.		3600	IN	NS	ns01.dns.lab.
dns.lab.		3600	IN	NS	ns02.dns.lab.

;; ADDITIONAL SECTION:
ns01.dns.lab.		3600	IN	A	192.168.50.10
ns02.dns.lab.		3600	IN	A	192.168.50.11

;; Query time: 1 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue Aug 14 15:11:16 UTC 2018
;; MSG SIZE  rcvd: 127

[vagrant@client2 ~]$ dig www.newdns.lab

; <<>> DiG 9.9.4-RedHat-9.9.4-61.el7 <<>> www.newdns.lab
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NXDOMAIN, id: 39985
;; flags: qr rd ra; QUERY: 1, ANSWER: 0, AUTHORITY: 1, ADDITIONAL: 1

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
;; QUESTION SECTION:
;www.newdns.lab.			IN	A

;; AUTHORITY SECTION:
.			10800	IN	SOA	a.root-servers.net. nstld.verisign-grs.com. 2018081400 1800 900 604800 86400

;; Query time: 24 msec
;; SERVER: 192.168.50.10#53(192.168.50.10)
;; WHEN: Tue Aug 14 15:11:26 UTC 2018
;; MSG SIZE  rcvd: 118
```
