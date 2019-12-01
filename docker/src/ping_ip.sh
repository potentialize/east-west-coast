#!/usr/bin/env bash

IP=$1
DEST=data/to_$IP.txt

stop_probing() {
  echo "# stop probing $IP..." | tee -a $DEST
  exit 0
}

trap stop_probing SIGINT SIGTERM

echo "# start probing $IP..." | tee -a $DEST
echo "# destination:" $DEST

while true
do
  # PING
  # -n      don't bother resolving symbolic name
  # -c 1    send out 1 ping
  # -W 2    wait 2 seconds before considering package lost
  # -q      don't bother printing redundant info
  # AWK
  # STORE IN $DEST
  # NOTE: redirect stdout and stderr of ping
  ping -n -c 1 -W 2 -q $IP |& awk -f process_probe.awk | tee -a $DEST
  sleep 2
done
