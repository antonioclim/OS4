#!/bin/bash

# Define the file with the list of hosts and ping counts
JOB_LIST="job-list.txt"

# Maximum number of concurrent ping operations
MAX_JOBS=10

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
    # The redirection 2>&1 captures both stdout and stderr
    local PING_RESULT=$(ping -c "$PING_COUNT" -q "$HOSTNAME" 2>&1)
    
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
    # Skip if line is empty
    [[ -z "$HOSTNAME" ]] && continue

    # Skip if PING_COUNT is not a number
    [[ ! "$PING_COUNT" =~ ^[0-9]+$ ]] && continue

    # Run ping_and_print function in the background
    ping_and_print "$HOSTNAME" "$PING_COUNT" &

    # Wait for one of the background jobs to finish if we have reached the maximum number
    while [ $(jobs -r | wc -l) -ge "$MAX_JOBS" ]; do
        wait -n
    done
done < "$JOB_LIST"

# Wait for all background jobs to finish before exiting the script
wait

echo "Network reachability summary completed."

