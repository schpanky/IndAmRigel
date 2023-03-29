#!/bin/bash
FILE_PATH="/etc/openvpn/openvpn.log"
IP_ADDRESSES=( $(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}:[0-9]+' $FILE_PATH) )
for ip in "${IP_ADDRESSES[@]}"; do
  echo "IP Addresses in log: $ip"
done
