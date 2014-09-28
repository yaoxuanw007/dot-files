#!/bin/bash
# refer: https://github.com/sstephenson/rbenv

# update rbenv and all plugins
rbenv update

# install dependency packages
sudo yum groupinstall "Development Tools" -y
sudo yum --enablerepo=remi --enablerepo=epel install libxml2-devel libxslt-devel libcurl-devel sqlite-devel readline-devel openssl-devel -y

# install ruby
rbenv install 2.1.3
#rbenv install 1.9.3-p547
rbenv global 2.1.3 

# install RubyGem
gem update --system
gem install rake
gem install bundler
gem cleanup
