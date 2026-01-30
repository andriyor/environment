#!/bin/bash
HOST="raspberrypi.local"
ping -c 1 -W 1 $HOST > /dev/null
if [ $? -eq 0 ]; then
  echo "🟢"
else
  echo "🔴"
fi
