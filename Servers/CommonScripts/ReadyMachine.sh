#!/bin/bash

#This script is going to update the Machines Operating system and install puppet

echo "Installing updates"
sudo apt-get -y update

echo "Installing puppet"
sudo apt-get install -y puppet
