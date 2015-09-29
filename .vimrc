"========================================================================
" by GCJ
" Email:guochangjiang1989@gmail.com
"	你可以下载最新的修改 git clone git@github.com:guochangjiang/vim.git
"========================================================================


" turn off nice effect on status bar title
" 关闭一些美化的效果，如果想改回来，
" let performance_mode=0
let performance_mode=1

"关闭代码折叠 (开启 set foldenable)
set nofoldenable

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Get out of VI's compatible mode..

set nocompatible  " 关闭 vi 兼容模式
let $LANG = 'en' "set messeage language
set langmenu=en "set menu's language of gvim.

syntax enable

"查看操作系统
function! MySys()
	if ("win16") || has("win32") || has("win64") || has("win95")
		return "win32"
	elseif has("unix")
		return "unix"
	else
		return "mac"
	endif
endfunction

"==============================================================
"在unix 和mac系统下设置shell为bash
"Set shell to be bash
if MySys() == "unix" || MySys() == "mac"
	set shell=bash
else
	"I have to run win32 python without cygwin
	"set shell=E:cygwininsh
endif
"==============================================================

"==============================================================
"设置记录的次数
"Sets how many lines of history VIM har to remember
set history=400
"==============================================================



"Enable filetype plugin
filetype on
if has("eval") && v:version>=600
	filetype plugin on
	filetype indent on
endif

"Set to auto read when a file is changed from the outside
if exists("&autoread")
	set autoread
endif

"Have the mouse enabled all the time:
if exists("&mouse")
	set mouse=a
endif

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast saving
nmap <leader>x :xa!<cr>
nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Font
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable syntax hl
if MySys()=="unix"
	if v:version<600
		if filereadable(expand("$VIM/syntax/syntax.vim"))
			syntax on
		endif
	else
		syntax on
	endif
else
	syntax on
endif

"internationalization
"I only work in Win2k Chinese version
if has("multi_byte")
	"set bomb 
  set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,latin1 
  " CJK environment detection and corresponding setting 
  if v:lang =~ "^zh_CN" 
    " Use cp936 to support GBK, euc-cn == gb2312 
		"set encoding=cp936 
		set encoding=utf-8
    "set termencoding=cp936 
    set termencoding=utf-8
    "set fileencoding=cp936 
    set fileencoding=utf-8
  elseif v:lang =~ "^zh_TW" 
    " cp950, big5 or euc-tw 
    " Are they equal to each other? 
    set encoding=big5 
    set termencoding=big5 
    set fileencoding=big5 
  elseif v:lang =~ "^ko" 
    " Copied from someone's dotfile, untested 
    set encoding=euc-kr 
    set termencoding=euc-kr 
    set fileencoding=euc-kr 
  elseif v:lang =~ "^ja_JP" 
    " Copied from someone's dotfile, untested 
    set encoding=euc-jp 
    set termencoding=euc-jp 
    set fileencoding=euc-jp 
  endif 
  " Detect UTF-8 locale, and replace CJK setting if needed 
  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$" 
    set encoding=utf-8 
    set termencoding=utf-8 
    set fileencoding=utf-8 
  endif
endif

"if you use vim in tty,
"'uxterm -cjk' or putty with option 'Treat CJK ambiguous characters as wide' on
if exists("&ambiwidth")
	set ambiwidth=double
endif

if has("gui_running")
	set guioptions+=m
	set guioptions-=T
	set guioptions-=l
	set guioptions-=L
	set guioptions+=r
	set guioptions-=R
	
"set guioptions-=T " 隐藏工具栏
"set guioptions-=m " 隐藏菜单栏
set smartindent " 开启新行时使用智能自动缩进


"	当系统为win时，开启窗口最大化
	if MySys()=="win32"
		"start gvim maximized
		if has("autocmd")
			au GUIEnter * simalt ~x
		endif
	endif
	"let psc_style='cool'
	if v:version > 601 
		"colorscheme ps_color
		"colorscheme default
		colorscheme molokai " 设定配色方案
	endif
