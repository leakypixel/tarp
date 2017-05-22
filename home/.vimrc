"" All the usual stuff - no compatible, turn some nice to haves on
"" set nocompatible - not actually needed as .vimrc presence turns this on automatically
syntax on
set background=dark
set list
set term=xterm
set nu

"" Stop VIM creating files everywhere
set nobackup
set nowritebackup
set noswapfile

"" Hide closed buffers
set hidden

"" Explicitly turn on 256 colour
set t_Co=256

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


"" While we're talking about splits...
"" set splitright " Default to opening a split to the right instead of the left
set splitbelow " Default to opening a split below instead of above

"" Set custom keybindings
noremap ) :bnext<cr>
noremap ( :bprevious<cr>
noremap <leader>d :bdelete<cr>
noremap <leader>w :w<cr>
noremap <leader>q :x<cr>
noremap <leader>x :w<cr>:bd<cr>
noremap <leader>v :vsp<cr>
noremap <leader>h :sp<cr>
noremap + :vertical resize +5<cr>
noremap - :vertical resize -5<cr>
noremap <leader>+ :resize +5<cr>
noremap <leader>- :resize -5<cr>
noremap <leader>l :lopen<cr>
noremap <leader>n :lnext<cr>
noremap <leader>c :SyntasticCheck<cr>
noremap <leader>y :'<,'>%w !xclip<cr>
noremap <leader>Y :%w !xclip<cr>
noremap <leader>S :call MakeSession()<cr>
map <C-n> :NERDTreeToggle<CR>
map <C-f> :CtrlPMixed<CR>
set pastetoggle=<f5>

"" Switch between double-space soft tabs and hard tabs
noremap <leader>T :%s/  /\t/gi<cr>
noremap <leader>t :%s/\t/  /gi<cr>

"" remove whitespace
map <leader>s :%s/\s\+$//<CR>

"" Autoformat
map <leader>f ggVGG=

"" Vundle plugins
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"" Plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/limelight.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'chriskempson/base16-vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/syntastic'
Plugin 'chrisbra/Colorizer'
call vundle#end()

"" Editorconfig plugin setup
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


"" CtrlP options for massive (read: java-like) projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"" Turn Limelight on for hyper-focused editing
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'
autocmd VimEnter * Limelight

"" Have CtrlP open in active split, like vim's native dir browser
let NERDTreeHijackNetrw=1

"" Set tab widths, line length, etc.
set autoindent
set smartindent
let s:tabwidth=2
set incsearch
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
"" set textwidth=80
"" set wrapmargin=2

"" Always display status line, but not mode
set laststatus=2
set noshowmode

"" Set wildmode
set wildmenu
set wildmode=longest:full,full

"" Let airline use powerline fonts
let g:airline_powerline_fonts = 1

"" Turn on tabline
let g:airline#extensions#tabline#enabled = 1

"" Set the airline theme
let g:airline_theme='base16_flat'

"" Turn off setting the tmux theme automatically
let g:airline#extensions#tmuxline#enabled = 0

"" Ignore some common non-dev directories/files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*

"" Setup for JS
"" Use eslint formatter for JS
autocmd FileType javascript setlocal equalprg=eslint-pretty

"" Setup for go
"" Use gofmt
autocmd FileType go setlocal equalprg=gofmt

"" Use python JSONTool for JSON
autocmd FileType json setlocal equalprg=python\ -m\ json.tool

"" Setup for SCSS
"" Use sass-convert to format
autocmd FileType scss setlocal equalprg=sass-convert\ -F\ scss\ -T\ scss\ -s

"" Setup for HTML
"" Use HTMLTidy to format
autocmd FileType html setlocal equalprg=tidy\ -ashtml\ -i\ -q\ --tidy-mark\ no\ --show-body-only\ auto

" Remap shift key failure
command! W :w
command! Wq :wq
command! E :e
command! Q :q

" Delete buffer without deleting split
command Bd bp\|bd \#

"" Don't store problematic options in saved sessions
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_loc_list_height = 5
let g:syntastic_auto_loc_list = 0
let g:syntastic_enable_highlighting = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 1
let g:syntastic_javascript_checkers = ['eslint']

let g:syntastic_error_symbol = '!'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_warning_symbol = '?!'
let g:syntastic_style_warning_symbol = '?✗'

highlight link SyntasticErrorSign SignColumn
highlight link SyntasticWarningSign SignColumn
highlight link SyntasticStyleErrorSign SignColumn
highlight link SyntasticStyleWarningSign SignColumn


"" Set colourscheme and colours on
"let base16colorspace=256
"colorscheme base16-default-dark

filetype off
filetype plugin indent on

"" Make a new session using ~/.vim/sessions to avoid accidentally including a
"" session.vim in a project
function! MakeSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  if (filewritable(b:sessiondir) != 2)
    exe 'silent !mkdir -p ' b:sessiondir
    redraw!
  endif
  let b:filename = b:sessiondir . '/session.vim'
  exe "mksession! " . b:filename
  echo "Saved session."
endfunction

" Loads a session if it exists
function! LoadSession()
  let b:sessiondir = $HOME . "/.vim/sessions" . getcwd()
  let b:sessionfile = b:sessiondir . "/session.vim"
  if (filereadable(b:sessionfile))
    exe 'source ' b:sessionfile
  else
    echo "No session loaded."
  endif
endfunction

au VimEnter * nested :call LoadSession()
