#!/bin/bash
#set -euo pipefail

mv /tmp/cassandra.yaml /etc/cassandra/cassandra.yaml
sudo systemctl restart cassandra
sleep 60

# Check that Cassandra service is running
while : ; do
    netstat -tulpn | grep 9042
    if [ $? -eq 0 ]; then
        echo "OK! Cassandra service is running!"
        break
    else
        echo "FAILURE! Cassandra service is not running! Restarting ..."
        sudo systemctl restart cassandra
        sleep $(shuf -i 60-120 -n 1)
    fi
done
