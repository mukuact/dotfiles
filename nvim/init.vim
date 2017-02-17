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

"End dein Scripts-------------------------

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

"python
let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"

"deoplete
let g:deoplete#enable_at_startup = 1
" deoplete-clang
let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.8/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/include/clang/'

"denite
call denite#custom#map('insert', "<C-n>", '<denite:move_to_next_line>')
call denite#custom#map('insert', "<C-p>", '<denite:move_to_previous_line>')
call denite#custom#map('insert', "<C-a>", '<denite:move_caret_to_head>')
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
let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": ["python","c", "cpp"],
        \ "passive_filetypes": [] }
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_check_on_wq = 0
let g:syntastic_c_check_header = 1
let g:syntastic_cpp_check_header = 1

" C++ include  
augroup cpp-path
    autocmd!
    autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/opt/ros/indigo/include
augroup END
