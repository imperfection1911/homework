#!/bin/bash
# скрипт для парсинга лога в этом же каталоге. Выдает кол-во вызовов каждого метода
# файл защиты от мультизапуска
export LOCK=/var/tmp/parser.lock
# функция проверки правильности запуска
check_params(){
 if [ $# -ne 1 ] || [ ! -f $1 ]
 then
  echo "run parser with path to logfile as first argument"
  return 1
 fi
}

# защита от мультизапуска
check_lock(){
 if [ -f $LOCK ]
 then
  echo "already started"
  return 6
 else
  return 0
 fi
}

check_lock
if [ $? -ne 6 ]
then
 touch $LOCK
 trap 'rm -f $LOCK; exit $?' 1 2 3 9 15
else
 exit 1
fi
check_params $@
if [ $? -eq 1 ]
then
 exit 1
else
 # регулярное выражение тут просто чтобы было
 grep -oP '(?<=(\d{4})(-\d{2}){2}\s(\d{2}:){2}\d{2}(\,\d{3})\s)(.*)' $1 | grep statistics | awk '{print $5}' | tr -d ':' | sort | uniq -c | sort -nk 1 > $LOCK
# вывод содержимого файла.
 while read line
 do
  echo $line
 done < $LOCK
fi
rm -f $LOCK
