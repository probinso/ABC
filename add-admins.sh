#!/usr/bin/env bash

set -euo pipefail

if (( $# != 3)); then
    printf "Usage: %s credentials.json <teams.txt> <admins.txt>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;
TEAMS=$2;
ADMINS=$3;

USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')
ORG=$(cat ${cred_file} | jq --raw-output '.organization')

for team in $(cat ${TEAMS}); do
    sleep 1;
    for admin in $(cat ${ADMINS}); do
        sleep 1;
        curl -i \
             -H "application/vnd.github.v3+json" \
             --user "${USER}:${PASS}" \
             --request PUT \
             --data '{"permission":"admin"}' \
             "https://api.github.com/repos/${ORG}/${team}/collaborators/${admin}"
    done;
done;
