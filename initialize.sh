#!/usr/bin/env bash

set -euo pipefail

if (( $# != 2)); then
    printf "Usage: %s <credentials.json> <teams.txt>\n" "$0" >&2;
    exit 1;
fi;

ORG=$(cat ${cred_file} | jq --raw-output '.organization')
TEAMS=$2

for name in $(cat ${TEAMS});
do
    git remote add ${name} https://github.com/${ORG}/${name}.git
done;
