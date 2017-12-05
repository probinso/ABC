#!/usr/bin/env bash

set -euo pipefail

for color in $(cat teams.txt);
do
    git fetch ${color} master
done;
