#!/usr/bin/env bash

set -euo pipefail

if (( $# != 1)); then
    printf "Usage: %s credentials.json\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;

USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')
ORG=$(cat ${cred_file} | jq --raw-output '.organization')


for team in $(cat ./teams.txt); do
    for admin in $(cat ./admins.txt); do
        curl -i \
             -H "application/vnd.github.v3+json" \
             --user "${USER}:${PASS}" \
             --request PUT \
             --data '{"permission":"admin"}' \
             "https://api.github.com/repos/${ORG}/${team}/collaborators/${admin}"
    done;
done;
