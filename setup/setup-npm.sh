#!/bin/bash
# refer: http://quickleft.com/blog/creating-and-publishing-a-node-js-module

if [ -z "$NPM_NAME" ]; then
  read -p "Enter your name: " NPM_NAME
fi
npm set init.author.name "$NPM_NAME"

if [ -z "$NPM_EMAIL" ]; then
  read -p "Enter your email: " NPM_EMAIL
fi
npm set init.author.email "$NPM_EMAIL"

#if [ -z "$NPM_URL" ]; then
#  read -p "Enter your url: " NPM_URL
#fi
#npm set init.author.url "$NPM_URL"
