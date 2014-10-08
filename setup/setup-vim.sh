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

## setup nerdtree
if [ ! -d "$HOME/.vim/bundle/nerdtree" ]; then
  pushd ~/.vim/bundle
  git clone git://github.com/scrooloose/nerdtree.git nerdtree
  popd
fi

# https://github.com/scrooloose/nerdtree
grep -iq "nerdtree" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '$ a\
\
" nerdtree\
autocmd vimenter * NERDTree\
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif\
map <C-n> :NERDTreeToggle<CR>\
' ~/.vimrc
fi

# refer to http://mirnazim.org/writings/vim-plugins-i-use/
# delmitmate
# :help delimitMate
if [ ! -d "$HOME/.vim/bundle/delmitmate" ]; then
  pushd ~/.vim/bundle
  git clone git://github.com/Raimondi/delimitMate.git delmitmate
  popd
fi

# closetag 
if [ ! -d "$HOME/.vim/bundle/closetag" ]; then
  pushd ~/.vim/bundle
  git clone git://github.com/docunext/closetag.vim.git closetag
  popd
fi

grep -iq "closetag" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '$ a\
" closetag\
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1\
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim\
' ~/.vimrc
fi

# superTab
if [ ! -d "$HOME/.vim/bundle/supertab" ]; then
  pushd ~/.vim/bundle
  git clone git://github.com/vim-scripts/supertab.git supertab
  popd
fi

grep -iq "supertab" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '$ a\
" supertab\
let g:SuperTabContextDefaultCompletionType = "<c-n>"\
' ~/.vimrc
fi

# tagbar
# http://blog.sensible.io/2014/05/09/supercharge-your-vim-into-ide-with-ctags.html
if [ ! -d "$HOME/.vim/bundle/tagbar" ]; then
  pushd ~/.vim/bundle
  sudo yum install ctags
  git clone git://github.com/majutsushi/tagbar.git tagbar
  popd
fi

grep -iq "tagbar" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '$ a\
" tagbar\
let g:tagbar_usearrows=1\
nnoremap <leader>l :TagbarToggle<CR>\
' ~/.vimrc
fi

# solarized
if [ ! -d "$HOME/.vim/bundle/solarized" ]; then
  pushd ~/.vim/bundle
  git clone git://github.com/altercation/vim-colors-solarized.git solarized
  popd
fi

grep -iq "solarized" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '$ a\
" solarized\
set background=dark\
let g:solarized_termtrans=1\
let g:solarized_termcolors=256\
let g:solarized_contrast="high"\
let g:solarized_visibility="high"\
colorscheme solarized\
' ~/.vimrc
fi

# http://www.vim.org/scripts/script.php?script_id=2332
grep -iq "pathogen" ~/.vimrc
if [ $? -ne 0 ]; then
  sed -i '1 i\
" pathogen\
call pathogen#infect()\
call pathogen#helptags()\
' ~/.vimrc
fi
