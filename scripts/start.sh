#!/usr/bin/env sh

set -e

nodemon --watch src --exec ts-node src/index.ts
