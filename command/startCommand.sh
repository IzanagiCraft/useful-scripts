#!/bin/bash

# Check if ./start.sh exists and is executable
if [ -x "./start.sh" ]; then
    ./start.sh
# Check if ./start exists and is executable
elif [ -x "./start" ]; then
    ./start
else
    echo "Error: Neither './start.sh' nor './start' found or not executable."
    exit 1
fi

