#! /bin/bash -x

stake_per_day=100
bet_per_game=1

win=1
lose=0

check=$((RANDOM%2))
if [ $check -eq $win ];
then
	echo "win $bet_per_game dollar"
else
	echo "lose $bet_per_game dollar"
fi