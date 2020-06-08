#! /bin/bash 

arr=()
stake_per_day=100
bet_rupees_per_game=1

win=1
lose=0

read -p "Percentage of Stake:" s;

a=$(echo "$s / 100" | bc -l );
percentage_amount_on_stake_per_day=$(echo "$a * $stake_per_day" | bc -l );
int_percentage_amount_on_stake_per_day=${percentage_amount_on_stake_per_day%.*}


lower_limit=$(($stake_per_day - $int_percentage_amount_on_stake_per_day))
upper_limit=$(($stake_per_day + $int_percentage_amount_on_stake_per_day))
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
	arr+=($current_amount)
	# if [ $current_amount -gt $stake_per_day ]
	# then
	# 	win_amount_per_day=$(($current_amount - $stake_per_day))
	# 	arr+=($win_amount_per_day)
	# else
	# 	lose_amount_per_day=$(($current_amount-$stake_per_day))
	# 	arr+=($lose_amount_per_day)
	# fi
done
for (( i=0; i<20; i++ ))
do
	echo "Day $(($i+1)) : ${arr[$i]}"
done

