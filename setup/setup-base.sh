#!/bin/bash

source $(dirname $0)/setup.conf

if [ "$DISTRIBUTION" = "CentOS" ]; then
  if [ "$RELEASE" = "5" ]; then
    EPEL_RPM=epel-release-5-4.noarch.rpm
    EPEL_RPM_URL=http://download.fedoraproject.org/pub/epel/5/x86_64/$EPEL_RPM

    RPMFORGE_RPM=rpmforge-release-0.5.2-2.el5.rf.x86_64.rpm
    RPMFORGE_RPM_URL=http://packages.sw.be/rpmforge-release/$RPMFORGE_RPM

    REMI_RPM=remi-release-5.rpm
    REMI_RPM_URL=http://rpms.famillecollet.com/enterprise/$REMI_RPM

    IUS_RPM=ius-release-1.0-13.ius.centos5.noarch.rpm
    IUS_RPM_URL=http://dl.iuscommunity.org/pub/ius/stable/CentOS/5/x86_64/$IUS_RPM
  elif [ "$RELEASE" = "6" ]; then
    EPEL_RPM=epel-release-6-8.noarch.rpm
    EPEL_RPM_URL=http://dl.fedoraproject.org/pub/epel/6/x86_64/$EPEL_RPM

    RPMFORGE_RPM=rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm
    RPMFORGE_RPM_URL=http://packages.sw.be/rpmforge-release/$RPMFORGE_RPM

    REMI_RPM=remi-release-6.rpm
    REMI_RPM_URL=http://rpms.famillecollet.com/enterprise/$REMI_RPM

    IUS_RPM=ius-release-1.0-13.ius.centos6.noarch.rpm
    IUS_RPM_URL=http://dl.iuscommunity.org/pub/ius/stable/CentOS/6/x86_64/$IUS_RPM
  fi

  if [ ! -f "$CACHE_DIR/$EPEL_RPM" ]; then
    wget -P $CACHE_DIR $EPEL_RPM_URL
    sudo rpm -ivh $CACHE_DIR/$EPEL_RPM
  fi

  if [ ! -f "$CACHE_DIR/$RPMFORGE_RPM" ]; then
    wget -P $CACHE_DIR $RPMFORGE_RPM_URL
    sudo rpm -ivh $CACHE_DIR/$RPMFORGE_RPM
  fi

  if [ ! -f "$CACHE_DIR/$REMI_RPM" ]; then
    wget -P $CACHE_DIR $REMI_RPM_URL
    sudo rpm -ivh $CACHE_DIR/$REMI_RPM
  fi

  if [ ! -f "$CACHE_DIR/$IUS_RPM" ]; then
    wget -P $CACHE_DIR $IUS_RPM_URL
    sudo rpm -ivh $CACHE_DIR/$IUS_RPM
  fi
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
