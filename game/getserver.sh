#!/bin/bash
LIST_URL='http://launchermeta.mojang.com/mc/game/version_manifest.json'

echo -ne "Server version ?\n> "
read VERSION

MANIFEST_URL=`curl $LIST_URL | jq -r ".versions[] | select(.id==\"$VERSION\") .url"`
JAR_URL=`curl $MANIFEST_URL | jq -r ".downloads .server .url"`
wget $JAR_URL server.jar
