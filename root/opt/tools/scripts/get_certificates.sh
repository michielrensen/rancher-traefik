#!/bin/sh

JQ=${JQ:-/opt/tools/scripts/jq}
CERTPATH=${CERTPATH:-/opt/traefik/certs}

IFS=$'\n' CERTS=($(curl -u "${CATTLE_ACCESS_KEY}:${CATTLE_SECRET_KEY}") "${CATTLE_URL}"/projects/"${PROJECT_ID}/certificates" | $JQ -r '.data[] | .cert' ))

for ((i = 0; i < "${#CERTS[@]}"; ++i)); do
  echo "${CERTS[$i]}" >> "${CERTPATH}"/certs.cert.pem
done
