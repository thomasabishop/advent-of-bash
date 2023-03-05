#!/bin/bash

<<comment
Problem summary:
    Find the top three groups with the highest sum. Sum those values.
comment

input="../input.txt"


declare -i runningTotal=0
# declare -i highest=0

declare -a sums=()

while read line;
do
    # Sum values of each consecutive line
    (( runningTotal+=line ))
    # At double new line, stop and add sum to arr, reset sum var
    if [[ "$line" =~ ^$ ]]; then
        sums+=($runningTotal)
        (( runningTotal=0 ))
    fi
done < "$input"

# Sort array highest to lowest
sorted_asc=($(echo "${sums[@]}" | tr " " "\n" | sort -nr))

# Return sum of top three values
topThree=0
for ((i=0; i<3; i++))
do
    topThree=$((topThree + sorted_asc[i]))
done

echo $topThree

# Solution = 198041
