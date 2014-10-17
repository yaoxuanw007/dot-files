#!/bin/bash

[ "`whoami`" != "root" ] && echo "need root" && exit 1

which node >/dev/null
if [ $? -ne 0 ]; then
  # install nodejs
  curl -sL https://rpm.nodesource.com/setup | bash -
  yum install -y nodejs

  # install build tools
  yum groupinstall 'Development Tools'
fi
