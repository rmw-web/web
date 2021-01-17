#!/usr/bin/env bash
set -e

ROOT=$(cd "$(dirname "$0")"; pwd)
cd $ROOT

if [ -n "$1" ]; then
  HOST=$1
else
  HOST=`coffee -e 'console.log require("../../config/host")'`
fi

source ~/.config/dns.sh

reloadcmd="sudo systemctl force-reload nginx"

acme=$HOME/.acme.sh/acme.sh

if [ ! -x "$acme" ]; then
curl https://get.acme.sh | sh
fi


if [ -f "$HOME/.acme.sh/$HOST/fullchain.cer" ]; then
echo "更新 $HOST"
$acme --use-wget --renew -d $HOST -d *.$HOST --log --reloadcmd "$reloadcmd"
#$acme --use-wget --force --renew -d $HOST -d *.$HOST --log --reloadcmd "$reloadcmd"
else
echo "创建 $HOST"
$acme --use-wget --issue --dns $DNS -d $HOST -d *.$HOST --force --log --reloadcmd "$reloadcmd"
chgrp www  ~/.acme.sh/ -R
chmod g+rx ~/.acme.sh/
chmod g+rx ~/.acme.sh/$HOST
chmod g+r ~/.acme.sh/$HOST/*
fi
