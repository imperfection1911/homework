#!/bin/bash
# скрипт для перезапуска nginx. Если nginx не запущен и не удалось его запустить - отправляет сообщение в очередь
script_dir=$(realpath $0  | grep -oP '.*/(?=.*\.sh)')
pipe="${script_dir}pipe"
while true
do
 # если не существует pid файл
 trap 'rm -f $pipe; exit $?' 1 2 3 9 15 
 if [ ! -f /var/run/nginx.pid ]
 then
  MESSAGE=$(systemctl start nginx 2>&1)
  # если код завершения команды запуска не 0
  if [ $? -ne 0 ]
  then
   # если не пустая строка вывода запуска сервиса
   if [ ! -z "$MESSAGE" ]
   then
   # если не существует пайп
    if [ ! -e $pipe ]
    then
     mkfifo $pipe
    fi
    echo "nginx не запускается - $MESSAGE" > $pipe
   fi
  fi
 fi
sleep 5
done
