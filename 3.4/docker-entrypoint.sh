#!/bin/bash

#enable job control in script
set -e -m

#####   variables  #####
: ${ZOO_ID:=1}

# add command if needed
if [ "${1:0:1}" = '-' ]; then
  set -- zkServer.sh "$@"
fi

#run command in background
if [ "$1" = 'zkServer.sh' ]; then
  ##### pre scripts  #####
  echo "========================================================================"
  echo "initialize:"
  echo "========================================================================"
  mkdir -p /var/lib/zookeeper && echo "${ZOO_ID}" > /var/lib/zookeeper/myid

  
  ##### run scripts  #####
  echo "========================================================================"
  echo "startup:"
  echo "========================================================================"
  exec "$@" &

  ##### post scripts #####
  echo "========================================================================"
  echo "configure:"
  echo "========================================================================"
  
  #bring command to foreground
  fg
else
  exec "$@"
fi
