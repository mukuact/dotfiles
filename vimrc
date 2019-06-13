"" standard setting
set number
inoremap <silent> jj <ESC>
set ignorecase
nmap <silent> <esc><esc> :nohlsearch<CR>
set clipboard=unnamedplus
set tabstop=4
set softtabstop=0
set shiftwidth=0
set expandtab
set smarttab
set autoindent
"" temporary
set guicursor=
filetype plugin indent on

"" package manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'davidhalter/jedi-vim'
call plug#end()

