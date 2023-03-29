#!/bin/bash
FILE_PATH="/etc/openvpn/openvpn.log"

if [[ -r $FILE_PATH ]]; then
    ip_addresses=(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}:[0-9]+' /etc/openvpn/openvpn.log|sort|uniq))
    
    for ip in "${ip_addresses[@]}"; do
        echo "IP Addresses in log: $ip"
    done
else
    echo "Error: Log file does not exist or is not readable."
fi
