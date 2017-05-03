#!/bin/bash

#Install apache puppet module

echo "Installing apache puppet module"
sudo puppet module install puppetlabs-apache --version 1.11.0

echo "Installing saz-sudo puppet module"
sudo puppet module install saz-sudo
