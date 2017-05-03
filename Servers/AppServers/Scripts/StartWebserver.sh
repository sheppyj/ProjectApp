#!/bin/bash
echo "My Hostname is $HOSTNAME"
echo "Using port $1"
cd /home/vagrant/src
nohup ./app $1 &
