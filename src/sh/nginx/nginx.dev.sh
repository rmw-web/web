#!/usr/bin/env bash
set -e

ROOT=$(cd "$(dirname "$0")"; pwd)
cd $ROOT
npx coffee ./nginx.dev.coffee
./acme.sh || echo ''
systemctl force-reload nginx
