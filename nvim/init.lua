vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

local opt = vim.opt
local keymap = vim.keymap.set

opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4
opt.textwidth = 79
opt.modelines = 1
opt.autoindent = true
opt.backspace = { "indent", "eol", "start" }
opt.number = true
opt.relativenumber = true
opt.background = "light"
opt.termguicolors = true
opt.showcmd = true
opt.wildmenu = true
opt.wildmode = { "longest:full", "full" }
opt.lazyredraw = true
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldmethod = "indent"
opt.scrolloff = 3
opt.sidescrolloff = 3
opt.mouse = "a"
opt.splitbelow = true
opt.splitright = true
opt.switchbuf:append({ "usetab", "newtab" })
opt.incsearch = true
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 500
opt.ttimeoutlen = 50
opt.backup = true
opt.backupdir = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.directory = { "~/.vim-tmp", "~/.tmp", "~/tmp", "/var/tmp", "/tmp" }
opt.writebackup = true
opt.undofile = true
opt.undodir = vim.fn.expand("~/.undodir")
opt.wildignore:append({ "*/.git/*", "*/tmp/*", "*.swp" })

vim.g.solarized_termcolors = 256
vim.g.solarized_termtrans = 0

vim.cmd("filetype plugin indent on")
vim.cmd("syntax enable")

if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep"
  opt.grepformat = "%f:%l:%c:%m"
elseif vim.fn.executable("ag") == 1 then
  opt.grepprg = 'ag --vimgrep --ignore="**.min.js"'
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
elseif vim.fn.executable("ack") == 1 then
  opt.grepprg = "ack --nogroup --nocolor --ignore-case --column"
  opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

local function toggle_number()
  opt.relativenumber = not vim.wo.relativenumber
  opt.number = true
end

vim.api.nvim_create_user_command("TN", toggle_number, {})
vim.api.nvim_create_user_command("WP", function()
  opt.textwidth = 80
  opt.spell = true
  opt.spelllang = "en_us"
  opt.expandtab = false
  opt.colorcolumn = "80"
end, {})

