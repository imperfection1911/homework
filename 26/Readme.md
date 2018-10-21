Поднимаю два mariad сервера. дамп проливается из плейбука

На мастере в конфиг [mysqld] прописывается

server-id = 1
log_bin = /var/lib/mysql/mysql-bin.log
binlog_do_db = bet

на слейве

server-id = 2
binlog_do_db = bet
replicate-ignore-table = bet.events_on_demand
replicate-ignore-table = bet.v_same_event

Создаю юзера

MariaDB [(none)]> GRANT replication slave ON *.* TO "replication"@"192.168.11.3" IDENTIFIED BY "1qaz2wsx";
Query OK, 0 rows affected (0.001 sec)

и flush privileges;

перезапускаю сервис на слейве и мастере

systemctl restart mariadb

смотрю статус мастера

MariaDB [(none)]> show master status;
+------------------+----------+--------------+------------------+
| File             | Position | Binlog_Do_DB | Binlog_Ignore_DB |
+------------------+----------+--------------+------------------+
| mysql-bin.000001 |      328 | bet          |                  |
+------------------+----------+--------------+------------------+
1 row in set (0.000 sec)

Настраиваем на слейве


MariaDB [(none)]> CHANGE MASTER TO MASTER_HOST = "192.168.11.2", MASTER_USER = "replication", MASTER_PASSWORD = "1qaz2wsx", MASTER_LOG_FILE = "mysql-bin.000003", MASTER_LOG_POS = 385;
Query OK, 0 rows affected (0.009 sec)

MariaDB [(none)]> start slave;
Query OK, 0 rows affected (0.006 sec)

MariaDB [(none)]> show slave status\G
*************************** 1. row ***************************
                Slave_IO_State: Waiting for master to send event
                   Master_Host: 192.168.11.2
                   Master_User: replication
                   Master_Port: 3306
                 Connect_Retry: 60
               Master_Log_File: mysql-bin.000003
           Read_Master_Log_Pos: 385
                Relay_Log_File: slave-relay-bin.000002
                 Relay_Log_Pos: 555
         Relay_Master_Log_File: mysql-bin.000003
              Slave_IO_Running: Yes
             Slave_SQL_Running: Yes
               Replicate_Do_DB: 
           Replicate_Ignore_DB: 
            Replicate_Do_Table: 
        Replicate_Ignore_Table: bet.v_same_event,bet.events_on_demand
       Replicate_Wild_Do_Table: 
   Replicate_Wild_Ignore_Table: 
                    Last_Errno: 0
                    Last_Error: 
                  Skip_Counter: 0
           Exec_Master_Log_Pos: 385
               Relay_Log_Space: 864
               Until_Condition: None
                Until_Log_File: 
                 Until_Log_Pos: 0
            Master_SSL_Allowed: No
            Master_SSL_CA_File: 
            Master_SSL_CA_Path: 
               Master_SSL_Cert: 
             Master_SSL_Cipher: 
                Master_SSL_Key: 
         Seconds_Behind_Master: 0
 Master_SSL_Verify_Server_Cert: No
                 Last_IO_Errno: 0
                 Last_IO_Error: 
                Last_SQL_Errno: 0
                Last_SQL_Error: 
   Replicate_Ignore_Server_Ids: 
              Master_Server_Id: 1
                Master_SSL_Crl: 
            Master_SSL_Crlpath: 
                    Using_Gtid: No
                   Gtid_IO_Pos: 
       Replicate_Do_Domain_Ids: 
   Replicate_Ignore_Domain_Ids: 
                 Parallel_Mode: conservative
                     SQL_Delay: 0
           SQL_Remaining_Delay: NULL
       Slave_SQL_Running_State: Slave has read all relay log; waiting for the slave I/O thread to update it
              Slave_DDL_Groups: 0
Slave_Non_Transactional_Groups: 0
    Slave_Transactional_Groups: 0
1 row in set (0.000 sec)


проверяем. инсертим на мастере

MariaDB [bet]> insert into bookmaker values (NULL, 'example');
Query OK, 1 row affected (0.021 sec)

MariaDB [bet]> select * from bookmaker;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  4 | betway         |
|  5 | bwin           |
|  7 | example        |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+
5 rows in set (0.000 sec)

MariaDB [bet]>


На слейве

MariaDB [bet]> select * from bookmaker order by id desc limit 1;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  7 | example        |
+----+----------------+
1 row in set (0.000 sec)

все работает
