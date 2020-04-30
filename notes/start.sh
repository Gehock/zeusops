#!/usr/bin/bash

set -x
set -e

NAME=main
PROFILE=server
PORT=2302
#CONFIGPATH=server-handling/config/$NAME.cfg
CONFIGLINK=configlink
CONFIGPATH=$CONFIGLINK\\config\\main.cfg
BASICPATH=$CONFIGLINK\\basic\\basic.cfg
PARAMS=
SERVERMODS=
SERVERPATH=arma3
BASEPATH=$HOME
BIN=$BASEPATH/files/bin


pushd $SERVERPATH > /dev/null
MODS="-mod="
for x in mods/$NAME/*; do
  MODS=${MODS}\;$x
done
popd > /dev/null

. $BIN/internal/keys.sh $BASEPATH $NAME

update_mods.sh optional --skipdl
update_mods.sh main --skipdl

echo "Launching with mods: $MODS"

$SERVERPATH/arma3server_x64 \
  -name=$PROFILE \
  -config=$CONFIGPATH \
  -cfg=$BASICPATH \
  -port=$PORT \
  -filePatching \
  -checkSignatures \
  $MODS $SERVERMODS $PARAMS
