#!/bin/bash -x
echo "Welcome To Snake Ladder Game";
#CONSTANTS
NOPLAY=0;
LADDERPLAY=1;
SNAKEPLAY=2;
STARTPOINT=0;
ENDPOINT=100;
#VARIABLES
player1Position=0;
player2Position=0;
#flag=1 means first start with  player1
flag=1;
#Laddercheck for to continue same Player
ladderCheck=0;
playerPosition=0;
dieCounter=0;
#Dictionary
declare -A player1Storage;
declare -A player2Storage;
#This Loop Runs Until Player position Not reached upto Endpoint
	while :
	do
		#------This If for Multiplayer-----
		if [ $flag -eq 1 ]
		then
			playerPosition=$player1Position;

		else
			playerPosition=$player2Position;
		fi;
		#------Multiplayer Code End Here----

		# Dice Counter TO store How many Time We Rolled Die
		((dieCounter++));
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
				#LadderCheck to continue with Same Player
				ladderCheck=1;
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
		#-------This Code For multiplayer---------

		#I AM PLAYER1
		if [ $flag -eq 1 ]
		then
			#if ladder occured then same player Play again
			if [ $ladderCheck -eq 1 ]
			then
				ladderCheck=0;
				flag=1;
			else
				#Ladder Not Occured So Passing To other Player
				ladderCheck=0;
				flag=0;
			fi;
			#storing Player position
			player1Position=$playerPosition;
			player1Storage[ $playerPosition ]=$dieValue;

      else

			#I AM PLAYER 2
			if [ $ladderCheck -eq 1 ]
			then
			ladderCheck=0;
			flag=0;
			else
			ladderCheck=0;
			flag=1;
			fi;
			#Storing Position
         player2Position=$playerPosition;
			player2Storage[ $playerPosition ]=$dieValue;
	 	fi;
		#-----Multiplayer Code Ended Here--------------

		#FINAL Checking for Which player Reached 100 First
		if [ $player1Position -eq $ENDPOINT ] || [ $player2Position -eq $ENDPOINT ] 
		then
			#According To winner We Displaying Records
			if [ $player1Position -eq $ENDPOINT ]
			then
				echo "*****CONGRATS*****";
				printf "\n \n";
				echo "WINNER IS= PLAYER 1";
				printf "\n \n";
				echo "Dice Rolled count=" $dieCounter;
				printf "\n \n";
				for i in "${!player1Storage[@]}"
         	do
            	echo "Position  : $i"   "DICE Value: ${player1Storage[$i]}";
         	done

			else
				echo "*****CONGRATS*****";
				printf "\n \n";
				echo "WINNER IS= PLAYER 2";
				printf "\n \n";
				echo "Dice Rolled count=" $dieCounter;
				printf "\n \n";
				for i in "${!player2Storage[@]}"
         	do
            	echo "Position  : $i"   "DICE Value: ${player2Storage[$i]}";
         	done
			fi;

			break;
		fi;
	done
