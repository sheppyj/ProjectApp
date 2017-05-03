#!/bin/bash
#install golang via script as some manual fudgery needs to occur
cd /home/vagrant
wget -q https://storage.googleapis.com/golang/go1.7.4.linux-amd64.tar.gz
sudo tar -xvf go1.7.4.linux-amd64.tar.gz
sudo mv go /usr/local/go
rm -rf go1.7.4.linux-amd64.tar.gz

export GOROOT=/usr/local/go
export GOPATH=$HOME
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

sudo apt-get update
sudo apt-get install -y git
cd /home/vagrant/src
go get
go build app.go
