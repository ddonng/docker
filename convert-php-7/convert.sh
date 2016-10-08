#!/bin/bash

if [ -z "$2" ]; then
    echo "Must pass file";
    exit 10;
fi
/usr/bin/unoconv --server localhost --port 20002 --output $1 -f pdf $2 
