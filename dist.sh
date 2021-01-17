#!/usr/bin/env bash

. `dirname $0`/src/sh/pre.sh

git pull origin master

yarn

echo "yes"|NODE_ENV=production npx webpack

npx coffee ./src/sh/dist.coffee

mv dist/index.html dist/index.html.bak
mv dist/index.htm dist/index.html

DIST=/var/www/`coffee -e 'console.log require("./src/config/host")'`/

echo $DIST

mkdir -p $DIST

rsync -av dist/ $DIST

npx coffee $_DIR/src/sh/upyun/upyun.coffee
