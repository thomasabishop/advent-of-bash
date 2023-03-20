#!/bin/bash

testInput="../input.test.txt"
input="../input.txt"

declare -i overlaps=0

while read line; do
    rangeOne=$(echo $line | awk -F, '{print $1}')
    rangeOneLower=$(echo $rangeOne | awk -F "-" '{print $1}')
    rangeOneUpper=$(echo $rangeOne | awk -F "-" '{print $2}')
    rangeTwo=$(echo $line | awk -F, '{print $2}')
    rangeTwoLower=$(echo $rangeTwo | awk -F "-" '{print $1}')
    rangeTwoUpper=$(echo $rangeTwo | awk -F "-" '{print $2}')
    
    if [[ $rangeOneLower -le $rangeTwoUpper ]] && [[ $rangeTwoLower -le $rangeOneUpper ]]; then
        ((overlaps++))
    fi
done < $input

echo $overlaps
