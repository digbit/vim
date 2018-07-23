"
" +-----------------------------------------+
" |  A programmer should know their tools.  |
" +-----------------------------------------+
"           o
"             o    ^__^
"               o  (oo)\_______
"                 (__)\       )\/\
"                     ||----w |
"                     ||     ||
"
"
"Last Change:2017年10月11日
"
"Version:1.5
"
" Preset:
" vim8 + Python3 + Lua
"  ----------------------
"  git clone https://github.com/vim/vim.git
"  ----------------------

"  apt-get install lua5.1
"  apt install luarocks
"  或
"  brew install lua
"
"  python3.7-config --configdir
"
"  python2-config-dir="/usr/lib/python2.7/config-x86_64-linux-gnu/"
"  python3-config-dir="/usr/local/lib/python3.6/config-3.6m-x86_64-linux-gnu/"
"  或
"  python2-config-dir="/usr/lib/python2.7/config/"
"  python3-config-dir="/Library/Frameworks/Python.framework/Versions/3.7/lib/python3.7/config-3.7m-darwin/"
"
"
"  ./configure \
"  --with-features=huge \
"  --enable-multibyte \
"  --enable-rubyinterp=yes \
"  --enable-pythoninterp=yes \
"  --with-python-config-dir=$python2-config-dir \
"  --enable-python3interp=yes \
"  --with-python3-config-dir=$python3-config-dir \
"  --enable-perlinterp=yes \
"  --enable-luainterp=yes \
"  --with-lua-prefix=/usr/local \
"  --prefix=/usr
"
"  设置环境
"  make VIMRUNTIMEDIR=/usr/share/vim/vim81
"  安装
"  make install
"
"  ----------------------
"  For Mac / cmd+r / csrutil disable 才能覆盖 /usr/bin/vim
"  ----------------------
"  安装 plug插件和 设置文件夹
" 1: curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" 2: ~/.vimundo/  and ~/.vimbackup/
"  pip -> pip3.6
" 3:
" pip install flake8
" pip install yapf
" npm install -g js-beautify
"
" Vue 编辑语法检查 FOR Plugin 'posva/vim-vue'
"
" npm i -g eslint eslint-plugin-vue
"
"
" 4: ale luacheck -> luarocks install luacheck
"
" 5: install youcompleteme
" git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/vim_plugin/YouCompleteMe
" cd ~/.vim/vim_plugin/YouCompleteMe
" git submodule update --init --recursive
" 编译
" apt-get install build-essential cmake
" cd .vim/vim_plugin/YouCompleteMe/
" ./install.py --clang-completer --system-libclang
"  ----------------------
" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line, Folding
"    -> Editing mappings
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> VIM Plugin and Settings
"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 解决兼容性问题
set nocompatible
" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
command W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif


" Add a bit extra margin to the left
set foldcolumn=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set backup                  " Backups are nice ...
set backupext=.bak
set backupdir=~/.vimbackup/
if has('persistent_undo')
    set undodir=~/.vimundo/
    set undofile                " So is persistent undo ...
    set undolevels=1000         " Maximum number of changes that can be undone
    set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set clipboard+=unnamed  "访问系统剪贴板

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  / (search) and  ? (backwards search)

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line and Folding
""""""""""""""""""""""""""""""
"状态栏相关
set laststatus=2       "显示状态栏（默认值为1，无法显示状态栏）
set showtabline=2
set statusline=\ %<%F[%1*%M%*%n%R%H]%=\ %y\ %0(%{&fileformat}\ %{&encoding}\ %c:%l/%L%)\             "设置在状态行显示的信息

" Fold Setting
" set foldmethod=syntax  "设置语法折叠
" set foldmethod=marker  "设置手动折叠
set foldmethod=indent  "设置缩进折叠
" set foldcolumn=1       "设置折叠区域的宽度
set foldcolumn=0       "设置折叠区域的宽度
setlocal foldlevel=1   "设置折叠层数为...
" set foldclose=all      "设置为自动关闭折叠
" nnoremap <space> @=((foldclosed(line('.'))<0) ? 'zc' : 'zo')<CR>
"用空格键来开关折叠

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 11 ^
map 00 g$

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
    nmap <D-j> <M-j>
    nmap <D-k> <M-k>
    vmap <D-j> <M-j>
    vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function StripTrailingWhite()
    let l:winview = winsaveview()
    silent! %s/\s\+$//
    call winrestview(l:winview)