else
	if v:version > 601 
		"set background=dark
		"colorscheme default
		"colorscheme elflord
	endif
endif

"let g:colors_name="molokai"
"let g:molokai_original = 1
"let g:rehash256 = 1

"Some nice mapping to switch syntax (useful if one mixes different languages in one file)
map <leader>1 :set syntax=cheetah<cr>
map <leader>2 :set syntax=xhtml<cr>
map <leader>3 :set syntax=python<cr>
map <leader>4 :set ft=javascript<cr>
map <leader>$ :syntax sync fromstart<cr>

"Highlight current高亮显示当前行
if has("gui_running")
	if exists("&cursorline")
		set cursorline
	endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Favorite filetype
set ffs=unix,dos,mac

nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Set 7 lines to the curors - when moving vertical..
set so=7

"Turn on WiLd menu
set wildmenu

"显示标尺
"Always show current position
set ruler " 打开状态栏标尺

"The commandbar is 2 high
set cmdheight=2 " 设定命令行的行数为 2


"显示行号
"Show line number
set nu

"Do not redraw, when running macros.. lazyredraw
set lz

"Change buffer - without saving
set hid

"Set backspace
set backspace=eol,start,indent

"Bbackspace and cursor keys wrap to
set whichwrap+=<,>,h,l

"Ignore case when searching
"set ignorecase
set incsearch " 输入搜索内容时就显示搜索结果

"Set magic on
set magic " 设置魔术

set hidden " 允许在有未保存的修改时切换缓冲区，此时的修改由 vim 负责保存


"No sound on errors.
set noerrorbells " 关闭错误信息响铃
set novisualbell " 关闭使用可视响铃代替呼叫
set t_vb= " 置空错误铃声的终端代码

"show matching bracet
set showmatch " 插入括号时，短暂地跳转到匹配的对应括号
" set matchtime=2 " 短暂跳转到匹配括号的时间

"How many tenths of a second to blink
set mat=8

"Highlight search thing
set hlsearch " 搜索时高亮显示被找到的文本

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
"Format the statusline
" Nice statusbar
if performance_mode
else
	set laststatus=2 " 显示状态栏 (默认值为 1, 无法显示状态栏)
	set statusline=
	" 设置在状态行显示的信息
	set statusline+=%2*%-3.3n%0*\ " buffer number
	set statusline+=%f\ " file name
	set statusline+=%h%1*%m%r%w%0* " flags
	set statusline+=[
	if v:version >= 600
		set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
		set statusline+=%{&encoding}, " encoding
	endif
	set statusline+=%{&fileformat}] " file format
	if filereadable(expand("$VIM/vimfiles/plugin/vimbuddy.vim"))
		set statusline+=\ %{VimBuddy()} " vim buddy
	endif
	set statusline+=%= " right align
	set statusline+=%2*0x%-8B\ " current char
	set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

	" special statusbar for special windows
	if has("autocmd")
		au FileType qf
					\ if &buftype == "quickfix" |
					\ setlocal statusline=%2*%-3.3n%0* |
					\ setlocal statusline+=\ \[Compiler\ Messages\] |
					\ setlocal statusline+=%=%2*\ %<%P |
					\ endif

		fun! FixMiniBufExplorerTitle()
			if "-MiniBufExplorer-" == bufname("%")
				setlocal statusline=%2*%-3.3n%0*
				setlocal statusline+=\[Buffers\]
				setlocal statusline+=%=%2*\ %<%P
			endif
		endfun

		if v:version>=600
			au BufWinEnter *
						\ let oldwinnr=winnr() |
						\ windo call FixMiniBufExplorerTitle() |
						\ exec oldwinnr . " wincmd w"
		endif
	endif

	" Nice window title
	if has('title') && (has('gui_running') || &title)
		set titlestring=
		set titlestring+=%f\ " file name
		set titlestring+=%h%m%r%w " flags
		set titlestring+=\ -\ %{v:progname} " program name
	endif
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Map space to / and c-space to ?
map <space> /

