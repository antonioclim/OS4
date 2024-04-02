#!/bin/bash

# Function to approximate Pi using the Leibniz formula iteratively
calculate_pi() {
    local iterations=$1
    # Initialize variables for the calculation
    local pi="0"
    local numerator="1"
    
    for (( i=0; i<iterations; i++ )); do
        # Calculate the denominator of the current term
        local denominator=$((2*i + 1))
        # Calculate the current term and update pi
        if (( i % 2 == 0 )); then
            # Add the term if i is even
            pi=$(echo "scale=20; $pi + (4 * $numerator / $denominator)" | bc -l)
        else
            # Subtract the term if i is odd
            pi=$(echo "scale=20; $pi - (4 * $numerator / $denominator)" | bc -l)
        fi
    done

    echo "$pi"
}

# Number of iterations - higher value for more precision, but within practical limits
iterations=1000
# Calculate and print the approximation of pi
pi_approx=$(calculate_pi $iterations)
echo "Approximation of Pi after $iterations iterations is: $pi_approx"

