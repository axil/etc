"# -*- coding: utf-8 -*-
version 6.0

"_____________________Settings______________________

  "-general
set nocompatible		"use vim improvements
set mouse=h			"mouse works as in ordinary terminal
set viminfo='5			"marks in max 5 files are remembered in ~/.viminfo,
set viminfo+=%			"save/restore bufferlist
set tags=./tags,tags		"for C-% and C-T
set selection=exclusive		"last character is excluded
set backspace=2		        "allow backspacing over all indents
set ruler
set showcmd			"shows incomplete command in statusline
  "-windows
set winminheight=0
set winheight=17
set background=dark
  "-search
set incsearch			"interactive search
set gdefault			"several matches in a line
set ignorecase			"smartcase is suboption of ignorecase
set smartcase			"for ?,/,n,N,:g,:s, not for *,#,gd,tagsearch,etc.
set iskeyword=a-z,A-Z,48-57,_   "for gd
set ww=<,>,[,]			"when cursor is at the end-of-line
set nohlsearch
  "-x-coord format
set formatoptions=tcq		"only for new files, see "au" section below
set textwidth=0
"set autoindent			"not good enough!
set cindent
set smarttab
set noexpandtab			"pep8
set shiftwidth=4
set shiftround			"shifting blocks
  "-read/write
set readonly
set autowrite
  "-make
set makeprg=make\ %<
set path+=..,../include,templates
  "-folds / Vim6.0 special /
set foldmethod=manual
set foldnestmax=10
set foldlevel=1
  "-cinoptions
