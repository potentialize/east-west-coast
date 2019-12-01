#!/usr/bin/env bash

# array containing own ip addresses
# OWN_IPS=($(ifconfig | awk '/inet/ {print $2}'))
OWN_IPS=($HOST_IP)

# array containing droplet ip addresses
IPS=($(awk '{print $1}' ip.txt))

FILTERED_IPS=""

for i in "${IPS[@]}"
do
  if [[ ! " ${OWN_IPS[@]} " =~ " $i " ]]; then
    # add all external ips to result
    FILTERED_IPS+="$i "
  fi
done

echo $FILTERED_IPS
