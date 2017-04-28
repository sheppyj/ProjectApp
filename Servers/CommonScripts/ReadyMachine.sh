#!/bin/bash

#This script is going to update the Machines Operating system and install puppet

echo "Installing updates"
sudo yum -y update

echo "Update package repo with Puppet"
sudo rpm -ivh http://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm

echo "Installing puppet"
sudo yum -y puppet
