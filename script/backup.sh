#!/bin/bash
GAME_DIR=`dirname $0`/../game
BACKUP_DIRNAME=backups

mkdir -p $GAME_DIR/$BACKUP_DIRNAME
pushd $GAME_DIR > /dev/null

# Is server running
if screen -list | grep -q 'mcs'; then
    screen -r mcs -X stuff "save-off\rsave-all\r"
    sleep 1
    tar -zcf $BACKUP_DIRNAME/bu-`date '+%Y-%m%d-%H%M'`.tar.gz world 
    screen -r mcs -X stuff "save-on\r"

else
    tar -zcf $BACKUP_DIRNAME/bu-`date '+%Y-%m%d-%H%M'`.tar.gz world
fi

popd > /dev/null

