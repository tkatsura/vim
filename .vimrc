" vimとして起動
set nocompatible

" シンタックスをON
syntax on

" 行番号を表示する
set number

" ファイルのタイトルを表示する
set title

" 括弧入力時の対応する括弧を表示
set showmatch

" バックアップを作らない
set nobackup

" 文字コードの設定
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set fileformat=unix

" 全角記号の調整
set ambiwidth=double

" 他で書き換えられたら自動で読み直す
set autoread

" スワップファイルを作らない
set noswapfile

" 自動インデント
"set smartindent
"set paste
" オートインデントを無効にする?
"set noautoindent
"set nosmartindent

" 入力中のコマンドを右下に表示
set showcmd

" 検索結果をハイライト表示
set hlsearch

" カラースキーム
colorscheme desert

" タブ入力時半角スペース２に変換
"set expandtab
set softtabstop=2

" ステータスラインの設定
set cmdheight=1
set laststatus=2
set statusline=%<%f\%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=%l,%c%V%8P

" 全角スペース・行末のスペース・タブの可視化
set list
set listchars=tab:__,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
if has("syntax")
    syntax on
    syn sync fromstart
    function! ActivateInvisibleIndicator()
        syntax match InvisibleJISX0208Space "　" display containedin=ALL
        highlight InvisibleJISX0208Space term=underline ctermbg=Blue guibg=darkgray gui=underline
    endf
    augroup invisible
        autocmd! invisible
        autocmd BufNew,BufRead * call ActivateInvisibleIndicator()
    augroup END
endif

" 最後にカーソルがあった場所に移動
augroup vimrcEx
  au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
  \ exe "normal g`\"" | endif
augroup END

set tabstop=2
set shiftwidth=2
"highlight tabSpace cterm=underline ctermfg=Blue guifg=Blue
"au BufRead,BufNew * match tabSpace / /

" jjをescに割り当てる
"inoremap <silent> jj <ESC>
"inoremap <silent> <C-j> j
"動かない

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

"if has('lua')
"  NeoBundleLazy 'Shougo/neocomplete.vim', {
"    \ 'depends' : 'Shougo/vimproc',
"    \ 'autoload' : { 'insert' : 1,}
"    \ }
"endif
"
""neocomplete {{{
"let g:neocomplete#enable_at_startup               = 1
"let g:neocomplete#auto_completion_start_length    = 3
"let g:neocomplete#enable_ignore_case              = 1
"let g:neocomplete#enable_smart_case               = 1
"let g:neocomplete#enable_camel_case               = 1
"let g:neocomplete#use_vimproc                     = 1
"let g:neocomplete#sources#buffer#cache_limit_size = 1000000
"let g:neocomplete#sources#tags#cache_limit_size   = 30000000
"let g:neocomplete#enable_fuzzy_completion         = 1
"let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
"" }}}

" ファイルオープンを便利に
"NeoBundle 'Shougo/unite.vim'
" バッファ一覧
"noremap <C-P> :Unite buffer<CR>
" ファイル一覧
"noremap <C-N> :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
"noremap <C-Z> :Unite file_mru<CR>
" Unite.vimで最近使ったファイルを表示できるようにする
"NeoBundle 'Shougo/neomru.vim'
" ...省略

" 構文エラーチェック
NeoBundle "scrooloose/syntastic"
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

" インデントに色を付けて見やすくする
"NeoBundle 'nathanaelkane/vim-indent-guides'
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
"let g:indent_guides_enable_on_vim_startup = 1


call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
""""""""""""""""""""""""""""""

