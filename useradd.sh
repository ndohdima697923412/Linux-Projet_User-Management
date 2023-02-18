#!/bin/bash
cut -d ";" -f  1 useradd.csv >username.txt
cut -d ";" -f  4 useradd.csv >comment.txt
cut -d ";" -f  5 useradd.csv >expiration.txt
cut -d ";" -f  6 useradd.csv >group.txt
i=1
while read line;
do
	x="$line"
	echo "$x" > line_user_add
	username=$(cut -d ";" -f 1 line_user_add)
	comment=$(cut -d ";" -f 4 line_user_add)
	expireDate=$(cut -d ";" -f 5 line_user_add) 
	group=$(cut -d ";" -f 3 line_user_add)
	sudo useradd -c "$comment" -e "$group" "$username"
	sudo usermod -aG "$group" "$username"

done < useradd.csv