endfunction

autocmd BufWritePre,FileAppendPre,FileWritePre,FilterWritePre * :call StripTrailingWhite()

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM Plugin and Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Vim-Plugin Manager
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/vim_plugin')

" Make sure using single quotes
" Shorthand notation for full URL.
Plug 'junegunn/seoul256.vim'

Plug 'scrooloose/nerdtree'				"文件树浏览
Plug 'tpope/vim-fugitive'               "管理 Git 仓库

Plug 'w0rp/ale'							"异步语法检查

Plug 'fatih/vim-go'                     "go 代码开发环境的的插件
Plug 'SirVer/ultisnips'					"代码块补全
Plug 'honza/vim-snippets'				"配合 ultisnips

Plug 'chiel92/vim-autoformat'			"自动格式化代码
Plug 'Yggdroot/indentLine'				"自动显示缩进线

Plug 'scrooloose/nerdcommenter'			"批量、快速注释
Plug 'easymotion/vim-easymotion'		"快速查找定位
Plug 'junegunn/vim-easy-align'          "对齐排版工具

Plug 'skywind3000/asyncrun.vim'         "异步后台编译运行

Plug 'plasticboy/vim-markdown'          "高亮 Markdown, 依赖 tabular
Plug 'iamcco/markdown-preview.vim'      "实时预览 Markdown
Plug 'tpope/vim-surround'               "符号对补齐
Plug 'mhinz/vim-startify'               "启动界面

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" On-damand loading of plugins
function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
        !./install.py --clang-completer --go-completer
    endif
endfunction
Plug 'Valloric/YouCompleteMe', { 'for' : [ 'python', 'go' ], 'do': function('BuildYCM') }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }   "强大的文件搜索
Plug 'junegunn/fzf.vim'

" Vue edit
Plug 'posva/vim-vue'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => seoul256
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    colo seoul256
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => 在打开文件的同时，自动切换当前路径; 打开/tmp文件夹下的文件时不自动切换.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufEnter * if expand("%:p:h") !~ '^/tmp' | silent! lcd %:p:h | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__','\.pyo$']
let g:NERDTreeWinSize=35
let NERDTreeChDirMode = 2
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1

" Open NERDTree on startup, when no file has been specified
autocmd VimEnter * if !argc() | NERDTree | endif

map <C-e> :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>ale
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>'

let g:ale_statusline_format = ['⨉ %d', '⚠ %d', '⬥ ok']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

nmap <silent> <Leader>ep <Plug>(ale_previous_wrap)
nmap <silent> <Leader>en <Plug>(ale_next_wrap)

nnoremap <silent> <Leader>ec :ALEToggle<CR>

" troggle quickfix list
function! ToggleErrors()
    let old_last_winnr = winnr('$')
    lclose
    if old_last_winnr == winnr('$')
        " Nothing was closed, open syntastic_error location panel
        lopen
    endif
endfunction
nnoremap <Leader>s :call ToggleErrors()<cr>

let g:ale_set_highlights = 1
highlight clear ALEErrorSign
highlight clear ALEWarningSign


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>YCM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"youcompleteme  默认tab  s-tab 和自动补全冲突
let g:ycm_key_list_select_completion=['<C-n>']
"let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion=['<C-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全
let g:ycm_use_ultisnips_completer = 1 "提示UltiSnips
let g:ycm_collect_identifiers_from_comments_and_strings = 1   "注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_tags_files = 1
"python解释器路径"
let g:ycm_python_binary_path = '/usr/local/bin/python3'

" 开启语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 回车作为选中
let g:ycm_key_list_stop_completion = ['<CR>']

"let g:ycm_seed_identifiers_with_syntax=1   "语言关键字补全, 不过python关键字都很短，所以，需要的自己打开

