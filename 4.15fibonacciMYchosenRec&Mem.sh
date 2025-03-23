#!/bin/bash


# Function to calculate Fibonacci number using an iterative approach
fibonacci() {
    local n=$1
    # Initialize the first two Fibonacci numbers
    local a=0
    local b=1

    echo "F(0) = $a"
    if [ "$n" -ge 1 ]; then
        echo "F(1) = $b"
    fi

    # Compute Fibonacci numbers iteratively
    for (( i=2; i<=n; i++ )); do
        local temp=$((a + b))
        a=$b
        b=$temp
        echo "F($i) = $b"
    done
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

# Calculate and print each Fibonacci number up to the nth
fibonacci $n
