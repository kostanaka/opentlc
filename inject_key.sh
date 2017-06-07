#!/usr/bin/bash
#
if [ -n $PASS ]; then
    echo PASSWORD /dev/tty
    echo $PASS
    exit 0
fi

export PASS='r3dh4t1!'
export SSH_ASKPASS=$0

ssh-copy-id -i /root/.ssh/id_rsa.pub ansible1.example.com
