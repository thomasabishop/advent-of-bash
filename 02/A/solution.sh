#!/bin/bash

input="../input.txt"

function convertMoveToInt {
    case $1 in
        A | X )
            echo 1
        ;;
        
        B | Y )
            echo 2
        ;;
        
        C | Z )
            echo 3
        ;;
        *)
            echo 0
        ;;
    esac
}

function abs {
    ele=$1
    echo ${ele#-}
}

declare -i totalScore=0


while read line; do
    declare -i opponentMove=$(convertMoveToInt $(echo $line | awk '{print $1}' ))
    declare -i myMove=$(convertMoveToInt $( echo $line | awk '{print $2}' ))
    declare -i diff=$(($opponentMove-$myMove))
    declare -i absDiff=$(abs $diff)
    
    if [ "$myMove" -eq "$opponentMove" ]; then
        (( totalScore+=myMove+3 ))
        elif [ $absDiff -eq 2 ] && [ "$myMove" -gt "$opponentMove" ]; then
        (( totalScore+=myMove))
        elif [ $absDiff -eq 2 ] && [ "$opponentMove" -gt "$myMove" ]; then
        (( totalScore+=myMove+6))
        elif [ $absDiff -eq 1 ] && [ "$opponentMove" -gt "$myMove" ]; then
        (( totalScore+=myMove))
        elif [ $absDiff -eq 1 ] && [ "$myMove" -gt "$opponentMove" ]; then
        (( totalScore+=myMove+6))
    fi
done < "$input"

echo ${totalScore}

