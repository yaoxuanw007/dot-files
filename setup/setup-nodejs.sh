#!/bin/bash

sudo curl -sL https://rpm.nodesource.com/setup | sudo bash -
sudo yum install -y nodejs

# install build tools
sudo yum groupinstall 'Development Tools'
