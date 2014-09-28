#!/bin/bash
# refer: https://github.com/sstephenson/rbenv

if [ ! -d "$HOME/.rbenv" ]; then
	# check out rbenv into ~/.rbenv.
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
fi

grep -q "rbenv" ~/.bash_profile
if [ $? -ne 0 ]; then
	# setup $PATH for access to the rbenv command-line utility 
	echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
	
	# enable shims and autocompletion
	echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
fi

mkdir -p ~/.rbenv/plugins
pushd ~/.rbenv/plugins

PLUGINS="
git://github.com/sstephenson/ruby-build.git
git://github.com/sstephenson/rbenv-default-gems.git
git://github.com/sstephenson/rbenv-gem-rehash.git
git://github.com/rkh/rbenv-update.git
"
for plugin in $PLUGINS; do
	git clone $plugin
done

popd

# reload ~/.bash_profile
source ~/.bash_profile
type rbenv
