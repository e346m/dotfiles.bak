set number  "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set backspace=indent,eol,start
set colorcolumn=80
set wrap
set smartindent "オートインデント
" tab関連
set expandtab "タブの代わりに空白文字挿入(soft tab化)
set sw=2 sts=2 ts=2
autocmd FileType go set sw=4 sts=4 ts=4

" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set incsearch "検索文字列入力時に順次対象文字列にヒットさる
set hlsearch "Highlight search result
set spelllang=en,cjk
map <CR> :nohl<CR>

autocmd BufWritePre * :%s/\s\+$//ge "行末のスペース削除

set foldmethod=manual
autocmd FileType ruby :set foldmethod=indent
autocmd FileType ruby :set foldlevel=1
autocmd FileType ruby :set foldnestmax=2

"----copy
set clipboard+=unnamedplus

nnoremap <Space>. :<Esc>:edit $MYVIMRC<Enter>
nnoremap <Space>s :<Esc>:source $MYVIMRC<Enter>

"---- move
nnoremap j gj
nnoremap k gk
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

"---- move tab
nnoremap <C-p> gt
nnoremap <C-n> gT

"---- execute
nnoremap ,n :!node %<Cr>
nnoremap ,r :!ruby %<Cr>
nnoremap ,e :!elixir %<Cr>
nnoremap ,g :!go run %<Cr>
nnoremap ,iex :terminal iex %<Cr>
nnoremap ,mix :terminal iex -S mix<Cr>
nnoremap ,pry :terminal pry %<Cr>

"---- coding
inoremap <silent> jj <ESC>
inoremap <silent> <C-o> <ESC>o
inoremap <silent> <C-a> <ESC>A
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap <> <><Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `` ``<Left>
inoremap , ,<Space>
inoremap <C>dw dw

"---- split window
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
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

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
"colorscheme
let g:arcadia_Midnight = 1
colorscheme arcadia
"set termguicolors
"set background=dark
"colorscheme boa
syntax on "カラー表示

"Neomake
autocmd! BufWritePost,BufEnter * Neomake
let g:neomake_markdown_enabled_makers = []
" Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
function! NeomakeCredoErrorType(entry)
    if a:entry.type ==# 'F'      " Refactoring opportunities
        let type = 'W'
    elseif a:entry.type ==# 'D'  " Software design suggestions
        let type = 'I'
    elseif a:entry.type ==# 'W'  " Warnings
        let type = 'W'
    elseif a:entry.type ==# 'R'  " Readability suggestions
        let type = 'I'
    elseif a:entry.type ==# 'C'  " Convention violation
        let type = 'W'
    else
        let type = 'M'           " Everything else is a message
    endif
    let a:entry.type = type
endfunction
let g:neomake_elixir_enabled_makers = ['mycredo']
let g:neomake_elixir_mycredo_maker = {
      \ 'exe': 'mix',
      \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
      \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
      \ 'postprocess': function('NeomakeCredoErrorType')
      \ }
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:neomake_error_sign = {'text': '>>', 'texthl': 'ErrorMsg'}
let g:neomake_warning_sign = {'text': '>>',  'texthl': 'Todo'}

filetype plugin indent on
