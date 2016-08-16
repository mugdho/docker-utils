#!/bin/bash

# This script expects the following ENV variables to be setup
# CONSUL_URL, APP, APP_ENV
# If no CONSUL_URL this script will assume that all the env variables are set
# through command line. We can tool this behavior as needed

# Set the CONSUL_TOKEN variable to default if one not provided. This means no acls have been set up.
# Always provide the READ ONLY ACL token here. NEVER the master token for consul.
if [ "$CONSUL_TOKEN" == "" ]
then
    CONSUL_TOKEN="default-token"
fi

if [ "$CONSUL_URL" != "" ]
then

  BASE_URL="${CONSUL_URL}/v1/kv"
  BASE_KEY="${APP}/${APP_ENV}"
  APP_URL="${BASE_URL}/${BASE_KEY}"
  KEYS_URL="${APP_URL}/?keys&token=$CONSUL_TOKEN"

  KEYS=( $( curl $KEYS_URL 2> /dev/null| jq --raw-output ".[]" ) )

  for KEY in "${KEYS[@]}"
  do
    if [ $KEY != "${BASE_KEY}/" ]
    then
      VALUE=$( curl "$BASE_URL/${KEY}?raw&token=$CONSUL_TOKEN" 2> /dev/null )
      KEY=${KEY/#$BASE_KEY\//}
      export "$KEY"="$VALUE"
    fi
  done
fi
