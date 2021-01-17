#!/usr/bin/env bash

set -e
DIR=$( dirname $(realpath "$0") )
cd $DIR/../..

npx coffee -m --compile --output lib src/
rsync -av --include='*/' --include='*.js' --include='*.mjs' --exclude=* src/ lib/
.direnv/bin/coffee ${!#}

