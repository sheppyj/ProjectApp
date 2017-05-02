#!/bin/bash
if [ "$HOSTNAME" -eq appsvr1 ]
then
echo "My Hostname is appsvr1"
echo "Using port 8081"
cd /home/vagrant
go build app.go
nohup ./app $HOSTNAME 8081 &
else
echo "My Hostname is appsvr2"
echo "Using port 8082"
cd /home/vagrant
go build app.go
nohup ./app $HOSTNAME 8082 &
fi
