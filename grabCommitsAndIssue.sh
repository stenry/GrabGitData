#!/bin/bash


#TODO 添加下载重定向，假如在下载完某一个元信息之后出现网络故障，则能够重定向从后一个元信息开始下载

#$1为数据源目录

#定义一个极限值，我们认为github每个项目的issues永远达不到MAX_INF * 100
MAX_INF=20;
#定义一个下载的url变量，从starOver100.csv中获取
url=""
#设置下载目录，issue和commit可能会出现不同目录
downloadDir=$2
#设置下载的文件类型,如果为0，则下载issue，为1，则下载commit。
flag=$3
for proName in $(ls $1)
do
	starsCount=$(grep "\"stargazers_count\":" $1"/"$proName | cut -d ":" -f2 | cut -d "," -f1 | cut -d " " -f2)
	if [[ $starsCount -gt 100 ]]
	then
		commitUrl="https:"$(grep "\"commits_url\":" $1"/"$proName | cut -d ":" -f3 | cut -d "\"" -f1 | cut -d "{" -f1)
		issueUrl="https:"$(grep "\"issues_url\":" $1"/"$proName | cut -d ":" -f3 | cut -d "\"" -f1 | cut -d "{" -f1)
		if [[ $flag == 0 ]]
		then
			url=$issueUrl
		else
			url=$commitUrl
		fi
		
		#控制分页下载
		page=1
		while [[ $page != $MAX_INF ]]
		do
			count=0
			for line in $(curl $url"?page="$page"&per_page=100&client_id=0889f43bea10a28a0db7&client_secret=3052eb1050e4a35862f4c774a6103e40206f7c2f")
			do
				count=$(expr $count + 1)
			done
			echo "count is "$count"! page is "$page
			if [[ $count != 2 ]]
			then
				curl $url"?page="$page"&per_page=100&client_id=0889f43bea10a28a0db7&client_secret=3052eb1050e4a35862f4c774a6103e40206f7c2f" >> $downloadDir"/"$proName 
				page=$(expr $page + 1)
			else
				page=$MAX_INF
			fi 
		done
	fi
done
