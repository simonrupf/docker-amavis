#!/bin/sh

(
while true; do
  sa-update -v
  sleep 30h
done
) &
BACKGROUND_TASKS="$!"

amavisd foreground &
BACKGROUND_TASKS="${BACKGROUND_TASKS} $!"

while true; do
  for bg_task in ${BACKGROUND_TASKS}; do
    if ! kill -0 ${bg_task} 1>&2; then
      echo "Worker ${bg_task} died, stopping container waiting for respawn..."
      kill -TERM 1
    fi
    sleep 10
  done
done
