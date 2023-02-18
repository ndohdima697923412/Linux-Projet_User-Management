#!/bin/bash
chmod -R +rwx /partage
ls /home > userarchive
while read line;
do 
	if [ -S /partage/"$line".tar.gz ]
	then 
		rm -f /partage/"$line".tar.gz
	fi
	tar -czvf /partage/"$line".tar.gz /home/"$line"
done < userarchive
