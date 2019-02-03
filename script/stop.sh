#!/bin/bash
if screen -list | grep -q 'mcs'; then
    screen -r mcs -X stuff "stop\r"
    echo ':sleeping_accommodation: Stopping server...'

else
    echo ':speech_balloon: Nothing to do'
fi

