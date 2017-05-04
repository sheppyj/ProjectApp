#!/bin/bash
#accept port number from vagrant script and pass to go application. Run application in the background 
echo "My Hostname is $HOSTNAME"
echo "Using port $1"
cd /home/vagrant/src
nohup ./app $1 &
