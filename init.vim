set number  "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set smartindent "オートインデント
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示
set statusline=%F
set statusline+=%m
set statusline+=%r
set statusline+=%h
set statusline+=%w
set statusline+=%=
set statusline+=[ENC=%{&fileencoding}]
set statusline+=[LOW=%l/%L]
set cursorline
set colorcolumn=100
set wrap
set backspace=indent,eol,start

" tab
set expandtab "タブの代わりに空白文字挿入(soft tab化)
set sw=2 sts=2 ts=2
autocmd FileType go set sw=4 sts=4 ts=4

" search
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set incsearch "検索文字列入力時に順次対象文字列にヒットさる
set hlsearch "Highlight search result
set spell
set spelllang=en_us,cjk
map <CR> :nohl<CR>

"---- fzf file search
nnoremap <Leader>r :Rg<Cr>
nnoremap <Leader>f :Files<Cr>
nnoremap <Leader>b :Buffers<Cr>

" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

set rtp+=/usr/local/opt/fzf

autocmd BufWritePre * :%s/\s\+$//ge "行末のスペース削除
autocmd BufWritePre *.tsx,*.ts Prettier

" fold
set foldmethod=manual
autocmd FileType ruby :set foldmethod=indent
autocmd FileType ruby :set foldlevel=1
autocmd FileType ruby :set foldnestmax=2

"----copy
set clipboard+=unnamedplus

nnoremap <Space>. :<Esc>:edit $MYVIMRC<Enter>
nnoremap <Space>s :<Esc>:source $MYVIMRC<Enter>
nnoremap <Leader>s" ciw""<Esc>P
nnoremap <Leader>s' ciw''<Esc>P
nnoremap <Leader>s( ciw()<Esc>P
nnoremap <Leader>s{ ciw{}<Esc>P
nnoremap <Leader>s[ ciw[]<Esc>P

"---- move
nnoremap j gj
nnoremap k gk
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
nnoremap <Space>l $
nnoremap <Space>h ^
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <silent> K :call CocAction('doHover')<CR>

"---- move tab
nnoremap <C-p> gt
nnoremap <C-n> gT

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

"--- coc
"--- coc-tsserver
command! -nargs=0 Prettier :CocCommand prettier.formatFile

"---- filer: current working directory with current buffer
nnoremap <C-e> :<C-U>Fern . -reveal=%<CR>

"---- split window
nnoremap <C-g> :<C-U>vsplit<Cr>
nnoremap <C-t> :<C-U>FzfNewWindow<Cr>

let g:indent_guides_start_level=3
let g:indent_guides_auto_colors=0
let g:indent_guides_guide_size = 1

"plugin
"dein.vim dark power
let s:dein_dir = expand('~/.config/nvim')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let g:python3_host_prog = expand($PYENV_ROOT . '/shims/python')
"
if !empty(g:python3_host_prog)
  let g:python3_host_prog = expand('/usr/bin/python3')
endif

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
  let g:dein#install_github_api_token = $VIM_PLUGIN_MAGER_TOKEN
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif

function! s:deinClean()
  if len(dein#check_clean())
    call map(dein#check_clean(), 'delete(v:val, "rf")')
  else
    echo '[ERR] no disabled plugins'
  endif
endfunction
command! DeinClean :call s:deinClean()

"--- fzf
function! s:fzfNewWindow()
  tabnew
  :Files
endfunction
command! FzfNewWindow :call s:fzfNewWindow()

"colorscheme
let g:arcadia_Midnight = 1
colorscheme arcadia
set termguicolors
syntax enable

filetype plugin indent on
autocmd VimEnter,Colorscheme * :hi ColorColumn ctermbg=lightgrey guibg=lightgrey
