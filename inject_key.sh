#!/usr/bin/bash
if [ $(whoami) != root ];then
	echo "you have to be root."
	exit 1
fi

PASS="r3dh4t1!"

expect -f - << EXPECT
spawn ssh-copy-id root@ansible1.example.com
proc proc_login {} {
  expect timeout {
    exit 1
  } "continue connecting (yes/no)? " {
    send "yes\r"
    proc_login
  } "password: " {
    send "$PASS\r"
    proc_login
  } "already exist" {
    exit 0
  } "added: 1" {
    exit 0
  }
}
proc_login
EXPECT