" 跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
let g:ycm_register_as_syntastic_checker = 0
" nnoremap <leader>jd :YcmCompleter GoToDefinition<CR>
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

" 引入，可以补全系统，以及python的第三方包 针对新老版本YCM做了兼容
let g:ycm_global_ycm_extra_conf = "~/.vim/vim_plugin/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"

" 直接触发自动补全 insert模式下
" let g:ycm_key_invoke_completion = '<C-Space>'
" 黑名单,不启用
let g:ycm_filetype_blacklist = {
            \ 'tagbar' : 1,
            \ 'gitcommit' : 1,
            \}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ultisnips
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsSnippetDirectories  = ['UltiSnips']
let g:UltiSnipsSnippetsDir = '~/.vim/UltiSnips'
" 定义存放代码片段的文件夹 .vim/UltiSnips下，使用自定义和默认的，将会的到全局，有冲突的会提示
" 进入对应filetype的snippets进行编辑
map <leader>us :UltiSnipsEdit<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  Autoformat
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 插件会自动设置这两项，yapf 的优势在于代码风格的可定制性。
" google, facebook, chromium.
let g:formatter_yapf_style='pep8'
let g:autoformat_autoindent=0
let g:autoformat_retab=0
let g:autoformat_remove_trailing_spaces=0
autocmd FileType vim,tex let b:autoformat_autoindent=0
au BufWrite * :Autoformat
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>  IndentLine
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:indentLine_setConceal = 0
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#616161'
nmap <leader>i :IndentLinesToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerdcommenter
" <leader>cc   加注释
" <leader>cu   解开注释
"
" <leader>c<space>  加上/解开注释, 智能判断
" <leader>cy   先复制, 再注解(p可以进行黏贴)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>Easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 跨窗口搜索一（两）个字母
map f <Plug>(easymotion-overwin-f)
map s <Plug>(easymotion-overwin-f2)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>vim-easy-align
" ,a=        对齐等号表达
" ,a:        对齐冒号表达式(json/map等)
"
" # 默认左对齐
" ,a<space>  首个空格对齐
" ,a2<space> 第二个空格对齐
" ,a-<space> 倒数第一个空格对齐
" ,a-2<space> 倒数第二个空格对齐
" ,a*<space> 所有空格依次对齐
"
" # 右对齐
" ,a<Enter>*<space>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <Leader>a <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
if !exists('g:easy_align_delimiters')
    let g:easy_align_delimiters = {}
endif
let g:easy_align_delimiters['#'] = { 'pattern': '#', 'ignore_groups': ['String'] }

xmap <Leader>ga   <Plug>(LiveEasyAlign)


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>AsyncRun
" Ctrl d , 执行
" Ctrl f , 折叠输出
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
imap <C-d> <Esc>:call <SID>compile_and_run()<CR>
nmap <C-d> :call <SID>compile_and_run()<CR>
function! s:compile_and_run()
    exec 'w'
    if &filetype == 'fortran'
        exec "AsyncRun! mpifort % -o %< -qopenmp -fpp -mkl; time ./%<"
    elseif &filetype == 'c'
        exec "AsyncRun! gcc % -o %<; time ./%<"
    elseif &filetype == 'cpp'
        exec "AsyncRun! g++ -std=c++11 % -o %<; time ./%<"
    elseif &filetype == 'java'
        exec "AsyncRun! javac %; time java /%<"
    elseif &filetype == 'sh'
        exec "AsyncRun! time bash %"
    elseif &filetype == 'python'
        exec "AsyncRun! python3 %"
    elseif &filetype == 'tex'
        exec "VimtexCompile"
    elseif &filetype == 'lua'
        exec "AsyncRun! lua %"
    elseif &filetype == 'go'
        exec "GoRun! %"
    endif
