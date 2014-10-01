#!/bin/bash

source $(dirname $0)/setup.conf

## setup vim
sudo yum --enablerepo=remi --enablerepo=epel install vim-enhanced

## setup basic vimrc
if [ ! -f "$HOME/.vimrc" ]; then
  if [ -f "$CONFIG_DIR/vimrc" ]; then
    cp $CONFIG_DIR/vimrc ~/.vimrc
  else
    git clone git://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_basic_vimrc.sh
  fi
fi

## setup pathogen
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

# http://www.vim.org/scripts/script.php?script_id=2332
grep -iq "pathogen" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '1 i\
  " Pathogen\
  call pathogen#infect()\
  call pathogen#helptags()\
  ' ~/.vimrc
fi

## setup nerdtree
if [ ! -d "$HOME/.vim/bundle/nerdtree" ]; then
  pushd ~/.vim/bundle
  git clone https://github.com/scrooloose/nerdtree.git
  popd
fi

# https://github.com/scrooloose/nerdtree
grep -iq "nerdtree" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '1 i\
  " NERDTree\
  autocmd vimenter * NERDTree\
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif\
  map <C-n> :NERDTreeToggle<CR>\
  ' ~/.vimrc
fi

