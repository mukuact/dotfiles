"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath^=$HOME/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin(expand('$HOME/.config/nvim/dein'))

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/denite.nvim')
call dein#add('Shougo/vimshell.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('kmnk/vim-unite-giti')
call dein#add('kannokanno/previm')
call dein#add('tyru/open-browser.vim')
call dein#add('tpope/vim-surround')
call dein#add('davidhalter/jedi-vim',{'build' : 'pip install jedi','on_ft' :["python", "python3", "djangohtml"]})
call dein#add('lambdalisue/vim-pyenv' ,{'depends' : 'davidhalter/jedi-vim'})
call dein#add('scrooloose/syntastic')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-scripts/gtags.vim')
call dein#add('ompugao/ros.vim')
" Required:
call dein#end()

" Required:
filetype plugin indent on

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------
"
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

"pyenv
"let $PATH = "~/.pyenv/shims:".$PATH
"deoplete
let g:deoplete#enable_at_startup = 1

""unite
"let g:unite_enable_start_insert=1
"let g:unite_source_file_mru_limit = 200
"let g:unite_source_rec_async_command =  ['ag', '--follow', '--nocolor', '--nogroup',   '--hidden', '-g', '']
"let g:unite_source_grep_max_candidates = 100
"
"nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
"nnoremap <silent> ,uf :<C-u>Unite file_rec/neovim<CR>
"nnoremap <silent> ,ug :<C-u>Unite file_rec/git<CR>

"denite
call denite#custom#map('insert', "<C-n>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-p>", '<denite:move_to_previous_line>')
call denite#custom#map('insert', "jj", '<denite:enter_mode:normal>')
call denite#custom#var('file_rec', 'command',  ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])
nmap <silent> ,uf :<C-u>DeniteProjectDir file_rec<CR>
nmap <silent> ,ug :<C-u>DeniteProjectDir grep<CR>
nmap <silent> ,uu :<C-u>Denite buffer file_mru<CR>
nmap <silent> ,uh :<C-u>Denite help<CR>

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
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

"syntastic
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_check_on_wq = 0

" C++ include  
augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/opt/ros/indigo/include
augroup END
