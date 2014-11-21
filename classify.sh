#!/bin/bash

for filename in $(ls $1)
do
	echo $1"/"$filename
	stars_count=$(grep "\"stargazers_count\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
	if [[ $stars_count -gt 100 ]]
	then  
		echo $filename >> $2"/over100"
	else
		echo $filename >> $2/$stars_count
	fi
	forks_count=$(grep "\"forks\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
	if [[ $forks_count -gt 100 ]]
	then
		echo $filename >> $3"/over100"
	else
		echo $filename >> $3/$forks_count
	fi
done
