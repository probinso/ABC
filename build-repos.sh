#!/usr/bin/env bash

set -euo pipefail


if (( $# != 1)); then
    printf "Usage: %s <credentials.json>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;

USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')


TEAMS=$(cat ./teams.txt);


for team in $TEAMS do

    curl -i \
         -H "application/vnd.github.v3+json" \
         --user "${USER}:${PASS}" \
         --request POST \
         --data '{"name": "${team}","description": "ABC team ${team}","homepage": "https://github.com","private": false,"has_issues": true,"has_projects": true,"has_wiki": true}' \
         "https://api.github.com/orgs/PortlandDataScienceGroup/repos"
done;

./add-admins.sh ${cred_file}

./initialize-ssh.sh

git checkout master

for team in $TEAMS; do
    git push -u $team master
done
