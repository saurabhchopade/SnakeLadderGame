#!/bin/bash -x
echo "Welcome To Snake Ladder Game";
#CONSTANTS
NOPLAY=0;
LADDERPLAY=1;
SNAKEPLAY=2;
STARTPOINT=0;
ENDPOINT=100;
#VARIABLES
playerPosition=0;
#This Loop Runs Until Player position Not reached upto Endpoint
	while :
	do
		dieValue=$((RANDOM%6 + 1));
		playValue=$((RANDOM%3));
		
		if [ $playValue -eq $NOPLAY ]
		then
			#This is NoPlay Condition
			playerPosition=$playerPosition;

		elif [ $playValue -eq $LADDERPLAY ]
		then
			#This Is Ladder Play
			#exact Hundred condition is here by help of checkend
			checkEnd=$playerPosition;
			playerPosition=$(( $playerPosition + $dieValue ));
			if [ $playerPosition -gt $ENDPOINT ]
			then
				playerPosition=$checkEnd;
			fi;

		else
			#This is Snake Play Here
			playerPosition=$(( $playerPosition - $dieValue ));
			if [ $playerPosition -le $STARTPOINT ]
			then
				playerPosition=$STARTPOINT;
			fi;
		fi;
		#Checking Player Position Reached or Not
		if [ $playerPosition -eq $ENDPOINT ]
		then
			echo "Player Won The GAME";
			break;
		fi;
	done
