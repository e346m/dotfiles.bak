require'plugins'

local api = vim.api
local vim = vim

vim.o.number  = true --行番号表示
vim.o.showmode = true --モード表示
vim.o.title = true --編集中のファイル名を表示
vim.o.ruler = true --ルーラーの表示
vim.o.smartindent = true --オートインデント
vim.o.showcmd = true --入力中のコマンドをステータスに表示する
vim.o.showmatch = true --括弧入力時の対応する括弧を表示
vim.o.laststatus= 2  --ステータスラインを常に表示
vim.o.cursorline = true
vim.o.colorcolumn = '100'
vim.o.wrap = true
vim.o.backspace = 'indent,eol,start'

-- tab
vim.o.expandtab = true --タブの代わりに空白文字挿入

-- search
vim.o.ignorecase = true --検索文字列が小文字の場合は大文字小文字を区別なく検索する
vim.o.smartcase = true --検索文字列に大文字が含まれている場合は区別して検索する
vim.o.wrapscan = true --検索時に最後まで行ったら最初に戻る
vim.o.incsearch = true --検索文字列入力時に順次対象文字列にヒットさる
vim.o.hlsearch = true --Highlight search = true result
vim.o.spell = true
vim.o.spelllang = 'en_us,cjk'


-- clipboard
vim.o.clipboard = "unnamedplus"

-- colorscheme
vim.o.termguicolors = true
vim.cmd 'colorscheme material'
vim.g.material_style = "deep ocean"

-- tabs
vim.cmd [[set sw=2 sts=2 ts=2]]
vim.cmd[[autocmd FileType go set sw=4 sts=4 ts=4]]

-- remove space
vim.cmd [[ autocmd BufWritePre * :%s/\s\+$//ge ]]

-- Key mappings

--- nnoremap

---- wrapped line move
api.nvim_set_keymap("n", "j", "gj", {noremap = true})
api.nvim_set_keymap("n", "k", "gk", {noremap = true})

---- panel switch
api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true})
api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true})
api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true})
api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true})

---- myvimrc
api.nvim_set_keymap("n", "<Space>.", ":<Esc>:edit $MYVIMRC<Enter>", { noremap = true})
api.nvim_set_keymap("n", "<Space>s", ":<Esc>:source $MYVIMRC<Enter>", { noremap = true})

---- split window
api.nvim_set_keymap("n", "<C-g>", ":<C-U>vsplit<Cr>", { noremap = true})
api.nvim_set_keymap("n", "<C-e>", ":<C-U>Fern . -reveal=%<Cr>", { noremap = true})

---- Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>g', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })


--- inoremap
api.nvim_set_keymap("i", "jj", "<esc>", {noremap = true})
api.nvim_set_keymap("i", "<C-j>", "<Down>", { noremap = true})
api.nvim_set_keymap("i", "<C-k>", "<Up>", { noremap = true})
api.nvim_set_keymap("i", "<C-h>", "<Left>", { noremap = true})
api.nvim_set_keymap("i", "<C-l>", "<Right>", { noremap = true})

api.nvim_set_keymap("i", "()", "()<Left>", { noremap = true})
api.nvim_set_keymap("i", "{}", "{}<Left>", { noremap = true})
api.nvim_set_keymap("i", "[]", "[]<Left>", { noremap = true})
api.nvim_set_keymap("i", "<>", "<><Left>", { noremap = true})
api.nvim_set_keymap("i", "\"\"", "\"\"<Left>", { noremap = true})
api.nvim_set_keymap("i", "''", "''<Left>", { noremap = true})
api.nvim_set_keymap("i", "``", "``<Left>", { noremap = true})
api.nvim_set_keymap("i", ",", ",<Space>", { noremap = true})

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  buf_set_keymap("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  buf_set_keymap("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
end


local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    local opts = {}
    opts.on_attach = on_attach
    opts.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
    -- This setup() function is exactly the same as lspconfig's setup function (:help lspconfig-quickstart)
    server:setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
end)

-- 最後に追加
vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require"cmp"
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),

  mapping = {
    ['<Down>'] = cmp.mapping.scroll_docs(2),
    ['<Up>' ] = cmp.mapping.scroll_docs(-2),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
  }

})


vim.cmd [[ autocmd BufWritePost <buffer> lua vim.lsp.buf.formatting_sync() ]]
