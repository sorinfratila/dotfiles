syntax on                           " required for syntax highlighting
set backspace=indent,eol,start
set encoding=utf-8                  " set character encoding inside
set nocompatible                    " be iMproved, required
set ruler
set wrap
" set mouse=a                         " Enable mouse support
filetype plugin indent on           " required
runtime macros/matchit.vim          " activate matchit
" let &packpath = &runtimepath

packloadall

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-json',
  \ ]

"""" enable the theme
syntax enable
set termguicolors 

" Always show lightline - this is the bottom status bar
set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ }

let g:nord_cursor_line_number_background = 1
let g:nord_uniform_status_lines = 1
let g:nord_bold_vertical_split_line = 1
let g:nord_bold = 1
let g:nord_italic = 1
let g:nord_italic_comments = 1

" override the foreground color of Vim syntax comment titles
augroup nord-theme-overrides
  autocmd!
  " Use 'nord7' as foreground color for Vim comment titles.
  autocmd ColorScheme nord highlight vimCommentTitle ctermfg=14 guifg=#8FBCBB
augroup END

colorscheme nord

set re=0

set grepprg=rg\ --vimgrep
set rtp+=/usr/local/opt/fzf
" command that is excluding anything that is in .gitignore. - :GFiles. for
" normal search, use :Files
nnoremap <C-p> :GFiles<cr>
nnoremap <C-f> :Rg<cr>
"this is a comment 
let mapleader = "\<Space>"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <leader>vr :tabedit $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

set number
" toggle between relative numbers and normal
function! ToggleNumber()
  if(!&relativenumber && !&number)
    set number
  elseif(!&relativenumber)
    set relativenumber
  else
    set norelativenumber
  endif
endfunction
nnoremap <C-n> :call ToggleNumber()<cr>

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" get rid of swap files, backupfiles
" set backupdir=~/.vim/backup//
" set directory=~/.vim/swap//
" set undodir=~/.vim/undo//
set ttimeoutlen=50
set noswapfile
set nobackup
set nowritebackup
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set clipboard=unnamed

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>
