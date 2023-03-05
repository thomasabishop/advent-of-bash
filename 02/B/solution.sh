
#!/bin/bash

testInput="../input.txt"

# The following outcomes compare my opponents move to my response, depending on whether I want to win or lose...

# rock[win] = paper, rock[lose] = scissors
declare -A rock=( ["win"]="2" ["lose"]="3" )

# paper[win] = scissors, paper[lose] = rock
declare -A paper=( ["win"]="3" ["lose"]="1" )

# scissors[win] = rock, scissors[loose] = paper
declare -A scissors=( ["win"]="1" ["lose"]="2" )


# Running total
declare -i totalScore=0

function abs {
    ele=$1
    echo ${ele#-}
}

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

# Based on the second parameter of the input, determine whether I should win, lose, or draw...
function deriveMove {
    case $1 in
        A )  # if first param is "rock":
            case "$2" in
                X ) # if second param is "lose":
                    echo "${rock[lose]}"
                ;;
                
                Y ) # if second param is "draw":
                    echo "1"
                ;;
                
                Z ) # if second param is "win":
                    echo "${rock[win]}"
                ;;
                
            esac
        ;;
        
        B ) # if first param is "paper":
            case "$2" in
                X ) # if second param is "lose":
                    echo "${paper[lose]}"
                ;;
                
                Y ) # if second param is "draw":
                    echo "2"
                ;;
                
                Z ) # if second param is "win":
                    echo "${paper[win]}"
                ;;
                
            esac
        ;;
        
        C ) # if first param is "scissors":
            case "$2" in
                X ) # if second param is "lose":
                    echo "${scissors[lose]}"
                ;;
                
                Y ) # if second param is "draw":
                    echo "3"
                ;;
                
                Z ) # if the second param is "win":
                    echo "${scissors[win]}"
                ;;
            esac
        ;;
    esac
}

while read line; do
    opponentMoveChar=$(echo $line | awk '{print $1}')
    instructionChar=$(echo $line | awk '{print $2}')
    
    declare -i opponentMoveInt=$(convertMoveToInt $opponentMoveChar)
    declare -i myMoveInt=$(deriveMove $opponentMoveChar $instructionChar)
    
    declare -i diff=$(($opponentMoveInt-$myMoveInt))
    declare -i absDiff=$(abs $diff)
    
    echo $opponentMoveInt, $myMoveInt
    if [ "$myMoveInt" -eq "$opponentMoveInt" ]; then
        (( totalScore+=myMoveInt+3 ))
        elif [ $absDiff -eq 2 ] && [ "$myMoveInt" -gt "$opponentMoveInt" ]; then
        (( totalScore+=myMoveInt))
        elif [ $absDiff -eq 2 ] && [ "$opponentMoveInt" -gt "$myMoveInt" ]; then
        (( totalScore+=myMoveInt+6))
        elif [ $absDiff -eq 1 ] && [ "$opponentMoveInt" -gt "$myMoveInt" ]; then
        (( totalScore+=myMoveInt))
        elif [ $absDiff -eq 1 ] && [ "$myMoveInt" -gt "$opponentMoveInt" ]; then
        (( totalScore+=myMoveInt+6))
    fi
    
done < "$testInput"

echo ${totalScore}

# Solution = 13886
