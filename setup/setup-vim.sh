#!/bin/bash

source ./setup.conf

# setup vim
sudo yum --enablerepo=remi --enablerepo=epel install vim-enhanced

# setup pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
