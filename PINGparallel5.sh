#!/bin/bash

# Define the file with the list of hosts and ping counts
JOB_LIST="job-list.txt"

# Check if the job list file exists
if [ ! -f "$JOB_LIST" ]; then
    echo "Error: File $JOB_LIST does not exist."
    exit 1
fi

# Function to perform ping and print results
# This function runs in a subshell for each job in the background
ping_and_print() {
    local HOSTNAME=$1
    local PING_COUNT=$2
    # Execute the ping command with the -c (count) and -q (quiet) options
    # The command substitution $(...) captures the output of the ping command
    local PING_RESULT=$(ping -c "$PING_COUNT" -q "$HOSTNAME")
    
    # Check if the ping command was successful by examining the exit status
    if [ $? -eq 0 ]; then
        echo "Ping to $HOSTNAME was successful:"
        echo "$PING_RESULT"
    else
        echo "Ping to $HOSTNAME failed."
    fi
    echo "--------------------------------------"
}

# Read each line from the job list file
while IFS=' ' read -r HOSTNAME PING_COUNT; do
    # Run ping_and_print function in the background for parallel processing
    # The '&' at the end of the function call sends the function to the background
    ping_and_print "$HOSTNAME" "$PING_COUNT" &
done < "$JOB_LIST"

# Wait for all background jobs to finish before exiting the script
# 'wait' without arguments waits for all background jobs to complete
wait

echo "Network reachability summary completed."

