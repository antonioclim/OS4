#!/bin/bash

# Calculate Pi using the Gregory-Leibniz series in a recursive manner
# pi = 4 * (1 - 1/3 + 1/5 - 1/7 + 1/9 - ...)
# This recursive method converges to Pi very slowly.

precision=30
iterations=1000  # Total number of iterations for recursion

# Recursive function to calculate Pi
calculate_pi_recursive() {
    local iteration=$1
    local total_iterations=$2

    # Base case: If the current iteration equals the total iterations, stop the recursion
    if [ "$iteration" -eq "$total_iterations" ]; then
        echo "0"
    else
        # Calculate the current term of the series
        local sign=$((iteration % 2 == 0 ? 1 : -1))
        local divisor=$((2 * iteration + 1))
        local term=$(echo "scale=$precision; $sign * 4 / $divisor" | bc -l)

        # Recursively calculate the sum of the series
        local next_sum=$(calculate_pi_recursive $((iteration + 1)) $total_iterations)
        
        # Add the current term to the sum calculated by the recursive call
        echo $(echo "scale=$precision; $term + $next_sum" | bc -l)
    fi
}

# Calculate Pi using recursion and print the result
echo "Calculating Pi to $precision digits with $iterations iterations using a recursive Gregory-Leibniz series..."
pi_approx=$(calculate_pi_recursive 0 $iterations)
echo "Pi approximated to $precision digits: $pi_approx"

