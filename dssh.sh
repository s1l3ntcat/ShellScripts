#!/usr/bin/env bash

# @Author: S. Sharma <silentcat>
# @Date:   2019-04-23T07:17:10-05:00
# @Email:  silentcat@protonmail.com
# @Last modified by:   silentcat
# @Last modified time: 2019-04-23T21:56:04-05:00


if [[ $1 == "" ]]
then
	echo "Argument required: name of droplet."
	exit
fi

port=22
username=$USER
get_port=0
get_uname=0


for i in "$@"
do
	if [[ $get_port -eq 1 ]]
	then
		port=$i
		get_port=0
	elif [[ $get_uname -eq 1 ]]
	then
		username=$i
		get_uname=0
	elif [[ $i == "-p" ]]
	then
		get_port=1
	elif [[ $i == "-u" ]]
	then
		get_uname=1
	fi
done

name=$(doctl compute droplet list | grep "$1" | awk '{ print $3 }')

if [[ $name == "" ]]
then
	echo "No droplet with name found."
	exit
fi

ssh ${username}@${name} -p $port
