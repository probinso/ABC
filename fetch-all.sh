#!/usr/bin/env bash

for color in yellow orange white pink purple blue green brown black;
do
    git fetch ${color} master
done;
