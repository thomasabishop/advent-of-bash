#!/bin/bash

<<comment
Problem summary:
    The input is a series of groups of integers. Each group is demarcated by a blank line. Find the group with the highest sum.
comment



input="./input.txt"

declare -i runningTotal=0
declare -i highest=0

while read line;
do
    # Sum value of each consecutive line
    (( runningTotal+=line ))
    # At double newline check to see if current sum is greater than the highest sum so far, if so update `highest` var
    if [[ "$line" =~ ^$ ]]; then
        if [[ "$runningTotal" -gt "$highest" ]]; then
            (( highest=runningTotal ))
        fi
        # Reset running sum
        (( runningTotal=0 ))
    fi
done < "$input"

echo ${highest}
