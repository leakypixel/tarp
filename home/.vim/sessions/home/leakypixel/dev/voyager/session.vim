let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/dev/voyager
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +32 components/default/interactive/addon-products/_addon-products.scss
badd +57 components/default/interactive/addon-products/addon-products.client.js
badd +61 components/default/interactive/shopping-basket/shopping-basket.client.js
badd +1 components/default/core/main/totd/_house-style.scss
badd +11 components/default/interactive/shopping-basket/_shopping-basket.scss
argglobal
silent! argdel *
$argadd components/default/interactive/addon-products/_addon-products.scss
edit components/default/core/main/totd/_house-style.scss
set splitbelow splitright
set nosplitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
argglobal
let s:l = 13 - ((12 * winheight(0) + 27) / 55)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
13
normal! 016|
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
