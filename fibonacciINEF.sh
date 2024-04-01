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

# Input: n (the nth Fibonacci number to calculate) is the first command-line argument
n=$1

# Validate input: ensure it's a non-negative integer
if ! [[ "$n" =~ ^[0-9]+$ ]]; then
    echo "Error: Input must be a non-negative integer."
    exit 1
fi

# Check if the input argument is provided
if [ -z "$n" ]; then
    echo "Usage: $0 <n>"
    echo "Where <n> is the nth Fibonacci number to calculate"
    exit 1
fi

# Calculate and print the nth Fibonacci number
result=$(fibonacci $n)
echo "Fibonacci number F($n) is: $result"

