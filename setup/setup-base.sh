#!/bin/bash

source ./setup.conf

EPEL_RPM=epel-release-5-4.noarch.rpm
if [ ! -f "$CACHE_DIR/$EPEL_RPM" ]; then
	wget -P $CACHE_DIR http://download.fedoraproject.org/pub/epel/5/x86_64/$EPEL_RPM
	sudo rpm -ivh $CACHE_DIR/$EPEL_RPM
fi

RPMFORGE_RPM=rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
if [ ! -f "$CACHE_DIR/$RPMFORGE_RPM" ]; then
	wget -P $CACHE_DIR http://packages.sw.be/rpmforge-release/$RPMFORGE_RPM
	sudo rpm -ivh $CACHE_DIR/$RPMFORGE_RPM
fi

REMI_RPM=remi-release-5.rpm
if [ ! -f "$CACHE_DIR/$REMI_RPM" ]; then
	wget -P $CACHE_DIR http://rpms.famillecollet.com/enterprise/$REMI_RPM
	sudo rpm -ivh $CACHE_DIR/$REMI_RPM
fi

IUS_RPM=ius-release-1.0-13.ius.centos5.noarch.rpm
if [ ! -f "$CACHE_DIR/$IUS_RPM" ]; then
	wget -P $CACHE_DIR http://dl.iuscommunity.org/pub/ius/stable/CentOS/5/x86_64/$IUS_RPM
	sudo rpm -ivh $CACHE_DIR/$IUS_RPM
fi

if [ -d "$CONFIG_DIR" ]; then
	cp -f $CONFIG_DIR/bashrc ~/.bashrc
	cp -f $CONFIG_DIR/bash_profile ~/.bash_profile
fi

# install the best arch for this platform, only
grep -q "multilib_policy" /etc/yum.conf
if [ $? -eq 0 ]; then
	sudo sed -i -r 's/(multilib_policy=).*/\1best/' /etc/yum.conf
else
	sudo echo "multilib_policy=best" >>/etc/yum.conf
fi

sudo yum --enablerepo=remi --enablerepo=epel install git

# restart 
exec $SHELL -l
