# переделано с ansible
# knocking port

vagrant ssh centralRouter
bash /vagrant/knock.sh 192.168.255.1 8881 7777 9991

# проброс порта
cо своей машины

curl http://localhost:8080
