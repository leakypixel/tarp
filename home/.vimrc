"" All the usual stuff - no compatible, turn some nice to haves on
set nocompatible
syntax on
set background=dark
set list
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
set splitright " Default to opening a split to the right instead of the left
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
noremap <leader>o:resize +5<cr>
noremap <leader>l :resize -5<cr>
noremap <leader>. :ts<cr>
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

"" Jump to next in quickfix
map <leader>n :cn<cr>

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
Plugin 'edkolev/tmuxline.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'chriskempson/base16-vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'Shutnik/jshint2.vim'
Plugin 'elzr/vim-json'
Plugin 'leafgarland/typescript-vim'
Plugin 'editorconfig/editorconfig-vim'
call vundle#end()

"" Editorconfig plugin setup
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']


"" Set colourscheme and colours on
let base16colorspace=256
colorscheme base16-default

"" CtrlP options for massive (read: java-like) projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_clear_cache_on_exit = 0

"" Turn Limelight on for hyper-focused editing
autocmd VimEnter * Limelight 0.5

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
set textwidth=80
set wrapmargin=2

"" Always display status line, but not mode
set laststatus=2
set noshowmode

"" Let airline use powerline fonts
let g:airline_powerline_fonts = 1

"" Turn on tabline
let g:airline#extensions#tabline#enabled = 1

"" Turn off setting the tmux theme automatically
let g:airline#extensions#tmuxline#enabled = 0

"" Ignore some common non-dev directories/files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*


"" Highlight trailing or orphaned tabs
augroup HighlightPeskyTabs
  au!
  autocmd BufRead,BufNewFile *
      \ syn match Tab "\t" |
      \ syn match TrailingWS "\s\+$" |
      \ hi def Tab ctermbg=red guibg=red |
      \ hi def TrailingWS ctermbg=red guibg=red |
augroup END

"" Setup for JS
"" Turn JSHint output off by default because it's a pest
augroup JavaScript
  au!
  autocmd BufRead,BufNewFile *.js
        \ set filetype=javascript |
augroup END
"" Use eslint formatter for JS
autocmd FileType javascript setlocal equalprg=eslint-pretty
"" Get some JSHint output
autocmd FileType javascript map <buffer> <leader>l :JSHint<cr>

"" Setup for SCSS
"" Use sass-convert to format
autocmd FileType scss setlocal equalprg=sass-convert\ -F\ scss\ -T\ scss\ -s

"" Setup for HTML
"" Use HTMLTidy to format
autocmd FileType html setlocal equalprg=tidy\ -i\ -f\ --quiet\ --tidy-mark\ no\ --show-body-only\ auto\ --wrap\ 80

"" Turn off hiding quotes in JSON
let g:vim_json_syntax_conceal = 0

" Remap shift key failure
command! W :w
command! Wq :wq
command! E :e
command! Q :q

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

filetype off
filetype plugin indent on
