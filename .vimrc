" =====================================================
" Plugins Manager
" =====================================================
set nocompatible
filetype plugin on
syntax on

set laststatus=2
set ttyfast
set undofile
set noshowmode

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"--------------=== Navigation ===---------------
Plugin 'scrooloose/nerdtree'
Plugin 'szw/vim-tags'
Plugin 'majutsushi/tagbar'

"--------------=== Languages support ===---------------
"--- Universal ---
Plugin 'dense-analysis/ale'		" подсветка ошибок
Plugin 'maralla/completor.vim'
Plugin 'jiangmiao/auto-pairs'		" автодополнение скобок
Plugin 'mbbill/undotree'		" дерево изменений файла в vim
Plugin 'RRethy/vim-illuminate'

" - Git -
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'airblade/vim-gitgutter'
Plugin 'junegunn/gv.vim'

"--- Python ---
Plugin 'klen/python-mode'	        " Python mode (docs, refactor, lints, highlighting, run and ipdb and more)
Plugin 'davidhalter/jedi-vim' 		" Jedi-vim autocomplete plugin
Plugin 'mitsuhiko/vim-jinja'		" Jinja support for vim

" --- Docker ---
Plugin 'ekalinin/Dockerfile.vim'

" --- LaTeX ---
Plugin 'lervag/vimtex'
Plugin 'KeitaNakamura/tex-conceal.vim'

"--------------=== Snippets support ===---------------
Plugin 'SirVer/ultisnips'
Plugin 'garbas/vim-snipmate'		" Snippets manager
Plugin 'MarcWeber/vim-addon-mw-utils'	" dependencies #1
Plugin 'tomtom/tlib_vim'		" dependencies #2
Plugin 'honza/vim-snippets'		" snippets repo

"--------------=== Other ===---------------
Plugin 'lifepillar/vim-cheat40'
Plugin 'rosenfeld/conque-term'      	" Consoles as buffers

Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'fisadev/FixedTaskList.vim'      " Pending tasks list

Plugin 'tpope/vim-surround'             " Parentheses, brackets, quotes, XML tags, and more
Plugin 'tpope/vim-fugitive'		" git on airline
Plugin 'tpope/vim-repeat'		" Repeat plugin by dot command
Plugin 'tpope/vim-commentary'           " Simple commentary

Plugin 'powerman/vim-plugin-ruscmd'     " русификатор команд
Plugin 'dracula/vim'

Plugin 'VundleVim/Vundle.vim'

call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"=====================================================
" General Settings
"=====================================================
set t_Co=256
syntax on
let g:dracula_italic = 1
let g:dracula_colorterm = 0
colorscheme dracula
highlight Normal ctermbg=NONE
set termguicolors
"hi Normal guibg=NONE ctermbg=NONE

set number
set relativenumber
set path+=**		" search for every subdirectory
set nowrap
set nobackup
set noundofile
set nowritebackup
set encoding=utf8
set fileencoding=utf8
set mousehide
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set autoindent		" always set autoindenting on
set scrolloff=999       " cursor on center
set wildmenu		" show all matching files after Tab
set wcm=<Tab>
set foldnestmax=2

let g:auto_save = 1

" --- Search ---
set hlsearch
set incsearch
set ignorecase
set smartcase

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" The matchit plugin makes the % command work better, but it is not backwards compatible.
packadd matchit
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set scrolloff=999       " курсор по центру


" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" настройки Vim-Airline
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline_theme = 'dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

"====[ Open any file with a pre-existing swapfile in readonly mode "]=========
augroup NoSimultaneousEdits
    autocmd!
    autocmd SwapExists * let v:swapchoice = 'o'
    autocmd SwapExists * echomsg ErrorMsg
    autocmd SwapExists * echo 'Duplicate edit session (readonly)'
    autocmd SwapExists * echohl None
    autocmd SwapExists * sleep 2
augroup END

"=====================================================
" Keys Bindings
"=====================================================
" ===== Nerd Tree Options =====
" close Nerd Tree if it is a last opened window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" показать NERDTree на F2
map <F2> :NERDTreeToggle<CR>
"игноррируемые файлы с расширениями (python, latex)
let NERDTreeIgnore=['\~$', '\.pyc$', '\.pyo$', '\.class$', 'pip-log\.txt$', '\.o$',
\ '\.aux$', '\.bbl$', '\.bcf$', '\.blg$', '\.pdf$', '\.toc$', '\.log$',
\ '\.gz$', '\.run*']

