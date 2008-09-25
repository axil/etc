version 6.0
 
" 04.09.07  correct CR behaviour at line start

" Run
au BufEnter *.py map <F9> :!D:/Utilities/Development/Python/python.exe %:gs?\\?/? <CR>
"map <F9> :!csc /target:winexe % && %<.exe<CR>
"map <F9> :!csc /target:exe % && %<.exe<CR>
"map <F9> :!perl %<CR>
"imap <F9> <C-O>:!perl %<CR>
"map <F9> :!gawk -f%<CR>
"imap <F9> <C-O>:!gawk -f%<CR>
au BufEnter {*.vim,_vimrc} nnoremap <F9> :source % \| set noreadonly<CR>
au BufEnter {*.py,*.vim,_vimrc} imap <F9> <C-O><F9>

" Switch header<>body
au BufEnter *.cpp nnoremap <F6> :e %<.h<CR>
au BufEnter *.h nnoremap <F6> :e %<.cpp<CR>

" Tabstop
au BufEnter {*.cpp,*.c} set tabstop=4
au BufEnter *.py set tabstop=8

" Settings
"source $VIMRUNTIME/vimrc_example.vim
set mousehide
" Make shift-insert work like in Xterm
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>
let c_comment_strings=1
set guioptions=Mr
syntax on

source $VIMRUNTIME/mswin.vim
"behave mswin
set selectmode=mouse,key
set mousemodel=popup
set keymodel=startsel         
    " no stopsel, bug with pageup in visual mode
set selection=exclusive

let $HOME=$VIM

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
set background=light            "for sessions
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
set autoindent
set smarttab
set shiftwidth=4
set shiftround			"shifting blocks
  "-read/write
set readonly
set autowrite
  "-make
"set makeprg=make
set makeprg=compile1.sh
set path+=..,../include,templates
  "-folds / Vim6.0 special /
"set foldmethod=manual
"set foldnestmax=1
"set foldlevel=1
  "-dictionary
"set dict="/usr/share/dict/words"
set visualbell
winpos 0 0
if $COMPUTERNAME=='NAME'
    set lines=54
    set columns=138
    set guifont=courier_new:h12:cRUSSIAN
elseif $COMPUTERNAME=='COMPUTERNAME'
    set lines=43
    set columns=125
    set guifont=courier_new:h10:cRUSSIAN
elseif $COMPUTERNAME=='L15-LEV'
    set lines=54
    set columns=157
    set guifont=courier_new:h10:cRUSSIAN
else
    set lines=49
    set columns=126
    set guifont=courier_new:h12:cRUSSIAN
endif
map <C-S> :w!<CR>
imap <C-S> <C-O><C-S>
set expandtab			" for python
lan english                     " vim 7.0 feature
set encoding=utf-8
"map <F12> :up<CR>:n<CR>g&
map <F12> :e #<CR>
set fileformat=unix
set isfname-=:          "for gF
set ffs=unix,dos

if v:version>=700
    unmap 
                                " in windows
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
    
map x "_d
ounmap x
map xx "_dd
ounmap xx

" horizontal windows movement
nnoremap <C-W><Home> 100<C-W><Left>
imap <C-W><Home> <C-O><C-W><Home>
nnoremap <C-W><End> 100<C-W><Right>
imap <C-W><End> <C-O>100<C-W><Right>

"                   *  *  *


"__________________ mappings __________________

" File&window management:
  "-save file
    map <F2> :w!<CR>
    imap <F2> <C-O>:w!<CR>
  "-explorer
    map <F3> :Sexplore D:\<CR>
    imap <F3> <C-O>:Sexplore D:\<CR>
  " -resize
    map <F5> <C-W>_<C-W>\|
    imap <F5> <C-O><C-W>_<C-O><C-W>\|<C-O>zz
    map <F6> <C-W>w
    imap <F6> <C-O><C-W>w
  " -next & previous window
    map <F7> :Next<CR>
    map! <F7> <C-O>:Next<CR>
    map <F8> :next<CR>
    map! <F8> <C-O>:next<CR>
  " -change window in insert mode
    imap <C-W> <C-O><C-W>


