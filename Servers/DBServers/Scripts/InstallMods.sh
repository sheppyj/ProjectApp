#!/bin/bash

#Install mongodb puppet module

echo "Installing mongoDB puppet module"
sudo puppet module install puppetlabs-mongodb --version 0.17.0

echo "Installing saz-sudo"
sudo puppet module install saz-sudo
