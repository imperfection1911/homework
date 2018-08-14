#!/bin/bash
# скрипт для разделения текстового файла на n одинаковых частей.
# проверка что при запуске передано не менее 2 аргументов, первый аргумент - существующий файл и 2 аргумент не меньше и не равен 0
check_arg(){
 if [ $# -lt 2 ] || [ ! -f $1 ] || [ $2 -le 0 ]
 then
  return 1
 fi
}

# получение кол-ва линий в одной части файла
get_line_count(){
 export count=$(wc -l $1 | cut -d ' ' -f 1)
 export part_row_count=$(($count / $2))
 part_row_count=$(echo $part_row_count | awk '{ print int($1)}') 
}

# проверка корректности запуска
check_arg $@
if [ $? -eq 1 ]
then
 echo "как то неправильно вы запускаете..."
 exit
fi
# кол-во линий в каждом файле
get_line_count $1 $2
# счетчик строк
part=$((0+$part_row_count))
# счетчик частей файла
i=0
while [ $i -lt "$2" ]
do
 # первая часть нарезается heado-ом
 if [ $i -eq 0 ] 
 then
  head -n $part $1  > part$i
  part=$(($part+$part_row_count))
 # последующие берут head-om все предыдущие части и тейлом отрезается следующая
 else
  head -n $part $1 | tail -n +$part_row_count > part$i
 fi
 # увеличение счетчика
 i=$(($i+1)) 
done
