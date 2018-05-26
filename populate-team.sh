#!/usr/bin/env bash

set -euo pipefail

if (( $# != 2)); then
    printf "Usage: %s <credentials.json> <teams.txt>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;
TEAMS=$2;

USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')
ORG=$(cat ${cred_file} | jq --raw-output '.organization')

for team in $(cat $TEAMS); do
    for uname in $(cat ${team}.txt); do
        sleep 1;
        curl -i \
             -H "application/vnd.github.v3+json" \
             --user "${USER}:${PASS}" \
             --request PUT \
             --data '{"permission":"push"}' \
             "https://api.github.com/repos/${ORG}/${team}/collaborators/${uname}"
    done;
done;
