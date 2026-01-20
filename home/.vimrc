" ==========================================================
" Basics / sane defaults
" ==========================================================
set nocompatible
syntax on
filetype plugin indent on

set number
set hidden
set splitright
set splitbelow
set signcolumn=yes
set updatetime=300
set timeoutlen=500

set incsearch
set hlsearch
set ignorecase
set smartcase
set wildmenu
set wildmode=longest:full,full

" Colors
if has('termguicolors')
  set termguicolors
endif
set background=dark

" Visible whitespace
set list
set listchars=eol:¬,tab:»·,trail:·,nbsp:␣

" Tabs (TS/JS/React defaults)
set autoindent
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set textwidth=120
set wrapmargin=2

" Don’t create swap/backup files everywhere
set nobackup
set nowritebackup
set noswapfile

" Clipboard (Linux/WSL usually)
if has('clipboard')
  set clipboard=unnamedplus
endif

" ==========================================================
" Leader + mappings
" ==========================================================
let mapleader="\<Space>"

nnoremap Y y$

" Split movement
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l

" Buffers
nnoremap <silent> ) :bnext<CR>
nnoremap <silent> ( :bprevious<CR>

" Quickfix / loclist
nnoremap <silent> <leader>q :copen<CR>
nnoremap <silent> <leader>l :lopen<CR>

" Save / close buffer
nnoremap <silent> <leader>w :w<CR>
nnoremap <silent> <leader>x :w<CR>:bdelete<CR>

" Splits
nnoremap <silent> <leader>v :vsplit<CR>
nnoremap <silent> <leader>h :split<CR>

" Resize
nnoremap <silent> + :vertical resize +5<CR>
nnoremap <silent> - :vertical resize -5<CR>
nnoremap <silent> <leader>+ :resize +5<CR>
nnoremap <silent> <leader>- :resize -5<CR>

set pastetoggle=<F5>

" Your quote-wrap mapping (kept)
nnoremap S diw"0P

" Trim whitespace manually (still handy)
nnoremap <silent> <leader>s :keeppatterns %s/\s\+$//e<CR>

" ==========================================================
" Autocmds
" ==========================================================
augroup MyAutoCmds
  autocmd!
  " Trim trailing whitespace on save (best practice)
  autocmd BufWritePre * keeppatterns %s/\s\+$//e

  " Quickfix after grep
  autocmd QuickFixCmdPost *grep* cwindow

  " HTML tidy (if installed)
  autocmd FileType html if executable('tidy') | setlocal equalprg=tidy\ -config\ ~/.tidy-config | endif
augroup END

" ==========================================================
" Commands (kept)
" ==========================================================
command! W  :w
command! Wq :wq
command! E  :e
command! Q  :q
command! Bd bp|bd #

" ==========================================================
" Sessions (kept, but made safer with fnameescape)
" ==========================================================
set sessionoptions-=options
set sessionoptions-=folds

function! MakeSession() abort
  let l:sessiondir = expand('~/.vim/sessions') . getcwd()
  if !isdirectory(l:sessiondir)
    call mkdir(l:sessiondir, 'p')
  endif
  let l:sessionfile = l:sessiondir . '/session.vim'
  execute 'mksession!' fnameescape(l:sessionfile)
  echo 'Saved session: ' . l:sessionfile
endfunction

function! LoadSession() abort
  let l:sessiondir = expand('~/.vim/sessions') . getcwd()
  let l:sessionfile = l:sessiondir . '/session.vim'
  if filereadable(l:sessionfile)
    execute 'source' fnameescape(l:sessionfile)
  endif
endfunction

nnoremap <silent> <leader>S :call MakeSession()<CR>
autocmd VimEnter * nested call LoadSession()

" ==========================================================
" Plugins (vim-plug)
" ==========================================================
" Install vim-plug once:
"   curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

call plug#begin()

" Syntax / ftplugins (TS/JS/React)
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'leafgarland/typescript-vim'

" LSP (Vim)
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" Completion UI for vim-lsp
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" Optional but nice: snippets
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/vim-vsnip-integ'

" Lint/fix (keep your ALE workflow)
Plug 'dense-analysis/ale'

" Finder + tree + git + statusline + theme
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-obsession'
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sainnhe/edge'

call plug#end()

" ==========================================================
" fzf / NERDTree
" ==========================================================
nnoremap <silent> <C-f> :Files<CR>
nnoremap <silent> <leader>rg :Rg<CR>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
let g:NERDTreeHijackNetrw = 1

" ==========================================================
" Airline + theme
" ==========================================================
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'edge'

let g:edge_style = 'aura'
let g:edge_enable_italic = 1
let g:edge_diagnostic_text_highlight = 1
colorscheme edge

highlight Comment cterm=italic gui=italic

" ==========================================================
" EditorConfig exclusions (kept)
" ==========================================================
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" ==========================================================
" ALE (use for eslint/prettier + fixes; let vim-lsp do language features)
" ==========================================================
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0   " completion comes from asyncomplete+LSP

let g:ale_linters = {
\ 'javascript': ['eslint'],
\ 'javascriptreact': ['eslint'],
\ 'typescript': ['eslint'],
\ 'typescriptreact': ['eslint'],
\}

let g:ale_fixers = {
\ 'javascript': ['eslint', 'prettier', 'remove_trailing_lines', 'trim_whitespace'],
\ 'javascriptreact': ['eslint', 'prettier', 'remove_trailing_lines', 'trim_whitespace'],
\ 'typescript': ['eslint', 'prettier', 'remove_trailing_lines', 'trim_whitespace'],
\ 'typescriptreact': ['eslint', 'prettier', 'remove_trailing_lines', 'trim_whitespace'],
\ 'json': ['prettier', 'trim_whitespace'],
\ 'css': ['prettier', 'trim_whitespace'],
\ 'scss': ['prettier', 'trim_whitespace'],
\ 'yaml': ['prettier', 'trim_whitespace'],
\ 'markdown': ['prettier', 'trim_whitespace'],
\}

let g:ale_sign_error = '!'
let g:ale_sign_warning = '?'

" Keep your ALE navigation bindings
nnoremap <silent> <leader>p :ALEPrevious<CR>
nnoremap <silent> <leader>n :ALENext<CR>
nnoremap <silent> <leader>e :ALEDetail<CR>

" ==========================================================
" vim-lsp + asyncomplete wiring
" ==========================================================
" Avoid double-diagnostics (we’re using ALE for eslint diagnostics)
let g:lsp_diagnostics_enabled = 0
let g:lsp_signs_enabled = 0
let g:lsp_virtual_text_enabled = 0

" asyncomplete behaviour
let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 200

let g:lsp_settings_filetype_typescript = ['typescript-language-server']
let g:lsp_settings_filetype_typescriptreact = ['typescript-language-server']

augroup LspAsyncomplete
  autocmd!
  autocmd User lsp_setup call s:SetupLspCompletion()
augroup END

function! s:SetupLspCompletion() abort
  " asyncomplete core must exist
  if !exists('*asyncomplete#register_source')
    return
  endif

  " asyncomplete-lsp source must exist
  if !exists('*asyncomplete#sources#lsp#get_source_options')
    return
  endif

  call asyncomplete#register_source(
        \ asyncomplete#sources#lsp#get_source_options({
        \   'name': 'lsp',
        \   'whitelist': ['javascript', 'javascriptreact', 'typescript', 'typescriptreact'],
        \   'completor': function('asyncomplete#sources#lsp#completor'),
        \ }))
endfunction


" Completion keybinds (TAB cycles when popup is visible)
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<CR>"

" LSP keybinds (muscle-memory friendly)
nnoremap <silent> gd :LspDefinition<CR>
nnoremap <silent> gr :LspReferences<CR>
nnoremap <silent> gi :LspImplementation<CR>
nnoremap <silent> gy :LspTypeDefinition<CR>
nnoremap <silent> K  :LspHover<CR>
nnoremap <silent> <leader>rn :LspRename<CR>
nnoremap <silent> <leader>ca :LspCodeAction<CR>

" Prefer formatting via eslint/prettier (ALEFix)
nnoremap <silent> <leader>f :ALEFix<CR>

