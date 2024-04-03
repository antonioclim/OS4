#!/bin/bash

# Fibonacci using only FOR loop and IF-ELSE
# Pretty ...ineficient but functional

# Define the function (also pretty .... much as in C)


# Recursive function to calculate Fibonacci number (actually if-else are enough)
fibonacci() {
    local n=$1
    # Base case: F(0) = 0, F(1) = 1
    if [ "$n" -eq 0 ]; then
        echo 0
    elif [ "$n" -eq 1 ]; then
        echo 1
    else
        # Recursive case: 
        echo $(( $(fibonacci $((n - 1))) + $(fibonacci $((n - 2))) ))
    fi
}

# We can use a FOR loop inside the function to demonstrate calling the function up to n
# Note: This is a conceptual demonstration.

calculate_up_to_n() {
    local n=$1
    for (( i=0; i<=n; i++ )); do
        echo -n "F($i) = "
        fibonacci $i
    done
}

# Validate and process CLI first argument provided by user
if [ -z "$1" ]; then
    echo "Usage: $0 <n>"
    exit 1
elif ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Input must be a non-negative integer."
    exit 1
fi

# Call the demonstration function
calculate_up_to_n $1
