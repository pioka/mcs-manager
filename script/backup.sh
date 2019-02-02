#!/bin/bash
GAME_DIR=`dirname $0`/../game
BACKUP_DIR=$GAME_DIR/backup


# Is server running
if screen -list | grep -q 'mcs'; then
    screen -r mcs -X stuff "save-off\rsave-all\r"
    sleep 1
    tar zcf $BACKUP_DIR/world-`date '+%Y-%m%d-%H%M'`.tar.gz $GAME_DIR/world
    screen -r mcs -X stuff "save-on\r"
else
    tar zcf $BACKUP_DIR/world-`date '+%Y-%m%d-%H%M'`.tar.gz $GAME_DIR/world
fi
