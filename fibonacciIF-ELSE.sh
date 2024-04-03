#!/bin/bash


# Recursive function to calculate Fibonacci number
# This has an algorithmic complexity of O(2^n)
# Fibonacci number only with IF-ELSE (without any loop)
# IT IS PRETTY .... much impractical for more than 5 steps


# Define the function (also pretty .... much as in C)
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

# Helper function to print Fibonacci numbers up to n, using recursion
print_fibonacci_sequence() {
    local n=$1
    if [ "$n" -ge 0 ]; then
        print_fibonacci_sequence $((n-1)) # Recursive call
        local fib=$(fibonacci $n)
        echo "F($n) = $fib"
    fi
}

# Check for command-line argument
if [ $# -eq 0 ]; then
    echo "Usage: $0 <n>"
    echo "Calculate the nth Fibonacci number ..."
    exit 1
fi

# Validate input: ensure it's a non-negative integer
if ! [[ "$1" =~ ^[0-9]+$ ]]; then
    echo "Error: Input must be a non-negative integer."
    exit 1
fi

# Print the Fibonacci sequence up to the provided number
print_fibonacci_sequence $1
