#!/usr/bin/env bash

. `dirname $0`/src/sh/init.sh

. $DEV_SH/pid.sh

NODE_ENV=development exec npx webpack serve
