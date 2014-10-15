#!/bin/bash

source $(dirname $0)/setup.conf

## setup vim
sudo yum --enablerepo=remi --enablerepo=epel install vim-enhanced

# utilities to install vim plugin
function install_plugin() {
  local bundle="$HOME/.vim/bundle" 
  local name=$1
  local url=$2

  if [ ! -d "$bundle/$name" ]; then
    pushd $bundle
    git clone $url $name
    popd
  fi
}

function check_config() {
  local name=$1

  grep -iq "$name" ~/.vimrc
}

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
install_plugin "nerdtree" "git://github.com/scrooloose/nerdtree.git"

# https://github.com/scrooloose/nerdtree
check_config "nerdtree"
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
install_plugin "delimitmate" "git://github.com/Raimondi/delimitMate.git"

# closetag 
install_plugin "closetag" "git://github.com/docunext/closetag.vim.git"

check_config "closetag"
if [ $? -ne 0 ]; then
  sed -i '$ a\
" closetag\
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1\
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim\
' ~/.vimrc
fi

# superTab
install_plugin "supertab" "git://github.com/vim-scripts/supertab.git"

check_config "supertab"
if [ $? -ne 0 ]; then
  sed -i '$ a\
" supertab\
let g:SuperTabContextDefaultCompletionType = "<c-n>"\
' ~/.vimrc
fi

# tagbar
# http://blog.sensible.io/2014/05/09/supercharge-your-vim-into-ide-with-ctags.html
sudo yum install ctags
install_plugin "tagbar" "git://github.com/majutsushi/tagbar.git"

check_config "tagbar"
if [ $? -ne 0 ]; then
  sed -i '$ a\
" tagbar\
let g:tagbar_usearrows=1\
nnoremap <leader>l :TagbarToggle<CR>\
' ~/.vimrc
fi

# solarized
install_plugin "solarized" "git://github.com/altercation/vim-colors-solarized.git"

check_config "solarized"
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

# commentary
install_plugin "commentary" "git://github.com/tpope/vim-commentary.git"

check_config "commentary"
if [ $? -ne 0 ]; then
  sed -i '$ a\
" commentary\
" use backspace in normal and virtual mode\
nmap <BS> gcc\
vmap <BS> gc\
' ~/.vimrc
fi

# http://www.vim.org/scripts/script.php?script_id=2332
check_config "pathogen"
if [ $? -ne 0 ]; then
  sed -i '1 i\
" pathogen\
call pathogen#infect()\
call pathogen#helptags()\
' ~/.vimrc
fi
