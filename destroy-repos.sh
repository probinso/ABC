#!/usr/bin/env bash

set -euo pipefail

if (( $# != 2)); then
    printf "Usage: %s <credentials.json> <teams.txt>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;
TEAMS=$2

USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')
ORG=$(cat ${cred_file} | jq --raw-output '.organization')

if [ ! -f token.json ]; then
   sleep 1;
   curl -v --user ${USER}:${PASS} -X POST https://api.github.com/authorizations -d '{"scopes":["delete_repo"], "note":"token with delete repo scope"}' > token.json
fi;

TOKEN=$(cat token.json | jq --raw-output ".token")

for team in $(cat $TEAMS); do
    sleep 1;
    curl -X DELETE -H "Authorization: token ${TOKEN}" https://api.github.com/repos/${ORG}/${team}
    git remote rm $team
done;
