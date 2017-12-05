#!/usr/bin/env bash

set -euo pipefail


git checkout master

for color in $(cat ./teams.txt);
do
    git push -u ${color} master
done;
