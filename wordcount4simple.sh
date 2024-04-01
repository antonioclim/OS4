#!/bin/bash
# Start time of the script in nanoseconds
start_time=$(date +%s%N)


grep -rio $1 ./TXT | wc -w

#Here's what each part of the command does:

#    grep is the command used for searching text using patterns.
#   -r or --recursive makes grep search all files in the specified directory and its subdirectories.
#   -i or --ignore-case makes the search case-insensitive, so it will match "fuck", "Fuck", "FUCK", etc.
#   -o or --only-matching prints only the matching parts of the lines, each match on a new line.
#   '$1 (first argument)' is the search term.
#   ./TXT specifies the directory to search in.
#   | wc -l pipes the output of grep to wc (word count) command, which counts the number of lines. Since each match is on its own line due to -o, this effectively counts the occurrences of the word.

#This command will give you the total number of times the word "fuck" appears in all files under ./TXT, regardless of how it's cased.



end_time=$(date +%s%N) # End time of the script in nanoseconds
execution_time=$((end_time - start_time)) # Calculate script execution time in nanoseconds
execution_time_ms=$((execution_time / 1000000)) # Convert execution time to milliseconds

echo "Execution time: $execution_time_ms milliseconds"
