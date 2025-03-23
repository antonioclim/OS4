#!/bin/bash

# Define a recursive function to calculate Fibonacci number
fibonacci() {
    local n=$1
    # Base case: F(0) = 0, F(1) = 1
    if [ "$n" -eq 0 ]; then
        echo 0
    elif [ "$n" -eq 1 ]; then
        echo 1
    else
        # Recursive case: F(n) = F(n-1) + F(n-2)
        echo $(( $(fibonacci $((n - 1))) + $(fibonacci $((n - 2))) ))
    fi
}

# Validate input: ensure it's a non-negative integer
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Input must be a non-negative integer."
    exit 1
fi

# Check if the input argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <n>"
    echo "Where <n> is the nth Fibonacci number to calculate"
    exit 1
fi

# Calculate and print the Fibonacci sequence up to the nth number
for (( i=0; i<=$1; i++ )); do
    result=$(fibonacci $i)
    echo "F($i) = $result"
done
