#!/bin/bash

IFS='~' read -r -a VARIABLES <<< $((python3 env_setup.py) 2>&1)

for VARIABLE in "${VARIABLES[@]}"
do
    KEY=`echo $VARIABLE | cut -d, -f1`;
    VALUE=`echo $VARIABLE | cut -d, -f2`;
    export "$KEY"=$VALUE
done
