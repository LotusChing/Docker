#!/bin/bash
if [ -z $1 ];then
    USERNAME="admin"
    PASSWORD="admin"
else:
    USERNAME="$1"
    PASSWORD="$2"
fi

if [ ! -f /root/.init ];then
    python ankisyncctl.py inituser $USERNAME $PASSWORD
    echo "create initial user $1"
    python ankisyncctl.py lsuser
    touch /root/.init
fi
python -m ankisyncd
