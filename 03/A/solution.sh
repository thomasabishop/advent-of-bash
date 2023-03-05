#!/bin/bash

testString="vJrwpWtwJgWrhcsFMMfFFhFp"
testInput="../input.test.txt"
input="../input.txt"


# Create mapping of letters to integers
declare -A alphabetMap=()
alphabet=({a..z} {A..Z})

q=1
for i in "${alphabet[@]}"; do
    alphabetMap["$i"]=$q
    (( q++ ))
done

declare -i grandTotal=0

while read line; do
    # Divide the string on each line into segments of equal length
    declare -i stringSegmentLength=$(( $(expr length $line)/2 ))
    declare -a lineMatches=()
    declare -i lineTotal=0
    segmentOne=${line:0:${stringSegmentLength}}
    segmentTwo=${line:${stringSegmentLength}}
    
    # For each character of the first segment, loop through the characters of the second
    # segment to identify matches. Store matching chars in an array.
    for (( i=0; i<${stringSegmentLength}; i++ )); do
        current="${segmentOne:$i:1}"
        for (( j=0; j<${stringSegmentLength}; j++ )); do
            if [ $current == "${segmentTwo:$j:1}" ]; then
                lineMatches+=($current)
            fi
        done
    done
    
    # For the given line matches, remove duplicates
    # Then, return the integer value of the character from the map and sum
    uniqueMatches=($(echo "${lineMatches[@]}" | tr ' ' '\n' | sort -u))
    for x in "${uniqueMatches[@]}"; do
        (( grandTotal+=alphabetMap[$x] ))
    done
done < $testInput

echo $grandTotal

# Solution = 7903
