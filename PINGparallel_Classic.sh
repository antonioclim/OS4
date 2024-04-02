#!/bin/bash

# This line checks if the file 'job-list.txt' exists in the current directory.
if [ ! -f "job-list.txt" ]; then
    # If the file does not exist, print an error message and exit the script.
    echo "Error: File job-list.txt does not exist."
    exit 1
fi

# Read the file 'job-list.txt' line by line.
while IFS= read -r line; do
    # The '<<<' is called a here-string. It feeds the string into 'read' as standard input.
    # This line takes the current line of text and splits it into an array based on whitespace.
    # ADDR[0] will have the hostname, and ADDR[1] will have the number of pings.
    read -ra ADDR <<< "$line"
    
    # Assign the first part (hostname) to the variable HOSTNAME.
    HOSTNAME=${ADDR[0]}
    # Assign the second part (number of pings) to the variable PING_COUNT.
    PING_COUNT=${ADDR[1]}
    
    # Check if PING_COUNT is a number.
    if ! [[ $PING_COUNT =~ ^[0-9]+$ ]]; then
        # If PING_COUNT is not a number, print an error message and skip to the next line.
        echo "Error: Ping count for $HOSTNAME is not a valid number."
        continue
    fi
    
    # Print the operation that's going to be performed.
    echo "Pinging $HOSTNAME $PING_COUNT times."

    # Execute the ping command with the specified count and quiet mode.
    # Capture the output of the ping command into the variable PING_RESULT.
    PING_RESULT=$(ping -c "$PING_COUNT" -q "$HOSTNAME")

    # Check the exit status of the last command (ping in this case).
    if [ $? -eq 0 ]; then
        # If the exit status is 0 (success), print the successful ping message and its result.
        echo "Ping to $HOSTNAME was successful:"
        echo "$PING_RESULT"
        echo "--------------------------------------"
    else
        # If the ping failed, print a failure message.
        echo "Ping to $HOSTNAME failed."
    fi

# This done statement signifies the end of the while loop.
# It takes the 'job-list.txt' file as input to the while loop.
done < "job-list.txt"

# Print a final message indicating the script has finished running.
echo "Network reachability summary completed."

