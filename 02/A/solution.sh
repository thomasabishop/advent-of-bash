#!/bin/bash

input="../input.txt"
test="../test-input.txt"
otherInput="../other-input.txt"
function convertMoveToInt {
    case $1 in
        A | X )
            echo 1
        ;;
        
        B | Y ) echo 2
        ;;
        
        C | Z )
            echo 3
        ;;
        # *)
        #     echo 0
        # ;;
    esac
}

declare -i totalScore=0

declare -i linecount=0

# while read line; do
#     (( linecount++ ))

#     echo ${linecount} > linecount.txt
# done < ${input}




while read line; do
    declare -i opponentMove=$(convertMoveToInt $(echo $line | awk '{print $1}' ))
    declare -i myMove=$(convertMoveToInt $( echo $line | awk '{print $2}' ))
    if [ "$myMove" -gt "$opponentMove" ]; then
        (( totalScore+=myMove+6 ))
        elif [ "$myMove" -eq "$opponentMove" ]; then
        (( totalScore+=myMove+3 ))
    else
        (( totalScore+=myMove ))
    fi
    echo ${totalScore}
done < "$test"

echo ${totalScore}

# Something is going wrong with the line parsing. Write in JS and compare answers.
