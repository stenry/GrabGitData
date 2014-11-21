#!/bin/bash

for filename in $(ls $1)
do
	echo $1"/"$filename
	starsCount=$(grep "\"stargazers_count\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
	if [[ $starsCount -gt 100 ]]
	then
		forkCount=$(grep "\"forks_count\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
		decription=$filename"+"$(grep "\"description\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d "\"" -f2)
		createTime=$(grep "\"created_at\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d "\"" -f2)
		updateTime=$(grep "\"updated_at\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d "\"" -f2)
		pushTime=$(grep "\"pushed_at\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d "\"" -f2)
		cloneUrl="https:"$(grep "\"clone_url\":" $1"/"$filename | cut -d ":" -f3 | cut -d "\"" -f1)
		commitUrl="https:"$(grep "\"commits_url\":" $1"/"$filename | cut -d ":" -f3 | cut -d "\"" -f1 | cut -d "{" -f1)
		issueUrl="https:"$(grep "\"issues_url\":" $1"/"$filename | cut -d ":" -f3 | cut -d "\"" -f1 | cut -d "{" -f1)
		echo $filename","$starsCount","$forkCount","$decription","$createTime","$updateTime","$pushTime","$cloneUrl","$commitUrl","$issueUrl >> starOver100.csv
#	else
#		echo $filename >> $2/$stars_count
	fi
#	forks_count=$(grep "\"forks\":" $1"/"$filename | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
#	if [[ $forks_count -gt 100 ]]
#	then
#		echo $filename >> $3"/over100"
#	else
#		echo $filename >> $3/$forks_count
#	fi
done
