
#!/bin/bash
#bash script to openvpn.log

# Define the file path
FILE_PATH="/etc/openvpn/openvpn.log"

# Check if the file exists and is readable
if [[ -r $FILE_PATH ]]; then
    # Read the content of the file into a variable named FILE_CONTENT
    FILE_CONTENT=$(cat "$FILE_PATH")

    # Debug: Print the content of the variable
    # echo "Content of the file:"
    # echo "$FILE_CONTENT"
	
		# set variable $ip_addresses to results of $file_content filtered to unique IP entries
		ip_addresses=($(echo "$FILE_CONTENT" | grep -oP '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b' | sort | uniq))

    
	for ip in "${ip_addresses[@]}"; do
        echo "IP Addresses in log: $ip"
    done
else
    echo "Error: Log file does not exist or is not readable."
fi

