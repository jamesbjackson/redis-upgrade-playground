#!/bin/bash

echo "Bootstrap ..."

sleep 10

until redis-cli --raw -p 6379 -h redis_master INFO | grep "role:master"> /dev/null; do
  >&2 echo "Redis Master is unavailable - sleeping..."
  sleep 10
done

echo "Redis Master is up ..."

sleep 15

echo "Writing data to Redis master..."
cat /tmp/data.txt | redis-cli -h redis_master -p 6379 --pipe