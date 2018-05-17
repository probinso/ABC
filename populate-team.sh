#!/usr/bin/env bash

set -euo pipefail

if (( $# != 3)); then
    printf "Usage: %s <credentials.json> <teamname> <userlist.txt>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;
team=$2;
ifname=$3;

USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')
ORG=$(cat ${cred_file} | jq --raw-output '.organization')

for uname in $(cat ${ifname}); do
    curl -i \
         -H "application/vnd.github.v3+json" \
         --user "${USER}:${PASS}" \
         --request PUT \
         --data '{"permission":"push"}' \
         "https://api.github.com/repos/${ORG}/${team}/collaborators/${uname}"
done;
