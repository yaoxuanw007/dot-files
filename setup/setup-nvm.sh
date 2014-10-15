#!/bin/bash
# refer: https://github.com/creationix/nvm

[ "`whoami`" == "root" ] && echo "need non-root" && exit 1

curl https://raw.githubusercontent.com/creationix/nvm/v0.17.2/install.sh | bash
