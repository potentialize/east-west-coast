#!/usr/bin/env bash

echo "Container starting up..."

stop_container() {
  kill ${PIDS[@]} # SIGTERM children
  wait
  echo "Container shutting down..."
  exit 0
}

trap stop_container SIGINT SIGTERM

# get ip addresses of other droplets
IPS=($(bash get_ips.sh))

echo 'Remote droplets:' ${IPS[@]}

# start a ping_ip process for each remote droplet, keep track of child pids
PIDS=()
for i in ${IPS[@]}
do
  bash ping_ip.sh $i &
  PIDS+=($!)
done

# wait until all children complete
wait
