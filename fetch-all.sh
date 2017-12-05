#!/usr/bin/env bash

for color in $(cat teams.txt);
do
    git fetch ${color} master
done;