" Goto insert mode 'automatically':
  "-enter
"    map <CR> i<CR>
  "-space
    map <Space> i<Space>
  "-backspace
    map <BackSpace> i<BackSpace>
  "-del
    map <Del> i<Del>
  "-tab
"    map <Tab> i<Tab>   "used for jumplist navigation
    vmap <Tab> >
    map <S-Tab> <<
    vmap <S-Tab> <

" General movement:
  "-begin/end of file
    map <C-Home> gg
    map! <C-Home> gg
    map <C-End> G
    map! <C-End> G
  "-shift+arrows
"    map [d
"    map! [d
"    map [c
"    map! [c
  "-ctrl+arrows
"    map Od
"    map! Od
"    map Oc
"    map! Oc
  "-two window movement
"    map Oa
"    imap Oa
"    map Ob
"    imap Ob
    map <C-Up> <C-W><Up>
    map <C-Down> <C-W><Down>


" Select/Copy/paste
  "-inserting blocks
    nnoremap p P
    nnoremap P p
  "-insert+visual
    "imap [c v
    "imap [d v
    "map!   p
  "-for correct mouse-pasting
"   imap  :set invautoindent
  "-select all
  "  map  ggVG
  "  map!  ggVG

" Misc :
  "-control-G
"    map!  :set invruler
  "-dos-style line-killing
 "   imap  dd
  "-emacs-style
    map <C-K> d$
    imap <C-K> <C-O>d$
"-exit
    map <F10> :qa!<CR>
    map! <F10> <C-O><F10>
  "-macros execution
    "map ; @q
  "-numxpad
"    map! Oq 1
"    map! Or 2
"    map! Os 3
"    map! Ot 4
"    map! Ou 5
"    map! Ov 6
"    map! Ow 7
"    map! Ox 8
"    map! Oy 9
"    map! Op 0
  "-tab
"    map <Tab> ==
  "-make
"    map  :!./%
"    imap  :!./%
"    map  :make
"    imap  :make
"    map  :!g++ -lpthread %
"    imap  :!g++ -lpthread %
"    map [20^ :!g++ -lpthread % && a.out
"    map! [20^ :!g++ -lpthread % && a.out
  "-S-Del
"   Оimap <C-Del> <C-O>cw
  "-format line  
    map Q ggvG=
"    imap Q <C-O>gg<C-O>vG=
  "-move in command line
    cmap <C-A> <Home>

" tabs
"    map à 1gt
    map ± 1gt
    map ² 2gt
    map ³ 3gt
    map ´ 4gt
    map µ 5gt
"    imap à <C-O>1gt
    imap ± <C-O>1gt
    imap ² <C-O>2gt
    imap ³ <C-O>3gt
    imap ´ <C-O>4gt
    imap µ <C-O>5gt
