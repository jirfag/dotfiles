let vim_mode = "SPACES"

"let vim_mode = "TABS"

"au Filetype python let vim_mode = "SPACES"
"au Filetype c let vim_mode = "TABS"

filetype plugin on
autocmd Filetype htmldjango call SetTabs(2)
"autocmd Filetype htmldjango set ts=2 sw=2

map <C-E> <Esc>:call SetSpaces()<CR>
map <C-Y> <Esc>:call SetTabs(8)<CR>

function! SetTabs(tab_len)
	match ExtraWhitespace /^\t*\zs \+/
	let &tabstop = a:tab_len
	let &shiftwidth = a:tab_len
	set noexpandtab
	highlight ExtraWhitespace ctermbg=red guibg=dark
endfunction

function! SetSpaces()
	match ExtraWhitespace /\s\+$\| \+\ze\t/
	set expandtab
	set tabstop=4
	set shiftwidth=4
	highlight ExtraWhitespace ctermbg=red guibg=dark
endfunction

set list
set listchars=tab:..

highlight ExtraWhitespace ctermbg=red guibg=dark
match ExtraWhitespace /\s\+$\| \+\ze\t/
match ExtraWhitespace /[^\t]\zs\t\+/
let c_space_errors = 1

"set foldmethod=syntax

if vim_mode == "SPACES"
	call SetSpaces()
else
	call SetTabs(8)
endif


set wildmode=longest,list,full
set wildmenu
"filetype plugin indent on
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'vim-scripts/L9'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-surround'
Plugin 'garbas/vim-snipmate'
Plugin 'scrooloose/syntastic'
Plugin 'endel/vim-github-colorscheme'
Plugin 'altercation/vim-colors-solarized'
Plugin 'gmarik/vundle'
Plugin 'vim-scripts/taglist.vim'
Plugin 'tomtom/quickfixsigns_vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()            " required
"filetype plugin indent on    " required

syntax enable
set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
set background=dark

"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

if filereadable("Makefile")
set makeprg=make
map <C-b> :w<CR>:make<CR>:cw<CR>
else
map <C-b> :w<CR>:!./cons<CR>:cw<CR>
endif

map <C-x> :cn<CR>
map <C-z> :cp<CR>
map <C-c> :clast<CR>
map <C-u> :%s/\s\+$//g<CR>

syntax on
set bs=2

set number
set cin
set showmatch

set ignorecase
set smartcase
set incsearch
set hlsearch


set tags=tags
map <C-p> :exec("tag ".expand("<cword>"))<CR>
map <C-]> :YcmCompleter GoToDefinitionElseDeclaration<CR>
map <C-t> <C-o>
map <C-'> :YcmCompleter GoToDeclaration<CR>

map <C-v> :call g:ClangUpdateQuickFix()<CR>:copen<CR>

au! BufWritePost $MYVIMRC source %


set statusline=%F%m%r%h%w\ [%04l,%04v,off=%o][%p%%]
hi StatusLine gui=reverse cterm=reverse
set laststatus=2 " всегда показывать строку состояния

map <C-left> :tabprevious<cr>
nmap <C-left> :tabprevious<cr>
imap <C-left> <ESC>:tabprevious<cr>i
map <C-right> :tabnext<cr>
nmap <C-right> :tabnext<cr>
imap <C-right> <ESC>:tabnext<cr>i

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

set termencoding=utf-8
set fileencodings=utf8,cp1251
set encoding=utf8
"
"

"set conceallevel=2
"set concealcursor=vin
"
" " Complete options (disable preview scratch window, longest removed to aways
" " show menu)
set completeopt=menu,menuone
"
" " Limit popup menu height
set pumheight=20
"
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

map <C-m> :TlistToggle<CR> <C-w><C-w>
let g:snippets_dir='~/.vim/bundle/vim-snippets/snippets/'
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<CR>']
let g:ycm_confirm_extra_conf = 0

set path+=core/src
set path+=core/include
set path+=capron/src
set path+=capron/include

let g:surround_45 = "{% trans \"\r\" %}"
let g:ycm_collect_identifiers_from_tags_files = 1
highlight ExtraWhitespace ctermbg=red guibg=dark