"Smart way to move btw. window
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


"Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

if v:version>=700
	set switchbuf=usetab
endif

if exists("&showtabline")
	set stal=2
endif

"Moving fast to front, back and 2 sides ;)
imap <m-$> <esc>$a
imap <m-0> <esc>0i
imap <D-$> <esc>$a
imap <D-0> <esc>0i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Autocommand
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Switch to current dir
map <leader>cd :cd %:p:h<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
"http://www.vim.org/tips/tip.php?tip_id=153
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrev
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Comment for C like language
if has("autocmd")
	au BufNewFile,BufRead *.js,*.htc,*.c,*.tmpl,*.css ino $c /**<cr> **/<esc>O
endif

"My information
ia xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
"iab xname Amir Salihefendic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings etc.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using control
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if MySys() == "mac"
	nmap <D-j> <M-j>
	nmap <D-k> <M-k>
	vmap <D-j> <M-j>
	vmap <D-k> <M-k>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command-line config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
func! Cwd()
	let cwd = getcwd()
	return "e " . cwd
endfunc

func! DeleteTillSlash()
	let g:cmd = getcmdline()
	if MySys() == "unix" || MySys() == "mac"
		let g:cmd_edited = substitute(g:cmd, "(.*[/]).*", "", "")
	else
		let g:cmd_edited = substitute(g:cmd, "(.*[\]).*", "", "")
	endif
	if g:cmd == g:cmd_edited
		if MySys() == "unix" || MySys() == "mac"
			let g:cmd_edited = substitute(g:cmd, "(.*[/]).*/", "", "")
		else
			let g:cmd_edited = substitute(g:cmd, "(.*[\]).*[\]", "", "")
		endif
	endif
	return g:cmd_edited
endfunc

func! CurrentFileDir(cmd)
	return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"cno $q <C->eDeleteTillSlash()<cr>
"cno $c e <C->eCurrentFileDir("e")<cr>
"cno $tc <C->eCurrentFileDir("tabnew")<cr>
cno $th tabnew ~/
cno $td tabnew ~/Desktop/

"Bash like
cno <C-A> <Home>
cno <C-E> <End>
cno <C-K> <C-U>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Buffer realted
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Fast open a buffer by search for a name
"map <c-q> :sb

"Open a dummy buffer for paste
map <leader>q :e ~/buffer<cr>

"Restore cursor to file position in previous editing session
set viminfo='10,"100,:20,%,n~/.viminfo

" Buffer - reverse everything ... :)
map <F9> ggVGg?

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Turn backup off
set nobackup " 覆盖文件时不备份
set nowb
"set noswapfile

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
	set foldenable " 开始折叠
	set foldmarker={,}  
	set foldmethod=marker
	set foldmethod=syntax " 设置语法折叠
	set foldcolumn=0 " 设置折叠区域的宽度
	setlocal foldlevel=1 " 设置折叠层数为
	" set foldclose=all " 设置为自动关闭折叠 
	nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR> " 用空格键来开关折叠
	"只能选择一个，上面的是用{}来折叠，zc是折叠，zo是展开
	":set foldmethod=marker
endif

if exists("&foldlevel")
	set fdl=0
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text option
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python script
"set expandtab
set shiftwidth=4 " 设定 << 和 >> 命令移动时的宽度为 4
set softtabstop=2 " 使得按退格键时可以一次删掉 2 个空格
set tabstop=2 " 设定 tab 长度为 2
set backspace=2
set smarttab
set lbr
"set tw=500

""""""""""""""""""""""""""""""
" => Indent
""""""""""""""""""""""""""""""
"Auto indent
set ai

"Smart indet
set si

"C-style indenting
if has("cindent")
	set cindent
