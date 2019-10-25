#!/usr/bin/env sh

set -e

webpack-cli \
  --mode production \
  --config webpack.config.js
