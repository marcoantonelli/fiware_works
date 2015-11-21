#!/bin/bash
i=0
#peripheral id
temp_id=28-00000283c6cd
#function
func=cat /sys/bus/w1/devices/${temp_id}/w1_slave | sed -n 's/^.*\(t=[^ ]*\).*/\1/p' | sed 's/t=//' | awk '{x=$1}END{print(x/1000)}'
#infinite loop
for (( ; ; ))
do
  #curl PUT request to update a value
  curl -v -H "Accept: application/json" -H "Content-type: application/json" -X PUT -d '{"value": "'"$func"'"}' 192.168.2.135:1026/v1/contextEntities/Watly_01/attributes/human_distance
  i=$((i + 1))
  #stop loop for 5 seconds
  sleep 5
done

