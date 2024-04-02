#!/bin/bash

# Recursive function to approximate Pi using the Leibniz formula
# This is a demonstration and will not achieve 30 digits of precision
leibniz_pi() {
    local n=$1
    local terms=$2
    if [ $n -eq $terms ]; then
        echo "0"
    else
        # Calculate the current term: ((-1)^n) / (2n + 1)
        local current_term=$(echo "scale=10; (-1)^$n / (2*$n + 1)" | bc -l)
        # Recursive call for the next term
        local next_term=$(leibniz_pi $(($n + 1)) $terms)
        # Sum the current term and the result of the recursive call
        echo "$current_term + $next_term" | bc -l
    fi
}

# Number of terms to sum (the more terms, the higher the precision, but Bash is limited)
terms=500

# Calculate pi using the Leibniz formula (pi = 4 * sum)
pi_approx=$(echo "scale=10; 4 * $(leibniz_pi 0 $terms)" | bc -l)

echo "Approximation of Pi with $terms terms: $pi_approx"

