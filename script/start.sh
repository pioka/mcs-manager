#!/bin/sh
GAME_DIR=`dirname $0`/../game
if ! screen -list | grep -q 'mcs'; then
    pushd $GAME_DIR > /dev/null
    screen -mdS mcs java -jar -Xms1G -Xmx3G -d64 $GAME_DIR/server.jar nogui
    popd > /dev/null

    echo ':rocket: Starting server...'
else
    echo ':speech_balloon: Nothing to do'
fi
