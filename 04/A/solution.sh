#!/bin/bash

testInput="../input.test.txt"
input="../input.txt"


function expandRange() {
    declare -a expandedRange=()
    for (( i=$1; i<=$2; i++ )); do
        expandedRange+=($i)
    done
    echo "${expandedRange[@]}"
}

declare -i completeOverlaps=0

while read line; do
    rangeOne=$(echo $line | awk -F, '{print $1}')
    rangeOneLower=$(echo $rangeOne | awk -F "-" '{print $1}')
    rangeOneUpper=$(echo $rangeOne | awk -F "-" '{print $2}')
    rangeTwo=$(echo $line | awk -F, '{print $2}')
    rangeTwoLower=$(echo $rangeTwo | awk -F "-" '{print $1}')
    rangeTwoUpper=$(echo $rangeTwo | awk -F "-" '{print $2}')
    
    if [ "$rangeOneUpper" -ge "$rangeTwoLower" ]; then
        expandedRangeTwo=$(expandRange $rangeTwoLower $rangeTwoUpper)
        expandedRangeOne=$(expandRange $rangeOneLower $rangeOneUpper)
        if [[ " ${expandedRangeTwo} " == *" $rangeOneLower "* ]] && [[ " ${expandedRangeTwo} " == *" $rangeOneUpper "* ]]; then
            ((completeOverlaps++))
            elif [[ " ${expandedRangeOne} " == *" $rangeTwoLower "* ]] && [[ " ${expandedRangeOne} " == *" $rangeTwoUpper "* ]]; then
            ((completeOverlaps++))
        fi
    fi
    
done < $input

echo $completeOverlaps

# Solution = 588
