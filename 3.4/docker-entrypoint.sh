#!/bin/bash

#enable job control in script
set -e -m

#####   variables  #####
: ${ZOOKEEPER_ID:=1}

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
  mkdir -p /var/lib/zookeeper && echo "${ZOOKEEPER_ID}" > /var/lib/zookeeper/myid
  for VAR in `env`; do
    if [[ $VAR =~ ^ZOOKEEPER_SERVER_[0-9]+= ]]; then
      SERVER_ID=`echo "$VAR" | sed -r "s/ZOOKEEPER_SERVER_(.*)=.*/\1/"`
      SERVER_IP=`echo "$VAR" | sed 's/.*=//'`
      if [ "${SERVER_ID}" = "${ZOOKEEPER_ID}" ]; then
        echo "server.${SERVER_ID}=0.0.0.0:2888:3888" >> /etc/zookeeper/conf/zoo.cfg
        echo "server.${SERVER_ID}=0.0.0.0:2888:3888"
      else
        echo "server.${SERVER_ID}=${SERVER_IP}:2888:3888" >> /etc/zookeeper/conf/zoo.cfg
        echo "server.${SERVER_ID}=${SERVER_IP}:2888:3888"
      fi
    fi
  done

  cat /etc/zookeeper/conf/zoo.cfg
  
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
