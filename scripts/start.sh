#!/usr/bin/env bash

set -e

nodemon --watch src --exec ts-node src/index.ts
