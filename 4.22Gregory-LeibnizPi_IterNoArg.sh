#!/bin/bash

# Calculate Pi using the Gregory-Leibniz series
# pi = 4 * (1 - 1/3 + 1/5 - 1/7 + 1/9 - ...)
# This method converges to Pi very slowly.

precision=30
iterations=1000  # Increase for better accuracy, but beware of computation time

calculate_pi() {
    pi="0"

    for ((i=0; i<$iterations; i++)); do
        # Alternating series, adding and subtracting reciprocals of odd numbers
        if ((i % 2 == 0)); then  # Even index elements are added
            pi=$(echo "scale=$precision; $pi + (4 / (1 + (2 * $i)))" | bc -l)
        else  # Odd index elements are subtracted
            pi=$(echo "scale=$precision; $pi - (4 / (1 + (2 * $i)))" | bc -l)
        fi
    done

    echo "$pi"
}

echo "Calculating Pi to $precision digits with $iterations iterations using the Gregory-Leibniz series..."
pi_approx=$(calculate_pi)
echo "Pi approximated to $precision digits: $pi_approx"

