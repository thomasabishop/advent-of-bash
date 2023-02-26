#!/bin/bash
testInput="../input.test.txt"
input="../input.txt"

# Create letter->integer mapping as before
declare -A alphabetMap=()
alphabet=({a..z} {A..Z})

q=1
for i in "${alphabet[@]}"; do
    alphabetMap["$i"]=$q
    (( q++ ))
done

declare -i grandTotal=0

# Read the input in groups of three lines
while mapfile -t -n 3 ary && ((${#ary[@]})); do
    firstStr=${ary[0]}
    secondStr=${ary[1]}
    thirdStr=${ary[2]}
    declare -i firstStrLen=$(expr length $firstStr)
    declare -a matches=()
    for (( i=0; i<${firstStrLen}; i++ )); do
        currentChar="${firstStr:$i:1}"
        # Test if the current character in the first string exists in the second and third strings
        if [[ "$secondStr" == *"$currentChar"* ]] && [[ "$thirdStr" == *"$currentChar"* ]]; then
            # If so add to match array
            matches+=($currentChar)
        fi
    done
    
    # Remove duplicates in case common character occurs more than once
    uniqueMatches=($(echo "${matches[@]}" | tr ' ' '\n' | sort -u))
    
    # Sum total, using character->int map
    for x in "${uniqueMatches[@]}"; do
        (( grandTotal+=alphabetMap[$x] ))
    done
done < $input

echo $grandTotal
