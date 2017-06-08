#!/usr/bin/bash
if [ $(whoami) != root ];then
	echo "you have to be root."
	exit 1
fi

PASS="r3dh4t1!"

expect -f - << EXPECT
spawn ssh-copy-id root@ansible1.example.com
expect "password: "
send "$PASS\r"
expect "added: 1"
EXPECT
