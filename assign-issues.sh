#!/usr/bin/env bash

set -euo pipefail

if (( $# != 3)); then
    printf "Usage: %s credentials.json <teams.txt> <issues.txt>\n" "$0" >&2;
    exit 1;
fi;

cred_file=$1;
USER=$(cat ${cred_file} | jq --raw-output '.username')
PASS=$(cat ${cred_file} | jq --raw-output '.password')
ORG=$(cat ${cred_file} | jq --raw-output '.organization')

TEAMS=$2;
ISSUES=$3;

ORIGIN=$(git remote -v | grep origin | head -n 1 | awk '{print $2}')
SUBURL=${ORIGIN#*:}
SUPURL=$(echo ${ORIGIN} | awk -F[@:] '{print $2}')
URL="https://${SUPURL}/${SUBURL}/raw/speaker/images/"

TEMPLATE="{
  'title': 'Incorperate KEY',
  'body': '${URL}KEY',
  'assignees': [
    'USER'
  ],
  'labels': [
    'feature'
  ]
}"

for team in $(cat ${TEAMS}); do
    for uname in $(cat "${team}.txt"); do
        issue=B.png
        ls images/ | sort -R | tail -3 | while read issue; do
            DATA=$(echo ${TEMPLATE} | sed s/USER/${uname}/g | sed s/KEY/${issue}/g)
            echo curl -i \
                 -H "application/vnd.github.v3+json" \
                 --user "${USER}:${PASS}" \
                 --request POST \
                 --data \"${DATA}\" \
                 "https://api.github.com/repos/${ORG}/${team}/issues"
        done
    done
done
