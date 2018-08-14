# Управление пакетами #
## 1 создать свой RPM ##
Решил собрать апач.
 + Создаю сборочную директорию
rpmdev-setuptree
+ качаю SRPMS
yumdownloader --source httpd
+ ставлю rpm 
rpm -ivh httpd-2.4.6-80.el7.centos.src.rpm
+ Правлю spec файл
vim ./rpmbuild/SPECS/httpd.spec
 Добавляю скажем --enable-so
+ запускаю сборку 
 rpmbuild -bb ./rpmbuild/SPECS/httpd.spec
+ Все что понадобилось поставить дополнительно затерялось, т.к. до того как получилось, долго мучался с какой то левой SRPM
+ В итоге получаю все необходимые rpm в ls ./rpmbuild/RPMS/x86_64/

## 2 создать свой репо и разместить там свой RPM ##
+ Поставил nginx и createrepo. yum -y install createrepo nginx
+ залил rpm-ки, создал репозиторий createrepo /var/repo/
+ открыл 80 порт iptables -I INPUT 1 -p tcp --dport 80 -j ACCEPT
+ chown -R nginx:nginx /var/repo && chown -R 755 /var/repo/
+ в конфиге nginx в root прописал /var/repo, в location / autoindex on
+ http://80.211.22.138:80/
+ Установил.
```

[root@vm1 homework]# cat /etc/yum.repos.d/myrepo.repo
[repootus]
name=repootus
baseurl=http://80.211.22.138/
enabled=1
gpgcheck=0

[root@vm1 homework]# yum list available —disablerepo="*" —enablerepo="repootus"
Загружены модули: fastestmirror
Loading mirror speeds from cached hostfile
Доступные пакеты
httpd.x86_64                                                        2.4.6-80.el7                                                 repootus
httpd-debuginfo.x86_64                                              2.4.6-80.el7                                                 repootus
httpd-devel.x86_64                                                  2.4.6-80.el7                                                 repootus
httpd-tools.x86_64                                                  2.4.6-80.el7                                                 repootus
mod_ldap.x86_64                                                     2.4.6-80.el7                                                 repootus
mod_proxy_html.x86_64                                               1:2.4.6-80.el7                                               repootus
mod_session.x86_64                                                  2.4.6-80.el7                                                 repootus
mod_ssl.x86_64

yum install —disablerepo="*" —enablerepo="repootus" httpd.x86_64
```


## 3 реализовать дополнительно пакет через docker ##
Собрал jmeter.
[Dockerfile](https://github.com/imperfection1911/homework/blob/rpm_build/8/Dockerfile)
+ Пример запуска:
docker run -d -p 55511:55511 -p 4000:4000 -v /var/test.csv:/var/test.csv -v /etc/hosts:/etc/hosts -e SERVER_HOSTNAME=192.168.16.102 --name jmeter imperfection/jmeter
