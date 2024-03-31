#!/bin/bash

# Check if the job list file exists
JOB_LIST="job-list.txt"
if [ ! -f "$JOB_LIST" ]; then
    echo "Error: File $JOB_LIST does not exist."
    exit 1
fi

# Function to perform ping and print results
# This is used to run each ping in the background
ping_and_print() {
    local HOSTNAME=$1
    local PING_COUNT=$2
    # Execute the ping command with the -c and -q options
    local PING_RESULT=$(ping -c "$PING_COUNT" -q "$HOSTNAME" 2>&1)
    # Check if ping command was successful
    if [ $? -eq 0 ]; then
        echo "Ping to $HOSTNAME was successful:"
        echo "$PING_RESULT"
    else
        echo "Ping to $HOSTNAME failed:"
        echo "$PING_RESULT"
    fi
}

# Read each line from the job list file
while IFS= read -r line; do
    # Split the line into hostname and number of pings
    read -ra ADDR <<< "$line"
    HOSTNAME=${ADDR[0]}
    PING_COUNT=${ADDR[1]}
    
    # Validate that the ping count is a number
    if ! [[ $PING_COUNT =~ ^[0-9]+$ ]]; then
        echo "Error: Ping count for $HOSTNAME is not a valid number."
        continue
    fi
    
    # Run ping_and_print function in background for parallel processing
    ping_and_print "$HOSTNAME" "$PING_COUNT" &
    
    # Uncomment the next line if you want to limit the number of concurrent pings
    # [ $(jobs -r | wc -l) -ge 10 ] && wait -n

# Pass the job list file to the while loop
done < "$JOB_LIST"

# Wait for all background pings to complete
wait

echo "Network reachability summary completed."

