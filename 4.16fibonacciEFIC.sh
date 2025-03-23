#!/bin/bash

# Function to calculate Fibonacci number using an iterative approach
fibonacci() {
    local n=$1
    # Initialize the first two Fibonacci numbers
    local a=0
    local b=1

    # Special cases for n=0 and n=1
    if [ "$n" -eq 0 ]; then
        echo "$a"
    elif [ "$n" -eq 1 ]; then
        echo "$b"
    else
        # Compute Fibonacci numbers iteratively
        for (( i=2; i<=n; i++ )); do
            local temp=$((a + b))
            a=$b
            b=$temp
        done
        echo "$b"
    fi
}

# Input: n (the nth Fibonacci number to calculate) is the first command-line argument
n=$1

# Validate input: ensure it's a non-negative integer
if ! [[ "$n" =~ ^[0-9]+$ ]]; then
    echo "Error: Input must be a non-negative integer."
    exit 1
fi

# Check if an input argument is provided
if [ -z "$n" ]; then
    echo "Usage: $0 <n>"
    echo "Where <n> is the nth Fibonacci number to calculate"
    exit 1
fi

# Calculate and print the nth Fibonacci number using the efficient iterative method
result=$(fibonacci $n)
echo "Fibonacci number F($n) is: $result"

