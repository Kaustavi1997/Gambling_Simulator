#! /bin/bash 

stake_per_day=100
bet_rupees_per_game=1

win=1
lose=0

month_no=0

read -p "Percentage of Stake:" s;

a=$(echo "$s / 100" | bc -l );
percentage_amount_on_stake_per_day=$(echo "$a * $stake_per_day" | bc -l );
int_percentage_amount_on_stake_per_day=${percentage_amount_on_stake_per_day%.*}


lower_limit=$(($stake_per_day - $int_percentage_amount_on_stake_per_day))
upper_limit=$(($stake_per_day + $int_percentage_amount_on_stake_per_day))
while [ $1=1 ]
do
	month_no=$(($month_no+1))
	total_win=0
	total_lose=0
	for (( i=0; i<20; i++ ))
	do
		current_amount=$stake_per_day	
		while [ $current_amount -gt $lower_limit -a $current_amount -lt $upper_limit ]
		do
			check=$((RANDOM%2))
			if [ $check -eq $win ]
			then
				current_amount=$(($current_amount + $bet_rupees_per_game))
			else
				current_amount=$(($current_amount - $bet_rupees_per_game))
			fi
		done
		if [ $current_amount -gt $stake_per_day ]
		then
			win_amount_per_day=$(($current_amount - $stake_per_day))
			total_win=$(($total_win + $win_amount_per_day))
		else
			lose_amount_per_day=$(($stake_per_day-$current_amount))
			total_lose=$(($total_lose + $lose_amount_per_day))
		fi
	done
	echo $month_no
	echo $total_win
	echo $total_lose

	if [ $total_win -gt $total_lose ]
	then
		win_by=$(($total_win-$total_lose))
		echo "Total Amount won : $win_by"
		echo "Continue Playing"
		continue
	else
		lost_by=$(($total_lose-$total_win))
		echo "Total Amount lost : $lost_by"
		echo "Stop Playing"
		break
	fi
done

