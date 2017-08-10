if &compatible
  set nocompatible               " Be iMproved
endif

"dein Scripts-----------------------------
let s:dein_dir = expand('$HOME/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let s:toml = s:dein_dir.'/../dein.toml'
    call dein#load_toml(s:toml)

    call dein#end()
    call dein#save_state()
endif

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif
autocmd VimEnter * call dein#call_hook('post_source')
"End dein Scripts-------------------------
filetype plugin indent on
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
set smartindent
set guicursor=

"python
let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"

"deoplete
" deoplete-clang

"denite

"neosnippet
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
" Plugin key-mappings.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"syntastic

" C++ include  
augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/opt/ros/indigo/include,include
augroup END
