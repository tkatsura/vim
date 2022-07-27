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

" コマンドの保存数を設定する(デフォルトは20)
set history=100

" 入力中のコマンドを右下に表示
set showcmd

" 検索結果をハイライト表示
set hlsearch

" カラースキーム
colorscheme desert

" 上記のカラースキームでは対応できなくなったので追加
augroup TransparentBG
  autocmd!
  autocmd Colorscheme * highlight Normal ctermbg=none
  autocmd Colorscheme * highlight NonText ctermbg=none
  autocmd Colorscheme * highlight LineNr ctermbg=none
  autocmd Colorscheme * highlight Folded ctermbg=none
  autocmd Colorscheme * highlight EndOfBuffer ctermbg=none 
augroup END

" ペーストモード
"set paste

" バックスペースの有効化
set backspace=indent,eol,start

" 自動インデント
"set autoindent
set smartindent

" オートインデントを無効にする?
"set noautoindent
set nosmartindent

" タブ入力時半角スペース２に変換
"set noexpandtab
set expandtab

"連続した空白に対してタブキーやバックスペースでカーソルが動く幅
set softtabstop=2

" 画面上でタブ文字が締める幅
set tabstop=2

" 自動インデントでずれる幅
set shiftwidth=2

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
"highlight tabSpace cterm=underline ctermfg=Blue guifg=Blue
"au BufRead,BufNew * match tabSpace / /

" insertモードから抜ける
inoremap <silent> jj <ESC>

" 挿入モードでのカーソル移動
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

" 入力後カーソルを移動
"imap {} {}<LEFT>
"imap [] []<LEFT>
"imap () ()<LEFT>
"imap '' ''<LEFT>
"imap "" ""<LEFT>
"imap <?php <?php  ?><LEFT><LEFT><LEFT>

" vimdiffの色設定
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" ローカル専用の設定
if filereadable(expand('~/.vim/.vimrc.local'))
  source ~/.vim/.vimrc.local
endif

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

"call dein#add('Shougo/neocomplete.vim')
"call dein#add('Shougo/neomru.vim')
"call dein#add('Shougo/neosnippet')

" 自動整形プラグイン
call dein#add('junegunn/vim-easy-align')

" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" }}}

" 構文エラーチェック
call dein#add('scrooloose/syntastic')
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2

call dein#end()

" Required:
"filetype plugin indent on
syntax enable

"" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

""""""""""""""""""""""""""""""
" プラグインのセットアップ
""""""""""""""""""""""""""""""
"if has('vim_starting')
"  set nocompatible               " Be iMproved
"
"  " Required:
"  set runtimepath+=~/.vim/bundle/neobundle.vim/
"endif
"
"" Required:
"call neobundle#begin(expand('~/.vim/bundle/'))
"
"" Let NeoBundle manage NeoBundle
"" Required:
"NeoBundleFetch 'Shougo/neobundle.vim'
"
"NeoBundle 'Shougo/vimproc', {
"  \ 'build' : {
"  \     'windows' : 'make -f make_mingw32.mak',
"  \     'cygwin' : 'make -f make_cygwin.mak',
"  \     'mac' : 'make -f make_mac.mak',
"  \     'unix' : 'make -f make_unix.mak',
"  \    },
"  \ }
"
"" 自動整形プラグイン
"NeoBundleLazy 'junegunn/vim-easy-align', {
"  \ 'autoload': {
"  \   'commands' : ['EasyAlign'],
"  \   'mappings' : ['<Plug>(EasyAlign)'],
"  \ }}
"
"" vim-easy-align {{{
"vmap <Enter> <Plug>(EasyAlign)
"nmap <Leader>a <Plug>(EasyAlign)
"" }}}
"
"" ファイルオープンを便利に
""NeoBundle 'Shougo/unite.vim'
"" バッファ一覧
""noremap <C-P> :Unite buffer<CR>
"" ファイル一覧
""noremap <C-N> :Unite -buffer-name=file file<CR>
"" 最近使ったファイルの一覧
""noremap <C-Z> :Unite file_mru<CR>
"" Unite.vimで最近使ったファイルを表示できるようにする
""NeoBundle 'Shougo/neomru.vim'
"
"" 構文エラーチェック
"NeoBundle "scrooloose/syntastic"
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=2
"
"" vimの移動のhjklの養成ギプス
""NeoBundle 'modsound/gips-vim'
"
"" インデントに色を付けて見やすくする
""NeoBundle 'nathanaelkane/vim-indent-guides'
"" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
""let g:indent_guides_enable_on_vim_startup = 1
"
"
"call neobundle#end()
"
"" Required:
""filetype plugin indent on
"filetype plugin on
"
"" If there are uninstalled bundles found on startup,
"" this will conveniently prompt you to install them.
"NeoBundleCheck
"""""""""""""""""""""""""""""""