" ===== TagBar  =====
map <F3> :TagbarToggle<CR>
let g:tagbar_autofocus = 0      " автофокус на Tagbar при открытии

" === TaskList ===
map <F4> :TaskList<CR>

" === Git Fugitive ===
nnoremap <F5> :Gstatus<CR>

" === ConqueTerm ===
" запуск интерпретатора на F6
nnoremap <F6> :ConqueTermSplit ipython3<CR>

" === Undotree ===
nnoremap <F7> :UndotreeToggle<CR>

" === Spell check ===
menu SetSpell.ru  :set spl=ru spell<CR>
menu SetSpell.en  :set spl=en spell<CR>
menu SetSpell.off :set nospell<CR>
map <F8> :emenu SetSpell.<Tab>
imap <F9> <Esc> z=<CR>i
map <F9> z=<CR>

"=== Escape insert mode via 'jj' ===
imap jj <ESC>

" автокомплит через <Ctrl+Space>
inoremap <C-space> <C-x><C-o>

"=====================================================
" Snippets Settings
"=====================================================
" указываем каталог с настройками SnipMate
:let g:snippets_dir = "~/.vim/vim-snippets/snippets"

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-h>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsUsePythonVersion = 3

" Моя подпись
if !exists("g:snips_author")
    let g:snips_author = "AleNriG"
endif

if !exists("g:snips_email")
    let g:snips_email = "agorokhov94@gmail.com"
endif

if !exists("g:snips_github")
    let g:snips_github = "https://github.com/alenrig"
endif


"=====================================================
" Languages support
"=====================================================
" при переходе за границу в 90 символов в Ruby/Python/js/C/C++ подсвечиваем на темном фоне текст
 augroup vimrc_autocmds
     autocmd!
     autocmd FileType python,c,cpp,sh,java highlight Excess ctermbg=DarkGrey guibg=Black
     autocmd FileType python,c,cpp,sh,java match Excess /\%90v.*/
     autocmd FileType python,c,cpp,sh,java set nowrap
     autocmd FileType python,c,cpp,sh,java set foldmethod=indent
 augroup END

" --- Syntastic ---
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0

" --- ALE ---
" let b:ale__python_flake8_options = '--ignore F403 F405'
let g:ale_python_auto_pipenv = 1


"=================================
" Python settings
"=================================

autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=8
\ formatoptions+=croq softtabstop=4 smartindent
\ cinwords=if,elif,else,for,while,try,except,finally,def,class,with
autocmd FileType pyrex setlocal expandtab shiftwidth=4 tabstop=8
\softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with

" ====== Python Mode ======
" отключаем автокомплит по коду (у нас вместо него используется jedi-vim)
let g:pymode_python='python3'
let g:pymode_rope = 0
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" документация
let g:pymode_doc = 0
let g:pymode_doc_key = 'K'
" проверка кода
let g:pymode_lint = 0
let g:pymode_lint_checker = "pyflakes,pep8, pycodestyle"
let g:pymode_lint_ignore="E501,W601,C0110"
" провека кода после сохранения
let g:pymode_lint_write = 0

" поддержка virtualenv
let g:pymode_virtualenv = 1

" установка breakpoints
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_key = '<leader>b'

" подстветка синтаксиса
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_options_colorcolumn = 0

" отключить autofold по коду
let g:pymode_folding = 0

" возможность запускать код
let g:pymode_run = 0

" ====== Jedi Vim ======
" Disable choose first function/method at autocomplete
let g:jedi#popup_select_first = 0
let g:jedi#force_py_version = 3


"=================================
" LaTeX settings
"=================================
autocmd FileType tex setlocal expandtab shiftwidth=4 tabstop=8 textwidth=90
\ smartindent updatetime=1
let g:tex_flavor='latex'
set conceallevel=2
let g:tex_conceal="abdgm"

"=================================
" Shell settings
"=================================
autocmd FileType sh setlocal expandtab shiftwidth=4 tabstop=8
\ softtabstop=4 smartindent

"=================================
" RST settings
"=================================
autocmd FileType rst setlocal expandtab shiftwidth=2 tabstop=4
\ softtabstop=2 smartindent

"=================================
" YML settings
"=================================
autocmd FileType yaml setlocal expandtab shiftwidth=2 tabstop=4
\ softtabstop=2 smartindent
