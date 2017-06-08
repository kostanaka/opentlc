#!/usr/bin/bash
if [ $(whoami) != root ];then
	echo "you have to be root."
	exit 1
fi

PASS="r3dh4t1!"

expect -f - << EXPECT
spawn ssh-copy-id root@ansible1.example.com
expect "password: " {
	send "$PASS\r"
} "already exist" {
	exit 0
}

expect timeout {
       exit 1
} "added: 1" {
       exit 0
}
EXPECT
