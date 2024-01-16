#!/usr/bin/env bash
set -euo pipefail
hash=$(echo -n "$1" | md5sum | awk '{print $1}')
curl -s "https://www.gravatar.com/avatar/$hash?s=1024" > ~/.face
