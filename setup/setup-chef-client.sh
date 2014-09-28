#!/bin/bash

source ./setup.conf

CHEF_CLIENT_RPM=chef-11.14.6-1.el5.x86_64.rpm
if [ ! -f "$CHEF_CLIENT_RPM" ]; then
	wget -P $CACHE_DIR https://opscode-omnibus-packages.s3.amazonaws.com/el/5/x86_64/$CHEF_CLIENT_RPM
	sudo rpm -ivh $CACHE_DIR/$CHEF_CLIENT_RPM
fi

# get chef-repo
cd $WORKING_DIR
git clone git://github.com/opscode/chef-repo.git
