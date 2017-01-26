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

"----encoding
:set encoding=utf-8
:set fileencoding=utf-8
:set fileencodings=utf-8,iso-2022-jp,euc-jp,sjis
:set fileformats=mac,unix,dos

"----copy
set clipboard+=unnamedplus

nnoremap j gj
nnoremap k gk
nnoremap <Space>. :<Esc>:edit $MYVIMRC<Enter>
nnoremap <Space>s :<Esc>:source $MYVIMRC<Enter>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <C-n> gt
nnoremap <C-p> gT
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
nnoremap <C-g> :<C-U>vsplit<Cr>

let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_guide_size = 1

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd BufNewFile,BufRead *.haml,*.hamlbars,*.hamlc setf haml
autocmd BufNewFile,BufRead *.sass setf sass
autocmd BufNewFile,BufRead *.scss setf scss

"plugin

"dein.vim dark power
let s:dein_dir = expand('~/.config/nvim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:python3_host_prog = expand('/usr/local/var/pyenv/shims/python')

"check dein
if !isdirectory(s:dein_repo_dir)
  echo "install dein.vim..."
  execute '!git clone git://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let g:rc_dir    = expand('~/.vim/rc')
  let s:toml      = g:rc_dir . '/dein.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
"vimfiler settings
let g:vimfiler_as_default_explorer=1
nnoremap <C-e> :<C-U>VimFiler<CR>
nnoremap <C-t> :<C-U>VimFilerTab<CR>
"colorschem
colorscheme Benokai
syntax on "カラー表示
"rubocop
autocmd! BufWritePost * Neomake

filetype plugin indent on
