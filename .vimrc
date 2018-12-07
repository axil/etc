"# -*- coding: utf-8 -*-
version 6.0

" ____________________Contents_______________________
  " Settings: common/symmetric/asymmetric
  " Highlighting: common/symmetric/asymmetric
  " Mappings: common/symmetric/asymmetric
    " Neutralizing Vim7.0 'features'
    " Fixing dropdown menu
  " Autocommands: common/symmetric/asymmetric


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
  "-search
set incsearch			"interactive search
set gdefault			"several matches in a line
set ignorecase			"smartcase is suboption of ignorecase
set smartcase			"for ?,/,n,N,:g,:s, not for *,#,gd,tagsearch,etc.
set iskeyword=a-z,A-Z,48-57,_   "for gd
set ww=<,>,[,]			"when cursor is at the end-of-line
set nohlsearch
  "-horizontal format
set formatoptions=cqtroq		"only for new files, see "au" section below        cloqr
set textwidth=0
  "-tabs
"set shiftwidth=4               "doing this globally makes indentexpr crazy for config files
set shiftround			"shifting blocks
set tabstop=8
set autoindent

set noexpandtab                 "for conf files
set shiftwidth=8		"same

set smarttab
  "-read/write
set autowrite
  "-make
set path+=..,../include,templates
set visualbell
set nrformats=
set diffopt+=vertical
set ruler
set scrolloff=3
set rtp+=$GOROOT/misc/vim
set encoding=utf-8
filetype plugin indent on
set listchars+=nbsp:_
let g:table_mode_corner_corner="+"
set cc=80
hi ColorColumn ctermbg=darkgrey guibg=#171717
    
" diff
set diffexpr=MyDiff()
function! MyDiff()
let opt = ""
if &diffopt =~ "icase"
	let opt = opt . "-i "
endif
if &diffopt =~ "iwhite"
	let opt = opt . "-b -w "
endif
silent execute "!diff -a " . opt . v:fname_in . " " . v:fname_new .
		\  " > " . v:fname_out
endfunction

"______________Settings: symmetric differences________________
if $OS=='Windows_NT'
    set background=light            "for sessions
"    set autoindent
else
    set background=dark
"    set cindent
"    set cinoptions=(0,t0		"auto indentation
endif

"_____________Settings: asymmetric differences________________
if $OS=='Windows_NT'
    "source $VIMRUNTIME/vimrc_example.vim
    set mousehide
    " Make shift-insert work like in Xterm
    map <S-Insert> <MiddleMouse>
    map! <S-Insert> <MiddleMouse>
    let c_comment_strings=1
    set guioptions=Mr

    source $VIMRUNTIME/mswin.vim    "behave mswin
    set selectmode=mouse,key
    set mousemodel=popup
    set keymodel=startsel           "no stopsel, bug with pageup in visual mode
    set selection=exclusive

"    let $HOME=$VIM
    winpos 0 0
    set guifont=courier_new:h10:cRUSSIAN
    if $COMPUTERNAME=='NAME'
        set lines=54
        set columns=138
    elseif $COMPUTERNAME=='COMPUTERNAME'
        set lines=43
        set columns=125
    elseif $COMPUTERNAME=='L15-LEV'
        set lines=54
        set columns=157
    else
        set lines=49
        set columns=126
    endif
    lan english                     " vim 7.0 feature
    set fileformat=unix
    set isfname-=:          "for gF
    set ffs=unix,dos

