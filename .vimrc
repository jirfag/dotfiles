let vim_mode = "SPACES"

"let vim_mode = "TABS"

highlight ExtraWhitespace ctermbg=red guibg=dark
match ExtraWhitespace /\s\+$/
match ExtraWhitespace /\s\+$\| \+\ze\t/
match ExtraWhitespace /[^\t]\zs\t\+/
let c_space_errors = 1

set foldmethod=syntax

set list
set listchars=tab:..

if vim_mode == "SPACES"
match ExtraWhitespace /\s\+$\| \+\ze\t/
set expandtab
set tabstop=4
set shiftwidth=4
else
match ExtraWhitespace /^\t*\zs \+/
set tabstop=8
set shiftwidth=8
endif

" vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
filetype plugin indent on
filetype plugin on

set wildmode=longest,list,full
set wildmenu

" vundle plugins

"Bundle 'Rip-Rip/clang_complete'

Bundle 'vim-scripts/L9'
Bundle 'vim-scripts/AutoComplPop'

" Solarized theme
Bundle 'altercation/vim-colors-solarized'
syntax enable
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized

Bundle 'endel/vim-github-colorscheme'

Bundle 'osyo-manga/neocomplcache-clang_complete'

Bundle 'gmarik/vundle'
Bundle 'honza/vim-snippets'
" Universal autocompletion plugin
Bundle 'Shougo/neocomplcache'

Bundle 'ervandew/supertab'

" Snippets for neocomplcache
Bundle 'Shougo/neosnippet'

" Various signs on lines
Bundle 'tomtom/quickfixsigns_vim'
" vundle --

" Neocomplcache
" Launches neocomplcache automatically on vim startup.
"let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underscore completion.
"let g:neocomplcache_enable_underbar_completin = 1
" Sets minimum char length of syntax keyword.
"let g:neocomplcache_min_syntax_length = 3

" Neosnippet
" Enables snipmate-snippets compatibility
"let g:neosnippet#enable_snipmate_compatibility = 1
" Tell Neosnippet about the other snippets
"let g:neosnippet#snippets_directory = '~/.vim/bundle/vim-snippets/snippets'

" use neocomplcache & clang_complete
"let g:neocomplcache_force_overwrite_completefunc = 1
let g:clang_complete_auto = 1

"let g:clang_user_options='|| exit 0'
let g:clang_auto_select = 1
"let g:clang_complete_auto = 1
"let g:clang_complete_copen = 1
"let g:clang_hl_errors = 1
"let g:clang_periodic_quickfix = 1
let g:clang_snippets = 1
let g:clang_snippets_engine = 'clang_complete'
let g:clang_conceal_snippets = 1
"let g:clang_trailing_placeholder = 1
"let g:clang_close_preview = 1
let g:clang_use_library = 1
let g:clang_library_path = '/usr/lib64/llvm'
"let g:clang_complete_macros = 1
let g:clang_complete_patterns = 1

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><s-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

if filereadable("Makefile")
set makeprg=make
map <C-b> :w<CR>:make<CR>:cw<CR>
else
map <C-b> :w<CR>:!./cons<CR>:cw<CR>
endif

map <C-x> :cn<CR>
map <C-z> :cp<CR>
map <C-c> :clast<CR>

syntax on
set bs=2

set number
set autoindent
set cindent
set showmatch

set ignorecase
set smartcase
set incsearch
set hlsearch


set tags=tags
map <F12> :!ctags -R *<CR>
map <C-p> :exec("tag ".expand("<cword>"))<CR>

map <C-v> :call g:ClangUpdateQuickFix()<CR>:copen<CR>

au! BufWritePost $MYVIMRC source %

set completeopt=menuone,menu ",longest,preview
set nocp
filetype plugin on


set statusline=%F%m%r%h%w\ [%04l,%04v][%p%%]
hi StatusLine gui=reverse cterm=reverse
set laststatus=2 " всегда показывать строку состояния

map <C-left> :tabprevious<cr>
nmap <C-left> :tabprevious<cr>
imap <C-left> <ESC>:tabprevious<cr>i
map <C-right> :tabnext<cr>
nmap <C-right> :tabnext<cr>
imap <C-right> <ESC>:tabnext<cr>i

set background=dark

" Handle tmux $TERM quirks in vim
if $TERM =~ '^screen-256color'
	map <Esc>OH <Home>
	map! <Esc>OH <Home>
	map <Esc>OF <End>
	map! <Esc>OF <End>
endif

" For local replace
nnoremap gr gd[{V%:s/<C-R>///gc<left><left><left>
"
" " For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>
