"" All the usual stuff - no compatible, turn some nice to haves on
syntax on
set background=dark
set list
set term=xterm
set nu
set viminfo=""

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
noremap <leader>q :copen<cr>
noremap <leader>p :ALEPrevious<cr>
noremap <leader>n :ALENext<cr>
noremap <leader>d :bdelete<cr>
noremap <leader>w :w<cr>
noremap <leader>x :w<cr>:bd<cr>
noremap <leader>v :vsp<cr>
noremap <leader>h :sp<cr>
noremap + :vertical resize +5<cr>
noremap - :vertical resize -5<cr>
noremap <leader>+ :resize +5<cr>
noremap <leader>- :resize -5<cr>
noremap <leader>l :lopen<cr>
noremap <leader>y :'<,'>%w !xclip<cr>
noremap <leader>Y :%w !xclip<cr>
noremap <leader>S :call MakeSession()<cr>
map <C-n> :NERDTreeToggle<CR>
map <C-f> :CtrlPMixed<CR>
set pastetoggle=<f5>
nnoremap <F6> :call SpellCheck()<cr>
"" Switch between double-space soft tabs and hard tabs
noremap <leader>T :%s/  /\t/gi<cr>
noremap <leader>t :%s/\t/  /gi<cr>
nnoremap S diw"0P

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
Plugin 'tpope/vim-commentary'
Plugin 'w0rp/ale'
Plugin 'chrisbra/Colorizer'
Plugin 'sheerun/vim-polyglot'
Plugin 'vimwiki/vimwiki'
call vundle#end()

"" Editorconfig plugin setup
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"" Have fugitive grep open quickfix when run
autocmd QuickFixCmdPost *grep* cwindow

"" CtrlP options for massive (read: java-like) projects
let g:ctrlp_max_files=0
let g:ctrlp_max_depth=40
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

"" Turn Limelight on for hyper-focused editing
"autocmd VimEnter * Limelight
" Color name (:help gui-colors) or RGB color
"let g:limelight_conceal_guifg = 'DarkGray'
"let g:limelight_conceal_guifg = '#777777'

"" Have NerdTree open in active split, like vim's native dir browser
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
set textwidth=0
set wrapmargin=2
au BufRead,BufNewFile *.md setlocal textwidth=80

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
let g:airline_theme='tomorrow'

"" Ignore some common non-dev directories/files
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*

"" Setup for HTML
"" Use HTMLTidy to format
autocmd FileType html setlocal equalprg=tidy\ -config\ ~/.tidy-config

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

"" Config for JSX
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.jsx set filetype=javascript.jsx
augroup END

"" ALE config
let g:ale_linters = {
\   'javascript.jsx': ['eslint'],
\   'javascript': ['eslint'],
\   'js': ['eslint'],
\   'python': ['pylint'],
\   'html': ['tidy'],
\}
""let g:ale_linter_aliases = {'jsx': 'css'}

" Fix files automatically on save.
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'javascript': ['prettier_eslint', 'prettier', 'eslint', 'remove_trailing_lines', 'trim_whitespace'],
\   'javascript.jsx': ['prettier_eslint', 'prettier', 'eslint', 'remove_trailing_lines', 'trim_whitespace'],
\   'typescriptreact': ['prettier_eslint', 'prettier', 'eslint', 'remove_trailing_lines', 'trim_whitespace'],
\   'vue': ['prettier_eslint', 'prettier', 'eslint', 'remove_trailing_lines', 'trim_whitespace'],
\   'typescript': ['prettier', 'remove_trailing_lines', 'trim_whitespace'],
\   'html.handlebars': ['remove_trailing_lines', 'trim_whitespace'],
\   'json': ['jq', 'prettier', 'trim_whitespace'],
\   'css': ['prettier', 'trim_whitespace'],
\   'html': ['remove_trailing_lines', 'trim_whitespace'],
\   'yaml': ['remove_trailing_lines', 'trim_whitespace'],
\   'yaml.ansible': ['remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['remove_trailing_lines', 'trim_whitespace', 'shfmt'],
\   'python': ['yapf'],
\}

" Enable completion where available.
let g:ale_completion_enabled = 1

" Set ALE characters
let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'

" Set HTML tidy options
let g:ale_html_tidy_options = '-config ~/.tidy-config'

" Turn on ALE + Airline integration
let g:airline#extensions#ale#enabled = 1

"" VimWiki
let g:vimwiki_list = [{'path': '~/notes/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]

"" Set colourscheme and colours on
colorscheme Tomorrow-Night

filetype off
filetype plugin indent on

"" Make comments italic
highlight Comment cterm=italic

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

function! SpellCheck()
  exe 'setlocal spell! spell?'
  exec 'highlight SpellBad ctermfg=009 ctermbg=011 guifg=#ff0000 guibg=#ffff00'
endfunction

au VimEnter * nested :call LoadSession()
