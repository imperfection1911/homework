#!/bin/bash
# скрипт для отправки сообщений из очереди на заданные email
EMAILS=(imperfection1911@gmail.com example@example.com)
script_dir=$(realpath $0  | grep -oP '.*/(?=.*\.sh)')
pipe="${script_dir}pipe"
export MINUTES=30
# проверка необходимости слать письмо, дабы не заваливать почту
check_letter(){
 lock=$(find -mmin -$MINUTES -name "$1")
 if [ -z "$lock" ]
 then
  touch $1
  return 0
 else
  return 1
 fi
}

while true
do
 if [ -e $pipe ]
 then
  message=$(cat $pipe)
  if [ ! -z "$message" ]
  then
   # для каждого ящика
   for i in "${EMAILS[@]}"
   do
    # проверка, отсылалось ли уже письмо
    check_letter "$i"
    if [ $? -eq 0 ]
    then
     mail -s "alert" $i <<< $message
    fi
   done
  fi
 fi
sleep 5
trap 'for i in "${EMAILS[@]}"; do rm -f $i ; done; exit $?' 1 2 3 9 15
done

