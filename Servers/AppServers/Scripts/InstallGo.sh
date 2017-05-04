#!/bin/bash
#install golang via script as some manual fudgery needs to occur
#go to home dir so I know where I am
cd /home/vagrant
#get the latest version of the golang binaries, using apt-get installs 1.2.1 which I can't use with mgo
wget -q https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
#unpack and cleanup
sudo tar -xvf go1.7.4.linux-amd64.tar.gz
sudo mv go /usr/local/go
rm -rf go1.7.4.linux-amd64.tar.gz

#create environmental variables for use later
export GOROOT=/usr/local/go
export GOPATH=$HOME
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

#update and install git (required for go get to install mgo) compile my go application
sudo apt-get update
sudo apt-get install -y git
cd /home/vagrant/src
go get
go build app.go
