#!/bin/bash

if [ -z "$1" ]; then
    echo "Must pass file";
    exit 10;
fi
/usr/bin/unoconv --server localhost --port 20002 -f pdf $1
