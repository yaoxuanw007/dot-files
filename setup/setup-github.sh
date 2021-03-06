#!/bin/bash

# content:
#
# [user]
#   name=YOUR_NAME
#   email=YOUR_EMAIL
git config --global --edit

if [ -z "$EMAIL" ]; then
  read -p "Enter your email: " EMAIL
fi
# generate ssh key
ssh-keygen -t rsa -C $EMAIL

# start ssh-agent
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa

# setup public key in github
vi ~/.ssh/id_rsa.pub

# test github
ssh -T git@github.com
