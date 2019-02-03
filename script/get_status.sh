#!/bin/bash
if screen -list | grep -q 'mcs'; then
    echo ':green_heart: Server is running'
else
    echo ':black_heart: Server is stopped'
fi