endif

"Wrap line
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>sn ]
map <leader>sp [
map <leader>sa zg
map <leader>s? z=



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Yank Ring
""""""""""""""""""""""""""""""
map <leader>y :YRShow<cr>

""""""""""""""""""""""""""""""
" => File explorer
""""""""""""""""""""""""""""""
"Split vertically
let g:explVertical=1

"Window size
let g:explWinSize=30

let g:explSplitLeft=1
let g:explSplitBelow=1

"Hide some file
let g:explHideFiles='^.,.*.class$,.*.swp$,.*.pyc$,.*.swo$,.DS_Store$'

"Hide the help thing..
let g:explDetailedHelp=0


""""""""""""""""""""""""""""""
" => Minibuffer
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 0
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

"WindowZ
map <c-w><c-t> :WMToggle<cr>
let g:bufExplorerSortBy = "name"

""""""""""""""""""""""""""""""
" => LaTeX Suite thing
""""""""""""""""""""""""""""""
"set grepprg=grep -r -s -n
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'

if has("autocmd")
	"Binding
	au BufRead *.tex map <silent><leader><space> :w!<cr> :silent! call Tex_RunLaTeX()<cr>

	"Auto complete some things ;)
	au BufRead *.tex ino <buffer> $i indent
	au BufRead *.tex ino <buffer> $* cdot
	au BufRead *.tex ino <buffer> $i item
	au BufRead *.tex ino <buffer> $m [<cr>]<esc>O
endif

""""""""""""""""""""""""""""""
" => Tag list (ctags) - not used
""""""""""""""""""""""""""""""
"let Tlist_Ctags_Cmd = "/sw/bin/ctags-exuberant"
"let Tlist_Sort_Type = "name"
"let Tlist_Show_Menu = 1
"map <leader>t :Tlist<cr>
"map <F3> :Tlist<cr>
"let Tlist_Show_One_File=1
"let Tlist_Exit_OnlyWindow=1
"filetype on
"let Tlist_Show_Menu = 1
"set tags=tags;
"set autochdir " 自动切换当前目录为当前文件所在的目录
"map <F3> :silent! Tlist<CR>  "按下F3就可以呼出Taglist  
"let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行 
"let Tlist_Show_One_File = 1            "不同时显示多个文件的tag，只显示当前文件的。 
"let Tlist_Exit_OnlyWindow = 1          "如果 taglist 窗口是最后一个窗口，则退出 vim。 
"let Tlist_Use_Right_Window = 0         "在右侧窗口中显示 taglist 窗口。
"let Tlist_Auto_Open=1    "在启动 vim 后，自动打开 taglist 窗口。 
"let Tlist_File_Fold_Auto_Close=1    "taglist 只显示当前文件 tag，其它文件的tag折叠。 
"let Tlist_Process_File_Always=0 "是否一直处理tags.1:处理;0:不处理 
"let Tlist_WinHeight &amp; Tlist_WinWidth    "可以设置taglist窗口的高度和宽度。 
"let Tlist_Use_Horiz_Window=1    "设置taglist窗口横向显示。

""""""""""""""""""""""""""""""
" => Tagbar (ctags)
""""""""""""""""""""""""""""""
set autochdir
nmap <Leader>tb :TagbarToggle<CR>
map <F3> :TagbarToggle<CR>
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 0
let g:tagbar_sort = 0
let g:tagbar_show_linenumbers = 1
let g:tagbar_autoshowtag = 1
"autocmd BufReadPost *.pl,*.py,*.cpp,*.c,*.h,*.hpp,*.cc,*.cxx :call tagbar#autoopen(1)
"autocmd VimEnter * nested :call tagbar#autoopen(1)    "打开vim时自动打开tagbar 


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Filetype generic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Todo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.todo so ~/vim_local/syntax/amido.vim

""""""""""""""""""""""""""""""
" => VIM
""""""""""""""""""""""""""""""
if has("autocmd") && v:version>600
	au BufRead,BufNew *.vim map <buffer> <leader><space> :w!<cr>:source %<cr>
endif

""""""""""""""""""""""""""""""
" => HTML related
""""""""""""""""""""""""""""""
" HTML entities - used by xml edit plugin
let xml_use_xhtml = 1
"let xml_no_auto_nesting = 1

"To HTML
let html_use_css = 0
let html_number_lines = 0
let use_xhtml = 1


""""""""""""""""""""""""""""""
" => Ruby & PHP section
""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
""Run the current buffer in python - ie. on leader+space
"au BufNewFile,BufRead *.py so ~/vim_local/syntax/python.vim
"au BufNewFile,BufRead *.py map <buffer> <leader><space> :w!<cr>:!python %<cr>
"au BufNewFile,BufRead *.py so ~/vim_local/plugin/python_fold.vim

""Set some bindings up for 'compile' of python
"au BufNewFile,BufRead *.py set makeprg=python -c "import py_compile,sys; sys.stderr=sys.stdout; py_compile.compile(r'%')"
"au BufNewFile,BufRead *.py set efm=%C %.%#,%A File "%f", line %l%.%#,%Z%[%^ ]%@=%m
"au BufNewFile,BufRead *.py nmap <buffer> <F8> :w!<cr>:make<cr>

""Python iMap
"au BufNewFile,BufRead *.py set cindent
"au BufNewFile,BufRead *.py ino <buffer> $r return
"au BufNewFile,BufRead *.py ino <buffer> $s self
"au BufNewFile,BufRead *.py ino <buffer> $c ##<cr>#<space><cr>#<esc>kla
"au BufNewFile,BufRead *.py ino <buffer> $i import
"au BufNewFile,BufRead *.py ino <buffer> $p print
"au BufNewFile,BufRead *.py ino <buffer> $d """<cr>"""<esc>O

""Run in the Python interpreter
"function! Python_Eval_VSplit() range
" let src = tempname()
" let dst = tempname()
" execute ": " . a:firstline . "," . a:lastline . "w " . src
" execute ":!python " . src . " > " . dst
" execute ":pedit! " . dst
"endfunction
"au BufNewFile,BufRead *.py vmap <F7> :call Python_Eval_VSplit()<cr>


""""""""""""""""""""""""""""""
" => Cheetah section
"""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""
" => Java section
"""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
"au BufNewFile,BufRead *.js so ~/vim_local/syntax/javascript.vim
"function! JavaScriptFold()
" set foldmethod=marker
" set foldmarker={,}
" set foldtext=getline(v:foldstart)
"endfunction
"au BufNewFile,BufRead *.js call JavaScriptFold()
"au BufNewFile,BufRead *.js imap <c-t> console.log();<esc>hi
"au BufNewFile,BufRead *.js imap <c-a> alert();<esc>hi
"au BufNewFile,BufRead *.js set nocindent
"au BufNewFile,BufRead *.js ino <buffer> $r return

"au BufNewFile,BufRead *.js ino <buffer> $d //<cr>//<cr>//<esc>ka<space>
"au BufNewFile,BufRead *.js ino <buffer> $c /**<cr><space><cr>**/<esc>ka


if has("eval") && has("autocmd")
	"vim 5.8.9 on mingw donot know what is <SID>, so I avoid to use function
	"c/cpp
	fun! Abbrev_cpp()
		ia <buffer> cci const_iterator
		ia <buffer> ccl cla
		ia <buffer> cco const
		ia <buffer> cdb bug
		ia <buffer> cde throw
		ia <buffer> cdf /** file<CR><CR>/<Up>
		ia <buffer> cdg ingroup
		ia <buffer> cdn /** Namespace <namespace<CR><CR>/<Up>
		ia <buffer> cdp param
		ia <buffer> cdt test
		ia <buffer> cdx /**<CR><CR>/<Up>
		ia <buffer> cit iterator
		ia <buffer> cns Namespace ianamespace
		ia <buffer> cpr protected
		ia <buffer> cpu public
		ia <buffer> cpv private
		ia <buffer> csl std::list
		ia <buffer> csm std::map
		ia <buffer> css std::string
		ia <buffer> csv std::vector
		ia <buffer> cty typedef
		ia <buffer> cun using Namespace ianamespace
		ia <buffer> cvi virtual
		ia <buffer> #i #include
		ia <buffer> #d #define
	endfunction

	fun! Abbrev_java()
		ia <buffer> #i import
		ia <buffer> #p System.out.println
		ia <buffer> #m public static void main(String[] args)
	endfunction

	fun! Abbrev_python()
		ia <buffer> #i import
		ia <buffer> #p print
		ia <buffer> #m if __name__=="__main__":
	endfunction

	fun! Abbrev_aspvbs()
		ia <buffer> #r Response.Write
		ia <buffer> #q Request.QueryString
		ia <buffer> #f Request.Form
	endfunction

	fun! Abbrev_js()
		ia <buffer> #a if(!0){throw Error(callStackInfo());}
	endfunction

	augroup abbreviation
		au!
		au FileType javascript :call Abbrev_js()
		au FileType cpp,c :call Abbrev_cpp()
		au FileType java :call Abbrev_java()
		au FileType python :call Abbrev_python()
		au FileType aspvbs :call Abbrev_aspvbs()
	augroup END
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <leader>m :%s/\r//g<CR>

"Paste toggle - when pasting something in, don't indent.
"set pastetoggle=<F3>

"Remove indenting on empty line
map <F2> :%s/s*$//g<cr>:noh<cr>''

"Super paste
ino <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"clipboard with xclip
if MySys() == "unix" 
	vmap <F6> :!xclip -sel c<CR>
	map <F7> :-1r!xclip -o -seln c<CR>'z
endif

inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap < <><ESC>i

"自动
"Only do this part when compiled with support for autocommands.
if has("autocmd")
    filetype plugin indent on " 开启插件
else
    set autoindent
endif "has("autocmd")






" 设置TList
let Tlist_Use_LEFT_Window=1
let Tlist_File_Fold_Auto_Close=1
let Tlist_Show_One_File=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Exit_OnlyWindow=1
let g:winManagerWindowLayout='FileExplorer'
nmap tl :Tlist<cr>

set cursorline " 突出显示当前行
"set ft=perl

"设定逗号为领航键
let mapleader=','
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:\zs<CR>
    vmap <Leader>a: :Tabularize /:\zs<CR>
endif

inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
    let p = '^\s*|\s.*\s|\s*$'
    if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
    endif
endfunction

" 使bell停止
set noeb vb t_vb=

"========================================================================
"php缩进
let PHP_autoformatcomment=1
"========================================================================
"

"==================================================================
"Latex Suite
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" NERDTree 快捷键绑定
nnoremap <silent> <F5> :NERDTree<CR>

"""""""""""""""""""
""Vundle 设置
"""""""""""""""""""
filetype off

"此处规定Vundle的路径
"set rtp+=$VIM/vimfiles/bundle/vundle/

"此处规定插件的安装路径
"call vundle#rc('$VIM/vimfiles/bundle/')

filetype plugin indent on " 开启插件
" let Vundle manage Vundle
" required! 
" Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
" github上的用户写的插件，使用这种用户名+repo名称的方式
" Bundle 'tpope/vim-fugitive'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
" vim-scripts repos
" vimscripts的repo使用下面的格式，直接是插件名称 
"Bundle 'Markdown'
"Bundle 'LaTeX-Suite-aka-Vim-LaTeX'

" non github reposo
" 非github的插件，可以直接使用其git地址
" Bundle 'git://git.wincent.com/command-t.git'
" ...
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
" vundle主要就是上面这个四个命令，例如BundleInstall是全部重新安装，BundleInstall!则是更新
" 一般安装插件的流程为，先BundleSearch一个插件，然后在列表中选中，按i安装
" 安装完之后，在vimrc中，添加Bundle 'XXX'，使得bundle能够加载这个插件，同时如果
" 需要配置这个插件，也是在vimrc中设置即可
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
 
"python Markdown
nnoremap <F8> :!cmd /c c:\Python27\python c:\Python27\Scripts\markdown.py %:t -e chinese > %:r.html<CR> 
noremap \e  :!cmd /c start ./%:r.html<CR>  

""""""""""""""""""""
"vim-Markdown
""""""""""""""""""""
autocmd BufNewFile,BufRead *.md set nofoldenable
"disable folding configuration
let g:vim_markdown_folding_disabled=1
"LaTeX math
let g:vim_markdown_math=1
"YAML frontmatter
let g:vim_markdown_frontmatter=1


"C-S保存
map <C-s> :w<CR>
imap <C-s> <C-o>:w<CR>
nmap <C-S> :update<CR>
vmap <C-S> <C-C>:update<CR>
imap <C-S> <C-O>:update<CR>

"Tab自动补全
let g:SuperTabRetainCompletionType = 2
let g:SuperTabDefaultCompletionType = "context" 

set ignorecase smartcase " 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感

"修改VIM环境环境变量$VIM,可通过:echo $VIM查看。一般windows下默认为vim安装目录和home文件夹，而linux则为home文件夹下。
"setenv VIM /home/...

" 用户目录变量$VIMFILES
if MySys() == "win32"
let $VIMFILES = $VIM.'/vimfiles'
elseif MySys() == "linux"
let $VIMFILES = $HOME.'/Programs/vim.linux'
endif

" 设定doc文档目录
let helptags=$VIMFILES.'/doc'

" Buffers操作快捷方式!
nnoremap <C-RETURN> :bnext<CR>
nnoremap <C-S-RETURN> :bprevious<CR>

" Tab操作快捷方式!
nnoremap <C-TAB> :tabnext<CR>
nnoremap <C-S-TAB> :tabprev<CR>

"关于tab的快捷键
" map tn :tabnext<cr>
" map tp :tabprevious<cr>
" map td :tabnew .<cr>
" map te :tabedit
" map tc :tabclose<cr>

" Python 文件的一般设置，比如不要 tab 等
autocmd FileType python set tabstop=4 shiftwidth=4 expandtab
autocmd FileType python map <F12> :!python %<CR>

"-----------------------------------------------------------------
" plugin – ZenCoding.vim 很酷的插件，HTML代码生成
" 插件最新版：http://github.com/mattn/zencoding-vim
" 常用命令可看：http://nootn.com/blog/Tool/23/
"-----------------------------------------------------------------

"-----------------------------------------------------------------
" plugin - NeoComplCache.vim 自动补全插件
"-----------------------------------------------------------------
" Disable AutoComplPop.
"let g:acp_enableAtStartup = 0
" Use neocomplcache.
"let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
"let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
"let g:neocomplcache_min_syntax_length = 3
"let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
"let g:neocomplcache_enable_quick_match = 1
"inoremap   pumvisible() ? neocomplcache#close_popup() . "\" : "\"



:inoremap ( ()<ESC>i
:inoremap ) <c-r>=ClosePair(')')<CR>
:inoremap { {}<ESC>i
:inoremap } <c-r>=ClosePair('}')<CR>
:inoremap [ []<ESC>i
:inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>
"inoremap " <c-r>=QuoteDelim('"')<CR>
"inoremap ' <c-r>=QuoteDelim("'")<CR>


function ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
      return "\<Right>"
  else
      return a:char
  endif
endfunction

function QuoteDelim(char)
    let line = getline('.')
    let col = col('.')
    if line[col - 2] == "//"
        "Inserting a quoted quotation mark into the string
        return a:char
    elseif line[col - 1] == a:char
        "Escaping out of the string
        return "\<Right>"
    else
        "Starting a string
        return a:char.a:char."\<Esc>i"
    endif
endf



"-----------------------------------------------------------------
" plugin - matchit.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" % 正向匹配 g% 反向匹配
" [% 定位块首 ]% 定位块尾
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin - vcscommand.vim 对%命令进行扩展使得能在嵌套标签和语句之间跳转
" SVN/git管理工具
"-----------------------------------------------------------------


"-----------------------------------------------------------------
" plugin – a.vim
"-----------------------------------------------------------------

"change word to uppercase, I love this very much  
inoremap <C-u> <esc>gUiwea "把插入模式下插入的单词大写

"jj to Esc
imap jj <ESC>
imap ff <ESC>

"shortkey to git

function! GitStatusView()
exec "!git status"
endfunction
nnoremap ,gs : call GitStatusView()<CR>
inoremap ,gs : call GitStatusView()<CR>
vnoremap ,gs : call GitStatusView()<CR>

function! GitAddAll()
exec "!git add -A"
endfunction
nnoremap ,ga : call GitAddAll()<CR>
inoremap ,ga : call GitAddAll()<CR>
vnoremap ,ga : call GitAddAll()<CR>

function! GitCommitMessage()
exec "!git commit -m update"
endfunction
nnoremap ,gc : call GitCommitMessage()<CR>
inoremap ,gc : call GitCommitMessage()<CR>
vnoremap ,gc : call GitCommitMessage()<CR>

function! GitPushAll()
exec "!git push"
endfunction
nnoremap ,gp : call GitPushAll()<CR>
inoremap ,gp : call GitPushAll()<CR>
vnoremap ,gp : call GitPushAll()<CR>



" 调用perltidy整理源代码
nnoremap ,pt :%!perltidy<CR>
vnoremap ,pt :!perltidy<CR>

"md2html
function! ToHtml()
exec 'w'
exec "!pandoc --ascii % -o %<.html"
endfunction
nnoremap ,m2h :call ToHtml()<CR>
vnoremap ,m2h :call ToHtml()<CR>
inoremap ,m2h :call ToHtml()<CR>

"md2htmlby book.css and perl
function! MDToHtml()
exec 'w'
exec "!perl D:\\Program\\tools\\trans.md.to.html.by.bookcss.pl -in %"
endfunction
nnoremap ,mh :call MDToHtml()<CR>
vnoremap ,mh :call MDToHtml()<CR>
inoremap ,mh :call MDToHtml()<CR>

"md2pdf
function! ToPdf()
exec 'w'
exec "!pandoc % -o %<.pdf --latex-engine=xelatex --template=md2pdf.cn.latex"
endfunction
nnoremap ,mp :call ToPdf()<CR>
vnoremap ,mp :call ToPdf()<CR>
inoremap ,mp :call ToPdf()<CR>
:nmap <silent> <F10> :call ToPdf()<CR>

"Pydiction
let g:pydiction_location = $VIM.'/vimfiles/ftplugin/Python/complete-dict'

"pymode
"let g:pymode = 1
"let g:pymode_warnings = 1
"let g:pymode_options = 1
"let g:pymode_options_max_line_length = 79
"    setlocal complete+=t
"    setlocal formatoptions-=t
"    if v:version > 702 && !&relativenumber
"        setlocal number
"    endif
"    setlocal nowrap
"    setlocal textwidth=79
"    setlocal commentstring=#%s
"    setlocal define=^\s*\\(def\\\\|class\\)
"let g:pymode_python = 'python3'
"let g:pymode_indent = 1
"let g:pymode_folding = 1
"let g:pymode_doc = 1
"let g:pymode_syntax = 1

"SnipMate
"let loaded_snips = 1
let g:snippets_dir = $VIM.'/vimfiles/snippets/'
let g:snips_author = "Guo Changjiang"
