#!/usr/bin/bash
if [ $(whoami) != root ];then
	echo "you have to be root."
	exit 1
fi
PASS="r3dh4t1!"
echo "copying key to ansible tower host."
expect -f - << EXPECT
spawn ssh-copy-id ansible1.example.com
expect "password:"
send $PASS
EXPECT
