set number  "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set guifont=Ricty-Regular:h16 "プログラミング用のfontをRictyに変更する。
set backspace=indent,eol,start
set colorcolumn=80
set wrap
syntax on "カラー表示
set smartindent "オートインデント
" tab関連
set expandtab "タブの代わりに空白文字挿入(soft tab化)
set sw=2 sts=2 ts=2
"autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
"autocmd FileType ruby       setlocal ts=2 sw=2 sts=2 "タブは半角2文字分のスペース
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set nohlsearch "検索結果文字列の非ハイライト表示
autocmd BufWritePre * :%s/\s\+$//ge "行末のスペース削除


set foldmethod=manual
autocmd FileType ruby :set foldmethod=indent
autocmd FileType ruby :set foldlevel=1
autocmd FileType ruby :set foldnestmax=2

"inoremap <C-mi> <Space>-<Space>
"inoremap <C-eq> <Space>=<Space>
"inoremap <C> <Space>/<Space>
"----encoding
:set encoding=utf-8
:set fileencoding=utf-8
:set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
:set fileformats=mac,unix,dos

"----copy
set clipboard+=unnamed
set clipboard+=autoselect

nnoremap j gj
nnoremap k gk
nnoremap <Space>. :<Esc>:edit $MYVIMRC<Enter>
nnoremap <Space>s :<Esc>:source $MYVIMRC<Enter>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
inoremap <silent> jj <ESC>
inoremap <silent> <C-o> <ESC>o
inoremap <silent> <C-a> <ESC>A
inoremap <C>dw dw
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap <> <><Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `' `'<Left>
inoremap %% %%<Left>
inoremap \|\| \|\|<Left>
inoremap , ,<Space>
nnoremap gww ZZ
nnoremap gqq ZQ
set nocompatible

filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
    call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
    call neobundle#end()
endif

" ここにインストールしたいプラグインのリストを書く

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundle 'Shougo/unite.vim'
nnoremap ,b :<C-u>Unite buffer<CR>
nnoremap ,c :<C-u>Unite file<CR>
nnoremap ,h :<C-u>Unite file_mru<CR>
nnoremap ,f  :<c-u>UniteWithBufferDir -buffer-name=files file -direction=botright <cr>
noremap ,r     :Unite -buffer-name=register register<CR>
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'Align'
NeoBundle 'vim-ruby/vim-ruby'
NeoBundle 'tpope/vim-rails', { 'autoload' : {'filetypes' : ['haml', 'ruby', 'eruby'] }}
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
            \ 'build' :{
            \'windows' : 'make -f make_mingw32.mak',
            \'cygwin' : 'make -f make_cygwin.mak',
            \'mac' : 'make -f make_mac.mak',
            \ 'unix' : 'make -f make_unix.mak',
            \},
            \}
NeoBundleLazy 'alpaca-tc/vim-endwise.git', {
            \ 'autoload' : {
            \   'insert' : 1,
            \ }}

NeoBundle 'osyo-manga/vim-over'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kana/vim-fakeclip.git'
NeoBundle 'rails.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'Lokaltog/vim-powerline'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'open-browser.vim'
NeoBundle 'kana/vim-smartchr'
NeoBundle 'tomasr/molokai'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'tpope/vim-haml'
NeoBundle 'yggdroot/indentLine'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'kchmck/vim-coffee-script'
call neobundle#end()
" vim-indent-guides
" na/vim-smartchr'Vim 起動時 vim-indent-guides を自動起動
colorscheme molokai
let g:indent_guides_enable_on_vim_startup=1
" ガイドをスタートするインデントの量
let g:indent_guides_start_level=2
" 自動カラー無効
let g:indent_guides_auto_colors=0
" 奇数番目のインデントの色
"autocmd VimEnter,Colorscheme
":hi IndentGuidesOdd  guibg=#444433 ctermbg=black
" 偶数番目のインデントの色
"autocmd VimEnter,Colorscheme
":hi IndentGuidesEven guibg=#333344 ctermbg=darkgrey
" ガイドの幅
let g:indent_guides_guide_size = 1
"default Filer of vim
let g:vimfiler_as_default_explorer=1
nnoremap <C-e> :<C-U>VimFilerTab<CR>

set list listchars=tab:\¦\

let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '¥*ku¥*'
let g:neocomplete#force_overwrite_completefunc=1
let g:neocomplete#sources#dictionary#dictionaries = {
            \ 'default' : '',
            \ 'vimshell' : $HOME.'/.vimshell_hist',
            \     'scheme' : $HOME.'/.gosh_completions'
            \            }
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '¥h¥w*'
inoremap <expr><C-g>  neocomplete#undo_completion()
inoremap <expr><C-r>  neocomplete#complete_common_string()
inoremap <expr><C-e>  neocomplete#smart_close_popup()
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc setf haml
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss
:

filetype plugin on
filetype indent on
