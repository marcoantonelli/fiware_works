#!/bin/bash
i=0
#infinite loop
for (( ; ; ))
do
  #curl PUT request to update a value
  curl -v -H "Accept: application/json" -H "Content-type: application/json" -X PUT -d '{"value": "'"$i"'"}' 192.168.2.135:1026/v1/contextEntities/Watly_01/attributes/human_distance
  i=$((i + 1))
  #stop loop for 3 seconds
  sleep 5
done