set cinoptions=(0,t0		"auto indentation
  "-window chars
set fillchars=vert:\ ,fold:-
set dictionary=/usr/share/dict/words
map ZZ <Nop>
				    " - for predictable behaviour of F5
function! MyFoldText()
  return getline(v:foldstart)." <...>"
endfunction
set fillchars="fold: "
set foldmarker=#if,#endif
set foldtext=MyFoldText()
set foldmethod=marker
"map gf :sp<CR>:find <cfile><CR>
cmap <C-a> <Home>
set visualbell
set diffopt+=vertical
set nrformats=

"                     *  *  *

"_________________File_extensions_________________

au BufEnter *.icc so $VIM/vim62/syntax/cpp.vim
"au BufEnter *.h so $VIM/vim62/syntax/cpp.vim
au BufEnter *.h,*.cc,*.pl set formatoptions-=r
"au BufEnter *.pl map [31~ :!%<CR>
"au BufEnter *.pl map! [31~ <C-O>:!%<CR>
"map [31~ :!%<CR>
"map! [31~ <C-O>:!%<CR>
"au BufEnter *.cc,*.cpp map [31~ :make && %<<CR>
"au BufEnter *.cc,*.cpp imap [31~ <C-O>:make && %<<CR>
au BufWinEnter normal '"

"                    *  *  *

"___________________Xterm-color___________________

"if &term =~ "xterm-color"
  if has("terminfo")
    set t_Co=8
    set t_Sf=[3%p1%dm
    set t_Sb=[4%p1%dm
  else
    set t_Co=8
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif

"____________________Highlights___________________
	
  syntax on
  hi Identifier ctermfg=15 
  hi Comment term=bold cterm=bold ctermfg=2
  hi Type term=bold cterm=bold ctermfg=3
  hi clear Search 
  hi link Search Visual
  hi clear IncSearch
  hi link IncSearch Visual
  hi cCommentL ctermfg=6 
"endif
"                   *  *  *

"________________Keyboard settings________________  

  "-numxpad
map! Oq 1
map! Or 2
map! Os 3
map! Ot 4
map! Ou 5
map! Ov 6
map! Ow 7
map! Ox 8
map! Oy 9
map! Op 0

  "-termcap codes, putty mode 1 ("ESC[n~")
if 1==0       
  set t_kI=[2~ 
  set t_kD=[3~ 
  set t_kh=[1~ 
  set t_@7=[4~ 
  set t_kP=[5~  
  set t_kN=[6~ 
  set t_kb=

  "-termcap codes, putty mode 2 ("SCO")
else  
  set t_kI=[L
  set t_kD=
  set t_kh=[H
  set t_@7=[F
  set t_kP=[I
  set t_kN=[G
  set t_k1=[M  
  set t_k2=[N
  set t_k3=[O
  set t_k4=[P
  set t_k5=[Q
  set t_k6=[R
  set t_k7=[S
  set t_k8=[T
  set t_k9=[U
  set t_k;=[V
  set t_F1=[W
  set t_F2=[X
  set t_kb=
  set t_kB=[Z

  au BufEnter *.cc,*.cpp map [o :!./%<<CR>
  au BufEnter *.cc,*.cpp imap [o <C-O>[o

endif

" F9%
au BufEnter *.cc,*.cpp map [U :!g++ -o%< % && ./%<<CR>
au BufEnter *.py,*.pl map [U :!./%<CR>
au BufEnter *.py,*.pl imap [U <C-O>:!./%<CR>

"                   *  *  *

"_________________Keys bindings___________________
 
nnoremap p P
nnoremap P p
  "-visual comments
vmap \# :!awk '{print "\#" $0}'<CR>
vmap \" :!awk '{print "\"" $0}'<CR>
vmap \/ :!awk '{print "//" $0}'<CR>
vmap \|1 :!awk '{print substr($0,2)}'<CR>
vmap \|2 :!awk '{print substr($0,3)}'<CR>
  "-C-W in insert mode
imap <C-W> <C-O><C-W>
  "-disable Ex mode
map Q <Nop>
  "-Del in visual mode
vmap <Del> di
  "-tab
map <Tab> ==

    "Goto insert mode:
  "-enter
map <CR> i<CR>
  "-space
map <Space> i<Space>
  "-backspace
map <BS> i<BS>
  "-del
map <Del> i<Del>

  "-make
map <F7> :make<CR>
imap <F7> <C-O><F7>
map [o :!./%<CR>
imap [o <C-O>:!./%<CR>
  "-Ctrl-*
map [34~ :set invlist<CR>
map! [34~ <C-O>:set invlist<CR>
  
  "-control-G
map! <C-G> <C-O>:set invruler<CR>

  "-num.
map On .
map! On .

  "-ctrl-k
map <C-K> d<End>
map! <C-K> <C-O><C-K>

  "-x key
map x "_d
ounmap x
map xx "_dd
ounmap xx
  
"File management:
  "-save file
    map <F2> :w<CR>
    imap <F2> <C-O><F2>
  "-explorer
    map <F3> :Sexplore<CR>
    imap <F3> <C-O><F3>

"Window management:
  " -maximize
    map <F5> <C-W>_zz
    map! <F5> <C-O><C-W>_<C-O>zz
  " -previous window  
    map <F6> <C-W><C-P>
    map! <F6> <C-O><F6>
  " -resize
    map <C-W>, <C-W>>
    map <C-W>. <C-W><


"Select/Copy/paste
  "-for correct mouse-pasting
    map <F4> :set invautoindent<CR>
    imap <F4> <C-O><F4>

"Misc :
  "-exit
    map <F10> :qa<CR>
    map! <F10> <C-O><F10>
    map x ZQ
    map! x <C-O>ZQ
  "-macros execution
"    map ; @q
  "-C-Space
    imap <F12> <C-P>

    vmap t "zdi{% trans "" %}<Esc>3<Left>"zp
    vmap b "zdi{% blocktrans %}{% endblocktrans %}<Esc>2b3hp
  
"                   *  *  *
"_______________Teraterm_special_______________
  "-Ctrl-Arrows
"    map [25~ <C-Left>
"    map! [25~ <C-Left>
"    map [26~ <C-Right>
"    map! [26~ <C-Right>
"    map [32~ <C-Y>
"    map! [32~ <C-O><C-Y> 
"    map [33~ <C-E>
"    map! [33~ <C-O><C-E>
  "-Ctrl-Del
"    map [28~ dwi
"    imap [28~ <C-O>dw
  "-Ctrl-BS
"    map [29~ i<C-W>
"    imap [29~ <C-W>
  "-Ctrl-F9
"    map [31~ :make && %<<CR>
"    imap [31~ <C-O>:make && %<<CR>
"    map <F9> :!./% 1.txt<CR>
"    imap <F9> <C-O>:!./% 1.txt<CR>

"General movement:
  "-begin/end of file
"    map [5^ gg
"    map! [5^ <C-O>gg
"    map [6^ G
"    map! [6^ <C-O>G
  "-shift+arrows
"    map [d <S-Left>
"    map! [d <S-Left>
"    map [c <S-Right>
"    map! [c <S-Right>
  "-ctrl+arrows
"    map [25~ <S-Left>
"    map! [25~ <S-Left>
"    map [26~ <S-Right>
"    map! [26~ <S-Right>
  "-two window movement
"    map Oa <C-Y><F6><C-Y><F6>
"    imap Oa <C-O><C-Y><F6><C-O><C-Y><F6>
"    map Ob <C-E><F6><C-E><F6>
"    imap Ob <C-O><C-E><F6><C-O><C-E><F6>
  "-insert+visual 
    "imap [c <C-O>v
    "imap [d <C-O>v
  "-dos-style line-killing
 "   imap <C-Y> <C-O>dd
  "-emacs-style <C-K>
  "  map <C-K> d$
  "  imap <C-K> <C-O><C-K><Left>
  "-select all
  "  map <C-A> ggVG
  "  map! <C-A> <C-O>gg<C-O>VG

" Correct <Enter> behaviour at line start
if v:version>=700
    set virtualedit=onemore         " to let cursor go one char after linebreak, 7.0 
    inoremap <expr> <Esc> MyEsc()
    func! MyEsc()
        return virtcol('.')==1?'':'l'
    endfunc
    nmap <End> $l
    func! MyCR()                    " cancel autoindenting 
    let pos=virtcol('.')            " when pressing CR in the beginning of the line
    let ind=indent(line('.'))
    if pos<=ind+1 && ind!=0
        let str='y0kopj'
        if pos!=1
            let str=str.'l'
        endif
        return str.'i'
    endif
    return 'i'
    endfunc

    "nnoremap <expr> <CR> 'i'.MyiCR()
    nnoremap <expr> <CR> MyCR()
    "imap <expr> <CR> Test()
    inoremap <expr> <CR> MyEsc().MyCR()

    func! MyiCR()                    " cancel autoindenting
    let pos=virtcol('.')             " when pressing CR in the beginning of the line
    let ind=indent(line('.'))
    if pos<=ind+1 && ind!=0
        let str=''
        if pos!=1
            let str=str.'l'
        endif
        let str=str.'y0kopj'
        if pos!=1
            let str=str.'l'
        endif
        return str.'i'
    endif
    return ''
    endfunc
else
    noremap <expr> <F4> MyiCR1()
    inoremap <expr> <F4> MyiCR1()
    func! MyiCR1()                    " cancel autoindenting 
    let pos=virtcol('.')              " when pressing CR in the beginning of the line
    let ind=indent(line('.'))
    if pos<=ind+1 && ind!=0
        let t=(pos==1)?'':'l'
        return ''.t.'y0kopj'.t.'i'
    endif
    return ''
    endfunc

endif
"http://www.vim.org/tips/tip.php?tip_id=1228
inoremap <expr> <Esc>      pumvisible()?"\<C-E>":"\<Esc>"
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <Down>     pumvisible()?"\<C-N>":"\<Down>"
inoremap <expr> <Up>       pumvisible()?"\<C-P>":"\<Up>"
inoremap <expr> <PageDown> pumvisible()?"\<PageDown>\<C-P>\<C-N>":"\<PageDown>"
inoremap <expr> <PageUp>   pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<PageUp>"

highlight   Pmenu               term=NONE cterm=NONE ctermfg=7 ctermbg=5 gui=NONE guifg=White guibg=Gray40
highlight   PmenuSel            term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White 
highlight   PmenuSbar           term=NONE cterm=NONE ctermfg=7 ctermbg=0 gui=NONE guifg=White guibg=Black 
highlight   PmenuThumb          term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White