" Alt-= to create the tabs
    map ½ :tabnew<CR>:tabnew<CR>:tabnew<CR>:tabnew<CR>:tabnew<CR>1gt

    map <M-C-PageUp> gT
    imap <M-C-PageUp> <C-O>gT
    map <M-C-PageDown> gt
    imap <M-C-PageDown> <C-O>gt

    if $OS=='Windows_NT'
        map <C-Right> w
        map <C-Left> b
        vmap ô "zdi{% trans "" %}<Esc>3<Left>"zp
        vmap â "zdi{% blocktrans %}{% endblocktrans %}<Esc>2b3hp
    else
        map [C w
        imap [C <C-Right>
        map [D b
        imap [D <C-Left>
    endif
    

"_______________end of mappings_________________

"                   *  *  *

"______________terminal settings________________

"Terminal settings special for 'win32'

" Checking term variable
"let s:r#r_a  = @a
"redir @a
"echo &term
"redir END
"put a

if &term =~ ""
  "-sizes a bit huger
"    set lines=43
"    set columns=124
  "-turn off all those toolbars and menus!
"    set guioptions=Mr
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
"    vmap <PageUp> <C-B>
"    vmap <PageDown> <C-D>
  "-encodings for console
    set termencoding=cp866
  "some trouble with escaped keys
"    map +K <Left>
"    map! +K <Left>
"    map +M <Right>
"    map! +M <Right>
"    map +H <Up>
"    map! +H <Up>
"    map +P <Down>
"    map! +P <Down>
"    map <C-W>+H <C-W><Up>
"    map <C-W>+P <C-W><Down>
"    map <C-W>+K <C-W><Left>
"    map <C-W>+M <C-W><Right>
    
"    map +R <Insert>
"    map! +R <Insert>
"    map +S <Delete>
"    map! +S <Delete>
"    map +G <Home>
"    map! +G <Home>
"    map +O <End>
"    map! +O <End>
"    map +I <PageUp>
"    map! +I <PageUp>
"    map +Q <PageDown>
"    map! +Q <PageDown>

"    map +; <F1>
"    map! +; <F1>
"    map +< <F2>
"    map! +< <F2>
"    map += <F3>
"    map! += <F3>
"    map +> <F4>
"    map! +> <F4>
"    map +? <F5>
"    map! +? <F5>
"    map +@ <F6>
"    map! +@ <F6>
"    map +A <F7>
"    map! +A <F7>
"    map +B <F8>
"    map! +B <F8>
"    map +C <F9>
"    map! +C <F9>
"    map +D <F10>
"    map! +D <F10>
"    map +Е <F11>
"    map! +Е <F11>
"    map +Ж <F12>
"    map! +Ж <F12>
endif    

 "-highlights

"  syntax on
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
    hi DiffAdd guifg=white
    hi DiffChange guifg=white
    hi DiffText guifg=white
    hi Folded guibg=black
    hi PreProc guifg=lightblue 
    hi Underlined guifg=lightblue gui=underline 


"____________end of terminal settings___________

"                   *  *  *

"_________________miscellaneous_________________

"Miscellaneous
"au BufEnter *.icc so /usr/share/vim/vim57/syntax/cpp.vim
"au BufEnter *.h so /usr/share/vim/vim57/syntax/cpp.vim
au BufEnter *.asmx so D:\Utilities\Editors\Vim\vim60\syntax\cs.vim


if has("autocmd")
  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set diffexpr=MyDiff()
set diffopt+=vertical
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

"unmap <C-I>

"http://www.vim.org/tips/tip.php?tip_id=1228
"inoremap <expr> <Esc>      pumvisible()?"\<C-E>":"\<Esc>"
inoremap <expr> <Esc>      pumvisible()?"\<C-E>":MyEsc()
inoremap <expr> <CR>       pumvisible()?"\<C-Y>":"\<CR>"
inoremap <expr> <Down>     pumvisible()?"\<C-N>":"\<Down>"
inoremap <expr> <Up>       pumvisible()?"\<C-P>":"\<Up>"
inoremap <expr> <PageDown> pumvisible()?"\<PageDown>\<C-P>\<C-N>":"\<PageDown>"
inoremap <expr> <PageUp>   pumvisible()?"\<PageUp>\<C-P>\<C-N>":"\<PageUp>"

highlight   Pmenu               term=NONE cterm=NONE ctermfg=7 ctermbg=5 gui=NONE guifg=White guibg=Gray40
highlight   PmenuSel            term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White 
highlight   PmenuSbar           term=NONE cterm=NONE ctermfg=7 ctermbg=0 gui=NONE guifg=White guibg=Black 
highlight   PmenuThumb          term=NONE cterm=NONE ctermfg=0 ctermbg=7 gui=NONE guifg=Black guibg=White


