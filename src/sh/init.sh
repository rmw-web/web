#!/usr/bin/env bash
export DEV_SH=~/.config/dev.sh
[ -d "$DEV_SH" ] || git clone --depth=1 git@gitee.com:xsee/dev.sh.git $DEV_SH
. $DEV_SH/init.sh

print() {
   echo -e "⚡ \033[33m$1\033[0m"
}

if [ ! -x "$_DIR/src/config" ]; then
CONFIG_NAME=config.dev
CONFIG_GIT=$(npx -q gitsrc|awk '{print substr($1,0,length($1)-4)}').$CONFIG_NAME.git
echo "git clone ""$CONFIG_GIT"
cd $_DIR/src
if [ ! -d "$CONFIG_NAME" ]; then
git clone $CONFIG_GIT $CONFIG_NAME
fi
ln -s $CONFIG_NAME config
fi

cd $_DIR

if [ ! \( -e "./file/font" \) ]; then
  mkdir -p file
  cd file
  git clone git@e.coding.net:renwu/font.git --depth=1
  cd $_DIR/src
  if [ ! \( -e "./file" \) ]; then
    ln -s ../file .
  fi
fi

cd $_DIR