keymap("n", "<space>", "za", { silent = true, desc = "Toggle fold" })
keymap("n", "gV", "`[v`]", { desc = "Select last changed text" })
keymap("n", "<leader>ev", ":tabnew $MYVIMRC<CR>", { silent = true, desc = "Edit init.lua" })
keymap("n", "<leader>ez", ":tabnew ~/.zshrc<CR>", { silent = true, desc = "Edit zshrc" })
keymap("n", "<leader>sv", ":source $MYVIMRC<CR>", { silent = true, desc = "Source init.lua" })
keymap("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>", { silent = true, desc = "cd to buffer dir" })
keymap("n", "<leader>s", ":mksession<CR>", { silent = true, desc = "Write session" })
keymap("n", "<leader>rl", toggle_number, { silent = true, desc = "Toggle relative numbers" })
keymap("n", "<leader><space>", ":nohlsearch<CR>", { silent = true, desc = "Clear search highlight" })
keymap({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to system clipboard" })
keymap("n", "<leader>Y", '"+yy', { desc = "Yank line to system clipboard" })
keymap({ "n", "x" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })
keymap({ "n", "x" }, "<leader>P", '"+P', { desc = "Paste before from system clipboard" })
keymap("n", "<leader>u", ":UndotreeToggle<CR>", { silent = true, desc = "Toggle undo tree" })

local configgroup = vim.api.nvim_create_augroup("configgroup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = configgroup,
  callback = function()
    vim.cmd("highlight clear SignColumn")
  end,
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = configgroup,
  pattern = "*.cls",
  command = "setlocal filetype=java",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = configgroup,
  pattern = "*.zsh-theme",
  command = "setlocal filetype=zsh",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = configgroup,
  pattern = "Makefile",
  command = "setlocal noexpandtab",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = configgroup,
  pattern = "*.sh",
  command = "setlocal tabstop=2 shiftwidth=2 softtabstop=2",
})
vim.api.nvim_create_autocmd("BufEnter", {
  group = configgroup,
  pattern = "*.md",
  command = "setlocal filetype=markdown",
})

vim.diagnostic.config({
  float = { border = "rounded", source = "if_many" },
  severity_sort = true,
  signs = true,
  underline = true,
  virtual_text = { spacing = 2 },
})

local treesitter_languages = {
  "bash",
  "c",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "rust",
  "toml",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

local treesitter_filetypes = {
  "bash",
  "c",
  "cpp",
  "css",
  "dockerfile",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "python",
  "rust",
  "toml",
  "typescript",
  "vim",
  "yaml",
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp_keymaps", { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf, silent = true }
    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
    keymap("n", "gy", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))
    keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
    keymap("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "List references" }))
    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover" }))
    keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
    keymap("n", "<leader>d", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
    keymap("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
    keymap("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "lifepillar/vim-solarized8",
      lazy = false,
      priority = 1000,
      config = function()
        vim.o.background = "light"
        vim.g.solarized_termcolors = 256
        vim.g.solarized_termtrans = 0
        local ok = pcall(vim.cmd.colorscheme, "solarized8_flat")
        if not ok then
          ok = pcall(vim.cmd.colorscheme, "solarized8")
        end
        if not ok then
          vim.cmd.colorscheme("habamax")
        end
        vim.o.background = "light"
      end,
    },
    {
      "nvim-lualine/lualine.nvim",
      opts = {
        options = {
          component_separators = "",
          section_separators = "",
          icons_enabled = false,
          theme = "solarized_light",
        },
      },
    },
    {
      "nvim-tree/nvim-tree.lua",
      keys = {
        { "<leader>n", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree" },
      },
      config = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
        require("nvim-tree").setup({
          filters = { custom = { "^.git$" } },
          renderer = { group_empty = true },
          view = { width = 32 },
        })
      end,
    },
    {
      "numToStr/Comment.nvim",
      opts = {
        padding = true,
        sticky = true,
      },
    },
    {
      "kylechui/nvim-surround",
      version = "*",
      event = "VeryLazy",
      opts = {},
    },
    { "tpope/vim-fugitive" },
    {
      "mbbill/undotree",
      keys = {
        { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle undo tree" },
      },
    },
    {
      "lewis6991/gitsigns.nvim",
      opts = {
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "-" },
          changedelete = { text = "~" },
          untracked = { text = "+" },
        },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          build = "make",
          cond = function()
            return vim.fn.executable("make") == 1
          end,
        },
      },
      keys = {
        { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
        { "<leader>fg", "<cmd>Telescope git_files<CR>", desc = "Find git files" },
        { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Find buffers" },
        { "<leader>rg", "<cmd>Telescope live_grep<CR>", desc = "Ripgrep files" },
      },
      config = function()
        local telescope = require("telescope")
        telescope.setup({
          defaults = {
            file_ignore_patterns = { ".git/" },
            mappings = {
              i = {
                ["<esc>"] = require("telescope.actions").close,
              },
            },
          },
        })
        pcall(telescope.load_extension, "fzf")
      end,
    },
    {
      "nvim-treesitter/nvim-treesitter",
      lazy = false,
      build = ":TSUpdate",
      config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup({
          install_dir = vim.fn.stdpath("data") .. "/site",
        })

        if vim.fn.executable("tree-sitter") == 1 then
          local install = treesitter.install(treesitter_languages)
          if #vim.api.nvim_list_uis() == 0 then
            install:wait(300000)
          end
        else
          vim.notify("Install tree-sitter CLI to enable parser installation.", vim.log.levels.WARN)
        end

        vim.api.nvim_create_autocmd("FileType", {
          group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
          pattern = treesitter_filetypes,
          callback = function(event)
            pcall(vim.treesitter.start, event.buf)
            vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end,
        })
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = false }),
            ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { "i", "s" }),
            ["<S-Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              else
                fallback()
              end
            end, { "i", "s" }),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
          }, {
            { name = "buffer" },
          }),
        })
      end,
    },
    {
      "mason-org/mason-lspconfig.nvim",
      dependencies = {
        "mason-org/mason.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
        require("mason").setup()

        local servers = {
          "bashls",
          "jsonls",
          "lua_ls",
          "pyright",
          "ruff",
          "ts_ls",
          "yamlls",
        }

        if vim.fn.has("nvim-0.11") == 1 then
          local capabilities = vim.lsp.protocol.make_client_capabilities()
          local ok_cmp_lsp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
          if ok_cmp_lsp then
            capabilities = cmp_lsp.default_capabilities(capabilities)
          end

          for _, server in ipairs(servers) do
            vim.lsp.config(server, { capabilities = capabilities })
          end

          vim.lsp.config("lua_ls", {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = {
                  checkThirdParty = false,
                  library = vim.api.nvim_get_runtime_file("", true),
                },
              },
            },
          })
        else
          vim.notify("This LSP config expects Neovim 0.11 or newer.", vim.log.levels.WARN)
        end

        require("mason-lspconfig").setup({
          ensure_installed = servers,
          automatic_enable = true,
        })
      end,
    },
  },
  install = { colorscheme = { "solarized8_flat", "solarized8", "habamax" } },
  checker = { enabled = true },
  change_detection = { notify = false },
})

keymap("n", "<leader>gb", ":Git blame<CR>", { silent = true, desc = "Git blame" })
