#!/bin/bash

# usage: bash GetMetaInfo.sh [src_file]

# $# means the number of arguments passed to the command
if [ $# -ne 1 ]
then
    echo "Usage: $0 src_file";
    exit 1;
fi

# To check if src_folder or dest_folder exists
# symbolic link is not considered.....
if [ ! -f "$1" ]
then
    echo "Wrong From Directory Route: $1";
    exit 2;
fi

read -n 1 -p "Your command means to download meta info according to the urls in $1.
Press any key to continue or ctrl c to quit."

#countStart=1
#count=$countStart
#countEnd=5000

#countStart=5001
#count=$countStart
#countEnd=6837

countStart=1
countEnd=200

for url in $(sed -n "${countStart}, ${countEnd}p" $1)
do
    echo "Downloading ---------------------------------------- $count"
    echo $(echo "$url" | awk 'BEGIN{FS = "/"} {print $6}') 
    curl $url > $(echo "$url" | awk 'BEGIN{FS = "/"} {print $6}') 
    echo "Downloading ---------------------------------------- $count finished"

    #limit rate
    if [[ $count -eq $countEnd ]]
    then
        exit 0
    fi
    count=$(expr $count + 1)

    echo "--------------------------------------------------------"
done
