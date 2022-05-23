let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #1 PLUGIN MANAGER
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')

Plug 'terryma/vim-smooth-scroll'
Plug 'SirVer/ultisnips'
Plug 'jonsmithers/vim-html-template-literals'

call plug#end()
packloadall

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #2 KEY BINDINGS & CONTROLL
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" command that is excluding anything that is in .gitignore. - :GFiles. for
" normal search, use :Files
nnoremap <C-p> :GFiles<cr>
nnoremap <C-f> :Rg<cr>
let mapleader = "\<Space>"
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nmap <leader>vr :tabedit $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>
nnoremap <C-n> :call ToggleNumber()<cr>
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-n>

"Splits
"split horizontal/vertical
nnoremap <silent>sv :vs<CR>
nnoremap <silent>sh :split<CR>
"circle between splits by Alt-comma
nnoremap , <C-w><C-w>
"split resizing
" nnoremap <silent><Right> :vertical resize +5<CR>
" nnoremap <silent><Left> :vertical resize -5<CR>
" nnoremap <silent><Up> :res +5<CR>
" nnoremap <silent><Down> :res -5<CR>

"Ctrl bindings
nnoremap <C-p> :Files<CR>
nnoremap <C-f> :GFiles<CR>
nnoremap <C-m> :History<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Commits<CR>
noremap <silent> <C-k> :call smooth_scroll#up(&scroll,  10,  3)<CR>
noremap <silent> <C-j> :call smooth_scroll#down(&scroll,  10,  3)<CR>

"YouCompleteMe
map <Leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #3 VIM/NEOVIM & PLUGINS CONFIG
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"typescript-vim
let g:typescript_indent_disable = 1

"vim-html-template-literals
let g:html_indent_style1 = "inc"
let g:htl_all_templates = 1
let g:htl_css_templates = 1
" youcompleteme
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_min_num_of_chars_for_completion=2
" fzf-vim
set grepprg=rg\ --vimgrep
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'down': '~35%' }

set ttyfast
set ttymouse=sgr
filetype off
" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
    set mouse=a
endif

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint', 
  \ 'coc-json',
  \ ]

set re=0
set number

" Only do this part when compiled with support for autocommands.
if has("autocmd")
    autocmd BufRead,BufNewFile *.applescript setf applescript
    autocmd InsertEnter,FocusLost * :set norelativenumber
    autocmd InsertLeave,FocusGained * :set relativenumber

    augroup vimrcEx
        " clear the group
        autocmd!
        autocmd FileType text setlocal textwidth=78

        " when editing a file, always jump to the last known cursor position
        autocmd BufReadPost *
            \ if line("'\"") >= 1 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif
    augroup END

    " load autocomplete and code snippets at launch
    augroup load_us_ycm
        autocmd!
        autocmd InsertEnter * call plug#load('ultisnips', 'YouCompleteMe')
                    \| autocmd! load_us_ycm
    augroup END
endif


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
set autoindent

syntax on                           " required for syntax highlighting
set clipboard=unnamed                   " clipboard from system
set foldmethod=syntax                   " enable methods folding
set foldlevel=99
set history=50		               " keep 50 lines of command line history
set showcmd		               " display incomplete commands
set omnifunc=syntaxcomplete#Complete    " smart autocompletion
set backspace=indent,eol,start
set encoding=utf-8                  " set character encoding inside
set nocompatible                    " be iMproved, required
set ruler
set wrap
" set mouse=a                         " Enable mouse support
filetype plugin indent on           " required
runtime macros/matchit.vim          " activate matchit
" let &packpath = &runtimepath

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #4 COLOR SETTINGS & SYNTAX HIGHLIGHTING
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Flagging Unnecessary Whitespace and syntax checking
highlight BadWhitespace ctermbg=red guibg=darkred
autocmd BufRead,BufNewFile * match BadWhitespace /\s\+$/

" Line and numbers highlighting
set cursorline
autocmd BufRead,BufNewFile * hi LineNr ctermbg=237
set numberwidth=6


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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" #5 FUNCTIONS
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

