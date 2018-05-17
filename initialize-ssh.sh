#!/usr/bin/env bash

set -euo pipefail

if (( $# != 2)); then
    printf "Usage: %s <credentials.json> <teams.txt>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1
TEAMS=$2

ORG=$(cat ${cred_file} | jq --raw-output '.organization')

for name in $(cat ${TEAMS});
do
    git remote add ${name} git@github.com:${ORG}/${name}.git
done;
