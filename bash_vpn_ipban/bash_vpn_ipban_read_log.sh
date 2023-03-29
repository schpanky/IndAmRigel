#!/bin/bash
#	Read openvpn.log for IP/Ports
#	README:
#	Set File_Path to your openvpn.log
#
#	from command line, run:
#	sed -i 's/\r//' setup.sh to sanitize before running
#	if you run into the error:
#	syntax error near unexpected token `$'\r''
#
#
FILE_PATH="/etc/openvpn/openvpn.log"
IP_ADDRESSES=( $(grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}:[0-9]+' $FILE_PATH|sort|uniq) )
for ip in "${IP_ADDRESSES[@]}";
do echo "IP Addresses in log: $ip"
done
