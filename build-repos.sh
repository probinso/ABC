#!/usr/bin/env bash

set -euo pipefail


if (( $# != 3)); then
    printf "Usage: %s <credentials.json> <teams.txt> <admins.txt>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;
TEAMS=$2
ADMINS=$3

USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')
ORG=$(cat ${cred_file} | jq --raw-output '.organization')


for team in $(cat $TEAMS); do
    echo ${team}
    echo curl -i \
         -H "application/vnd.github.v3+json" \
         --user "${USER}:${PASS}" \
         --request POST \
         --data '{"name": "${team}","description": "ABC team ${team}","homepage": "https://github.com","private": false,"has_issues": true,"has_projects": true,"has_wiki": true}' \
         "https://api.github.com/orgs/${ORG}/repos"
done;
exit

./add-admins.sh ${cred_file} ${TEAMS} ${ADMINS}

./initialize-ssh.sh ${cred_file} ${TEAMS}

git checkout master

for team in $TEAMS; do
    git push -u $team master
done
