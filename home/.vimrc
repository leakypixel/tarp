set nocompatible
"" Stop VIM creating files everywhere
set nobackup            " no backup files
set nowritebackup       " only in case you don't want a backup file while editing
set noswapfile          " no swap files

"" Hide closed buffers
set hidden

"" Show the end of line char as a ¬, so it's nice and visible
set listchars=eol:¬,tab:»·

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"" Set leader to space so it can be hit by either hand
let mapleader = "\<Space>"

"" Set hjkl split movement to shorter combinations
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

set t_Co=256

"" While we're talking about splits...
set splitright " Default to opening a split to the right instead of the left
set splitbelow " Default to opening a split below instead of above

"" Set custom keybindings
noremap ) :bprevious<cr>
noremap ( :bnext<cr>
noremap <leader>d :bdelete<cr>
noremap <leader># :w<cr>
noremap <leader>q :wq<cr>
noremap <leader>w :w<cr>:bd<cr>
noremap <leader>v :vsp<cr>
noremap <leader>s :sp<cr>
noremap + :vertical resize +5<cr>
noremap - :vertical resize -5<cr>
noremap <leader>o:resize +5<cr>
noremap <leader>l :resize -5<cr>
noremap <leader>. :ts<cr>
map <C-n> :NERDTreeToggle<CR>
map <C-f> :CtrlPMixed<CR>
set pastetoggle=<f5>

"" Switch between double-space soft tabs and hard tabs
noremap <leader>T :%s/  /\t/gi<cr>
noremap <leader>t :%s/\t/  /gi<cr>

"" Vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'wookiehangover/jshint.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'edkolev/tmuxline.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'chriskempson/base16-vim'
call vundle#end()

"" Set colourscheme and colours on
let base16colorspace=256
colorscheme base16-default

"" CtrlP options for massive (read: java-like) projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:50,results:50'
let g:ctrlp_clear_cache_on_exit = 0

"" Turn Limelight on for hyper-focused editing
autocmd VimEnter * Limelight 0.5

"" Have CtrlP open in active split, like vim's native dir browser
let NERDTreeHijackNetrw=1

"" All the usual stuff - no compatible, turn some nice to haves on
set nocompatible
syntax on
filetype plugin indent on
set background=dark
set list
set nu

"" Set tab widths, etc.
set autoindent
set smartindent
let s:tabwidth=2
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"" Always display status line, but not mode
:set laststatus=2
:set noshowmode

"" Let airline use powerline fonts
let g:airline_powerline_fonts = 1

"" Use eslint formatter for JS
autocmd FileType javascript setlocal equalprg=eslint-pretty

"" Ignore some common non-dev directories
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*  

"" Highlight trailing or orphaned tabs
augroup HighlightPeskyTabs
  au!
  autocmd BufRead,BufNewFile *
      \ syn match Tab "\t\+$" |
      \ syn match TrailingWS "\s\+$" |
      \ if &background == "dark" |
      \   hi def Tab ctermbg=red guibg=red |
      \   hi def TrailingWS ctermbg=red guibg=red |
      \ else |
      \   hi def Tab ctermbg=red guibg=red |
      \   hi def TrailingWS ctermbg=red guibg=red |
      \ endif
augroup END