endfunction
map <C-f> :AsyncStop<CR>
" bind <F9> to open quickfix window rapidly.
nmap <C-a> :call asyncrun#quickfix_toggle(10)<cr>
" like Emacs, use <M-x> to type commands.
set timeoutlen=500 ttimeoutlen=100
exec "set <M-x>=\ex"
imap <M-x> <Esc>:AsyncRun
nmap <M-x> :AsyncRun
" ring bell when finished.
let g:asyncrun_bell = 1
" open quickfix window in right way.
" augroup ASYNCRUN
"     autocmd QuickFixCmdPost * botright copen 8
"     " autocmd User AsyncRunStart * call asyncrun#quickfix_toggle(8,1)
" augroup END
augroup vimrc
    autocmd QuickFixCmdPost * call asyncrun#quickfix_toggle(10,1)
augroup END
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => FZF and FZF-VIM
" 推荐安装ag
" https://github.com/ggreer/the_silver_searcher
" brew install the_silver_searcher
" 安装
" git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
" ~/.fzf/install
" 升级
" cd ~/.fzf && git pull && ./install
" 在终端直接 Ctrl-t 调出当前查找窗口, 或者 fzf --preview 'cat {}'
"
" 在finder（输出交换窗口）里，
" Ctrl-J/Ctrl-K/Ctrl-N/Ctrlk-N可以用来将光标上下移动
" Enter键用来选中条目， Ctrl-C/Ctrl-G/Esc用来退出
" 在多选模式下（-m), TAB和Shift-TAB用来多选
" Mouse: 上下滚动， 选中， 双击； Shift-click或shift-scoll用于多选模式
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null || tree -C {}"'
" nnoremap <silent> <Leader><Leader> :Files<CR>
" nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <expr> <C-g>  (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader>ac        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
nnoremap <silent> <Leader>`        :Marks<CR>
nnoremap <silent> q: :History:<CR>
nnoremap <silent> q/ :History/<CR>

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

command! Plugs call fzf#run({
            \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
            \ 'options': '--delimiter / --nth -1',
            \ 'down':    '~40%',
            \ 'sink':    'Explore'})

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" =>Surround
" "Hello world!"
" Press cs"' inside
" 'Hello world!'
" cs'<q>
" <q>Hello world!</q>
" To go full circle, press cst" to get
"Hello world!"
" To remove the delimiters entirely, press ds".
" Hello world!
" press ysiw] (iw is a text object)
" [Hello] world!
" cs]{
" Now wrap the entire line in parentheses with yssb or yss).
" ({ Hello } world!)
" Finally, let's try out visual mode. Press a capital V (for linewise visual mode) followed by S<p class="important">.
" <p class="important">
"   <em>Hello</em> world!
" </p>
" ds, cs, yss
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Startify
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:startify_custom_header = ['   世上万物，非我所有，为我所用！']

let g:startify_list_order = [
            \ ['   Recent Files:'],
            \ 'files',
            \ ['   Project:'],
            \ 'dir',
            \ ['   Sessions:'],
            \ 'sessions',
            \ ['   Bookmarks:'],
            \ 'bookmarks',
            \ ['   Commands:'],
            \ 'commands',
            \ ]
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vue
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType vue syntax sync fromstart
let g:vue_disable_pre_processors=1
" Set indent size = 2 for web stuff
autocmd FileType javascript,html,css,yaml,vue setlocal expandtab shiftwidth=2 softtabstop=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Go 开发
" 安装Gocode
" -----------setup gocode--------
"go get -u github.com/nsf/gocode
"gocode默认安装到$GOPATH/bin下面。

" 配置Gocode
"~ cd $GOPATH/src/github.com/nsf/gocode
"~ go build
"~ go install
" -----------setup vim--------
"  cd $GOPATH/src/github.com/nsf/gocode/vim/
"~ ./update.bash
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType go nmap <Leader>co <Nop>
autocmd FileType go nmap <Leader>c <Plug>(go-coverage-toggle)
" note: just use 'gd' for go-def
" autocmd FileType go nmap <Leader>df <Plug>(go-def)
let g:go_fmt_fail_silently = 1
let g:go_snippet_case_type = "camelcase"
let g:go_highlight_types = 1
" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
    let l:file = expand('%')
    if l:file =~# '^\f\+_test\.go$'
        call go#cmd#Test(0, 1)
    elseif l:file =~# '^\f\+\.go$'
        call go#cmd#Build(0)
    endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <Leader>f <Plug>(go-referrers)
