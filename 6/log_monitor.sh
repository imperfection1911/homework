#!
while true
 do
  cmd=`grep $1 $2`
  if [ ! -z "$cmd" ]
   then
   logger -p info "$cmd"
  fi
  sleep 30
done