else
    set fillchars=vert:\ ,fold:-
    if has("terminfo")
        set t_Co=8
        set t_Sf=[3%p1%dm
        set t_Sb=[4%p1%dm
    else
        set t_Co=8
        set t_Sf=[3%dm
        set t_Sb=[4%dm
    endif
endif

"                        *  *  *



"_______________Highlighting: common___________________
syntax on
highlight   Pmenu               term=NONE cterm=NONE ctermfg=7 ctermbg=5 gui=NONE guifg=White guibg=Gray40
highlight   PmenuSel            term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White 
highlight   PmenuSbar           term=NONE cterm=NONE ctermfg=7 ctermbg=0 gui=NONE guifg=White guibg=Black 
highlight   PmenuThumb          term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White

if $OS=='Windows_NT'
"  hi Identifier ctermfg=15
    hi ErrorMsg term=reverse ctermfg=15 ctermbg=12
    hi Comment term=bold ctermfg=10
    hi Type term=bold ctermfg=14
    hi clear Search
    hi link Search Visual
    hi clear IncSearch
    hi link IncSearch Visual
    hi Normal guifg=white guibg=black
    hi SpecialKey guifg=blue
    hi NonText gui=NONE
    hi MoreMsg gui=NONE guifg=green
"    set guifont=courier_new:h12:cRUSSIAN
    source $VIM\_guicolors
"    hi DiffAdd guifg=white
"    hi DiffChange guifg=white 
"    hi DiffText guifg=white guibg=DarkRed
"    hi DiffChange guibg=#303030
highlight DiffAdd    guifg=lightgray guibg=#171717
highlight DiffDelete guifg=#707070 guibg=#171717
highlight DiffChange guifg=lightgray guibg=#171717
highlight DiffText   guifg=lightgray guibg=#88003E

    hi Folded guibg=black
"    hi PreProc guifg=lightblue
    hi Underlined guifg=lightblue gui=underline 
else
    syntax on
    hi Identifier ctermfg=15 
    hi Comment term=bold cterm=bold ctermfg=2
    hi Type term=bold cterm=bold ctermfg=3
    hi clear Search 
    hi link Search Visual
    hi clear IncSearch
    hi link IncSearch Visual
    hi cCommentL ctermfg=6 
endif

" ________________Mappings: common________________
" General movement:
  "-begin/end of file
    map <C-Home> gg
    map! <C-Home> <C-O>gg
    map <C-End> G
    map! <C-End> <C-O>G
  "-inserting blocks
    nnoremap p P
    nnoremap P p
" File&window management:
  "-save file
    map <F2> :w<CR>
    imap <F2> <C-O><F2>
  "-explorer
"    map <F3> :Sexplore<CR>
"    imap <F3> <C-O><F3>
  " -resize
    map <F5> <C-W>_
    imap <F5> <C-O><C-W>_<C-O>zz
  " -resize using equal width
    map <C-F5> <C-W>_<C-W>\|
    imap <C-F5> <C-O><C-W>_<C-O><C-W>\|<C-O>zz
  " -previous window  
    map <F6> <C-W>w
    imap <F6> <C-O><C-W>w
  " -next & previous window
"    map <F7> :Next<CR>
"    map! <F7> <C-O>:Next<CR>
"    map <F8> :next<CR>
"    map! <F8> <C-O>:next<CR>
    map <F8> :cnext<CR>
    imap <F8> <C-O>:cnext<CR>
    map <F7> :cNext<CR>
    imap <F7> <C-O>:cNext<CR>
  " -change window in insert mode
    imap <C-W> <C-O><C-W>
  " -edit alternative file
"    map <F12> :e #<CR>
  " -paste
"    map <F12> :set paste<CR>i
"    "imap <F12> <C-O>:set nopaste<CR><C-[>
"    imap <F12> <C-[>
    set pastetoggle=<F12>
  " -resize
    map <C-W>, <C-W>>
    map <C-W>. <C-W><
  " -windows movement accelerators
    map <C-Up> <C-W><Up>
    imap <C-Up> <C-O><C-W><Up>
    map <C-Down> <C-W><Down>
    imap <C-Down> <C-O><C-W><Down>
    nnoremap <C-W><Home> 100<C-W><Left>
    imap <C-W><Home> <C-O><C-W><Home>
    nnoremap <C-W><End> 100<C-W><Right>
    imap <C-W><End> <C-O>100<C-W><Right>
    nnoremap <C-W><PageUp> 100<C-W><Up>
    imap <C-W><PageUp> <C-O>100<C-W><Up>
    nnoremap <C-W><PageDown> 100<C-W><Down>
    imap <C-W><PageDown> <C-O>100<C-W><Down>

"Autoswitching to insert mode:
  "-enter
    map <CR> i<CR>
  "-space
    map <Space> i<Space>
  "-backspace
    map <BS> i<BS>
  "-del
    map <Del> i<Del>

" Editing
  "-ctrl-k
    map <C-K> d$
    map! <C-K> <C-O>d$
  "-disable Ex mode
    map Q <Nop>
  "-disable save and exit
    map ZZ <Nop>
  "-commenting/uncommenting
    vmap <silent> . :<C-U>let @9=@/<Bar>'<,'>s/^/#/<Bar>let @/=@9<CR>
    vmap <silent> , :<C-U>let @9=@/<Bar>'<,'>s/^#//<Bar>let @/=@9<CR>
  "-tab
    noremap <C-P> <C-I>
    noremap <Tab> i<Tab>
    vmap <Tab> >
    map <S-Tab> <<
    vmap <S-Tab> <
  "-C-Space
"  imap <F12> <C-P>
    
" Misc:
  "-exit
    map <F10> :qa<CR>
    map! <F10> <C-O><F10>
    map x ZQ
    map! x <C-O>ZQ
  "-Command mode fixes:
    cmap <C-a> <Home>
  "-x key
    map x "_d
    ounmap x
    nmap xx "_dd
  "- join lines
    map <C-J> J
    imap <C-J> <C-O>J
  "- insert formatted
    map [P ]p
  "- repeat insert
"    map <C-A> <C-R>.
  "- nbsp
    inoremap <C-Space> <C-K><Space><Space>
    nmap <C-Space> i<C-Space><Esc>
  "- unmap enter
    autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" _____________Mappings: symmetric differences_____________
if $OS=='Windows_NT'
    map <C-Right> w
    map <C-Left> b
  "- set/remove debug point
    map <F4> "='import ipdb; ipdb.set_trace()000'<CR>[p
    map <S-F4> "='import ipdb; ipdb.set_trace()000'<CR>[P
    imap <F4> <Space><BS><C-O>"='import ipdb; ipdb.set_trace()000'<CR>[p
    imap <S-F4> <C-O>"='import ipdb; ipdb.set_trace()000'<CR>[P
    "imap <S-F4> <Space><BS><C-O>"='import ipdb; ipdb.set_trace()000'<CR>[P
    map <C-F4> "='import pdb; pdb.set_trace()000'<CR>[p
    imap <C-F4> <C-O>"='import pdb; pdb.set_trace()000'<CR>[p
    map <F3> "='from IPython.core.debugger import Tracer;  Tracer()()000'<CR>[p
    imap <F3> <C-O><F3>
else
    map [C w
    imap [C <C-Right>
    map [D b
    imap [D <C-Left>
  "- set/remove debug point
    map <F4> "='import ipdb; ipdb.set_trace()000'<CR>[p
    imap <F4> <C-O>"='import ipdb; ipdb.set_trace()000'<CR>[p
    map [b oimport ipdb; ipdb.set_trace()<Esc>^
    map [n "='import pdb; pdb.set_trace()000'<CR>[p
    imap [n <C-O>"='import pdb; pdb.set_trace()000'<CR>[p
    map [O "='import rpdb2; rpdb2.start_embedded_debugger("qqq")000'<CR>[p
    imap [O <C-O>[O
endif

" _____________Mappings: asymmetric differences_____________
if $OS=='Windows_NT'
    unmap 
    "-strange <C-Y> setting!
        unmap <C-Y>
        iunmap <C-Y>
  "-visual mode problems
    vmap <Left> h
    vmap <Right> l
    vmap <Up> k
    vmap <Down> j
    vmap <Home> ^
    vmap <End> $
    set termencoding=cp866
  "-tabs
"    map à 1gt
    map ± 1gt
    map ² 2gt
    map ³ 3gt
    map ´ 4gt
    map µ 5gt
    map ¶ 6gt
"    imap à <C-O>1gt
    imap ± <C-O>1gt
    imap ² <C-O>2gt
    imap ³ <C-O>3gt
    imap ´ <C-O>4gt
    imap µ <C-O>5gt
    imap ¶ <C-O>6gt

    map <M-C-PageUp> gT
    imap <M-C-PageUp> <C-O>gT
    map <M-C-PageDown> gt
    imap <M-C-PageDown> <C-O>gt

  "-Alt-= to create the tabs
    map ½ :tabnew<CR>:tabnew<CR>:tabnew<CR>:tabnew<CR>:tabnew<CR>:tabnew<CR>:cd ../..<CR>1gt

    iunmap <C-A>
    map й q
    map ц w
    map у e
    map к r
    map е t
    map н y
    map г u
    map ш i
    map щ o
    map з p
    map х [
    map ъ ]
    map ф a
    map ы s
    map в d
    map а f
    map п g
    map р h
    map о j
    map л k
    map д l
    map ж ;
    map э '
    map я z
    map ч x
    map с c
    map м v
    map и b
    map т n
    map ь m
    map б ,
    map ю .
"    map . /
else
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
  "-num.
    map On .
    map! On .

  "-termcap codes, putty mode 2 ("SCO")
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
  "-wordwise movement
    map [D <S-Left>
    map [C <S-Right>
  "-missing escape-sequences
    map [A <C-Up>
    imap [A <C-Up>
    map [B <C-Down>
    imap [B <C-Down>
  "-override write protection
    cmap w!! %!sudo tee > /dev/null %
endif

" _____- neutralizing some new "features" in v7.0______

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
        let str=':let z=@"y0kopj:let @"=z'
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
else
    func! MyiCR1()                    " cancel autoindenting 
    let pos=virtcol('.')              " when pressing CR in the beginning of the line
    let ind=indent(line('.'))
    if pos<=ind+1 && ind!=0
        let t=(pos==1)?'':'l'
        return ''.t.'y0kopj'.t.'i'
    endif
    return ''
    endfunc
    noremap <expr> <F4> MyiCR1()
    inoremap <expr> <F4> MyiCR1()
endif

" _______________- dropdown menu fix__________________
"http://www.vim.org/tips/tip.php?tip_id=1228
if $OS=='Windows_NT'
    inoremap <expr> <Esc>      pumvisible()?"\<C-E>":MyEsc()
else
    inoremap <expr> <Esc>      pumvisible()?"\<C-E>":"\<Esc>"
endif
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <Down>     pumvisible()?"\<C-N>":"\<Down>"
inoremap <expr> <Up>       pumvisible()?"\<C-P>":"\<Up>"
inoremap <expr> <PageDown> pumvisible()?"\<PageDown>\<C-P>\<C-N>":"\<PageDown>"
inoremap <expr> <PageUp>   pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<PageUp>"
        
"_______________________Autocommands_____________________________
augroup vimrcEx    
au!
" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

"au BufEnter * set noexpandtab nosmarttab tabstop=8    - this is the default
"au BufEnter *.py set expandtab smarttab shiftwidth=4
"au BufEnter {*.c,*.cpp,*.m,*.html,*.htm,*.css,*.js} set shiftwidth=4 tabstop=8 smarttab expandtab
"au BufEnter *.css set shiftwidth=8 tabstop=8 nosmarttab noexpandtab
au BufEnter {*.py,*.go,*.hs} set shiftwidth=4 tabstop=8 smarttab expandtab
au BufEnter {*.c,*.cpp,*.h,*.hpp,*.m,*.css,*.js,*py,*.sql,*.jl} set expandtab smarttab shiftwidth=4 tabstop=4
au BufEnter {*.htm,*.html,*.jinja} set noexpandtab nosmarttab ts=4 sw=4 indentexpr= 
au BufEnter *.jinja set syntax=htmldjango
au BufEnter *.log set syntax=log
au BufEnter *.cs set expandtab
au BufEnter {*.rst} set sw=4 expandtab nosmarttab

  "-commenting/uncommenting
au BufEnter {*.c,*.cpp,*.h,*.hpp,*.m,*.js,*.html,*.go} vmap <buffer><silent> . :<C-U>let @9=@/<Bar>'<,'>s,^,//,<Bar>let @/=@9<CR>
au BufEnter {*.c,*.cpp,*.h,*.hpp,*.m,*.js,*.html,*.go} vmap <buffer><silent> , :<C-U>let @9=@/<Bar>'<,'>s,^//,,<Bar>let @/=@9<CR>
au BufEnter {*.hs} vmap <buffer><silent> . :<C-U>let @9=@/<Bar>'<,'>s,^,--,<Bar>let @/=@9<CR>
au BufEnter {*.hs} vmap <buffer><silent> , :<C-U>let @9=@/<Bar>'<,'>s,^--,,<Bar>let @/=@9<CR>
au BufEnter .vimrc vmap <buffer><silent> . :<C-U>let @9=@/<Bar>'<,'>s,^,",<Bar>let @/=@9<CR>
au BufEnter .vimrc vmap <buffer><silent> , :<C-U>let @9=@/<Bar>'<,'>s,^",,<Bar>let @/=@9<CR>

au BufEnter *.jinja so $VIMRUNTIME/syntax/html.vim
au BufEnter *.h,*.cc,*.pl,*.jinja set formatoptions-=r
au BufEnter *.jinja hi PreProc guifg=lightblue

"___________Autocommands: symmetric differences__________________
if $OS=='Windows_NT'
    "-trans
    au BufEnter *.html vmap ô "zdi{% trans "" %}<Esc>4<Left>"zp
    au BufEnter *.html vmap â "zdi{% blocktrans %}{% endblocktrans %}<Esc>2b3hp
    "-pyflakes
    au BufEnter *.py map <S-F9> :!start py %:gs?\\?/? <CR>
    au BufEnter *.py map <C-F9> :!start D:/Utilities/Development/Python26/egg/Scripts/pyflakes.bat %:gs?\\?/?<CR>
else
    au BufEnter *.jl map <S-F9> :!start julia.exe %:gs?\\?/? <CR>
    "-trans
    au BufEnter *.html vmap t "zdi{% trans "" %}<Esc>3<Left>"zp
    au BufEnter *.html vmap b "zdi{% blocktrans %}{% endblocktrans %}<Esc>2b3hp
    "-pyflakes
    au BufEnter *.py map [s :!pyflakes %<CR>
    au BufEnter *.py imap [s <C-O>:!pyflakes %<CR>
endif

"___________Autocommands: asymmetric differences_________________
if $OS=='Windows_NT'
    " -run
    au BufEnter *.py nnoremap <F9> :!C:/Windows/py.exe %:gs?\\?/? <CR>
    au BufEnter *.jl nnoremap <F9> :!julia %:gs?\\?/? <CR>
    au BufEnter *.go map <F9> :!go run %:gs?\\?/? <CR>
    au BufEnter {*.vim,_vimrc} nnoremap <F9> :source %<CR>
    au BufEnter {*.js} nnoremap <F9> :!casperjs.exe %<CR>
    au BufEnter {*.py,*.vim,_vimrc,*.js} inoremap <F9> <C-O><F9>

    " -switch header<>body
    au BufEnter *.cpp nnoremap <F6> :e %<.h<CR>
    au BufEnter *.h nnoremap <F6> :e %<.cpp<CR>

    au BufEnter *.asmx so D:\Utilities\Editors\Vim\vim60\syntax\cs.vim
else
    au BufEnter *.icc so $VIM/vim62/syntax/cpp.vim
    au BufWinEnter normal '"
    
    au BufEnter *.cc,*.cpp map [o :!./%<<CR>
    au BufEnter *.cc,*.cpp imap [o <C-O>[o

    "-<F9>
    au BufEnter *.cc,*.cpp map <F9> :!g++ -lrt -o%< % && ./%<<CR>
    au BufEnter *.py,*.pl map [U :!python %<CR>
    au BufEnter *.py,*.pl imap [U <C-O>:!python %<CR>
    au BufEnter *.py,*.pl map [s :!sudo ./go.sh<CR>
    au BufEnter *.py,*.pl imap [s <C-O>:!sudo ./go.sh<CR>
endif
augroup end

hi PreProc guifg=lightblue
