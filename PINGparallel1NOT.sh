#!/bin/bash

# Check if the job list file exists
JOB_LIST="job-list.txt"
if [ ! -f "$JOB_LIST" ]; then
    echo "Error: File $JOB_LIST does not exist."
    exit 1
fi

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

    # Print the operation being performed
    echo "Pinging $HOSTNAME $PING_COUNT times."

    # Execute the ping command with the -c and -q options
    # Store the result in a variable
    PING_RESULT=$(ping -c "$PING_COUNT" -q "$HOSTNAME")

    # Check if ping command was successful
    if [ $? -eq 0 ]; then
        echo "Ping to $HOSTNAME was successful:"
        echo "$PING_RESULT"
        echo "--------------------------------------"
    else
        echo "Ping to $HOSTNAME failed."
    fi

# Pass the job list file to the while loop
done < "$JOB_LIST"

echo "Network reachability summary completed."

