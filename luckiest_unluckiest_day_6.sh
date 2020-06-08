#! /bin/bash 
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

total_diff_amount_till_now=0
max_current_diff_amount=-10000
min_current_diff_amount=10000
luckiest_day=0
unluckiest_day=0
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
	diff=$(($current_amount-$stake_per_day))
	total_diff_amount_till_now=$(($total_diff_amount_till_now+$diff))
	if [ $total_diff_amount_till_now -gt $max_current_diff_amount ]
	then
		max_current_diff_amount=$total_diff_amount_till_now
		luckiest_day=$i
	fi
	if [ $total_diff_amount_till_now -lt $min_current_diff_amount ]
	then
		min_current_diff_amount=$total_diff_amount_till_now
		unluckiest_day=$i
	fi
done
echo "luckiest_day : $luckiest_day  Amount : $max_current_diff_amount"
echo "unluckiest_day : $unluckiest_day  Amount : $min_current_diff_amount"
