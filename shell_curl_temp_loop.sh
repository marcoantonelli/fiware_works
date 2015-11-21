#!/bin/bash
i=0
#infinite loop
for (( ; ; ))
do
#create the temp variable. it reads the temperature sensor value
sensor_temp=$(cat /sys/bus/w1/devices/28-00000484153d/w1_slave | sed -n 's/^.*\(t=[^ ]*\).*/\1/p' | sed 's/t=//' | awk '{x=$1}END{print(x/1000)}')
#check sensor temperature
echo $sensor_temp
  #curl PUT request to update a value
  curl -v -H "Accept: application/json" -H "Content-type: application/json" -X PUT -d '{"value": "'"$sensor_temp"'"}' 192.168.2.135:1026/v1/contextEntities/Watly_01/attributes/temperature
  i=$((i + 1))
  #stop loop for 3 seconds
  sleep 3
done
