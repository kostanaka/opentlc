#!/usr/bin/bash
if [ $(whoami) != root ];then
	echo "you have to be root."
	exit 1
fi
echo "copying key to ansible tower host."
ssh-copy-id ansible1.example.com
