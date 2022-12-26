local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") ..
                             "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({
            "git", "clone", "--depth", "1",
            "https://github.com/wbthomason/packer.nvim", install_path
        })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    -- Github Neovim Theme
    use({
        'projekt0n/github-nvim-theme',
        config = function()
            require('github-theme').setup({theme_style = "dark_default"})
        end
    })

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({
                with_sync = true
            })
            ts_update()
        end,
        config = function()
            require'nvim-treesitter.configs'.setup {
                -- A list of parser names, or "all"
                ensure_installed = {
                    "bash", "fish", "gitcommit", "gitignore", "javascript",
                    "json", "lua", "make", "markdown", "python", "rust",
                    "svelte", "toml", "typescript"
                },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                highlight = {
                    -- `false` will disable the whole extension
                    enable = true,

                    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
                    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
                    -- the name of the parser)
                    -- list of language that will be disabled
                    disable = {"c", "rust"},
                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats =
                            pcall(vim.loop.fs_stat,
                                  vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false
                }
            }
        end
    }

    -- Devicons
    use 'nvim-tree/nvim-web-devicons'

    -- Galaxyline
    use({
        "NTBBloodbath/galaxyline.nvim",
        -- your statusline
        config = function() require("galaxyline.theme") end,
        -- some optional icons
        requires = {"nvim-tree/nvim-web-devicons", opt = true}
    })

    -- Barbar
    use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}

    -- nvim-tree
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons' -- optional, for file icons
        },
        tag = 'nightly', -- optional, updated every week. (see issue #1193)
        config = function()
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true

            require("nvim-tree").setup({
              sort_by = "case_sensitive",
              view = {
                adaptive_size = true,
                mappings = {
                  list = {
                    { key = "u", action = "dir_up" },
                  },
                },
              },
              renderer = {
                group_empty = true,
              },
              filters = {
                dotfiles = true,
              },
            })
        end,
    }

    -- Dashboard
    use {
        'glepnir/dashboard-nvim',
        config = function()
            local db = require('dashboard')
            -- Neovim logo
            if vim.g.neovide then
                db.custom_header = {
                    '',
                    '███╗   ██╗ ███████╗  ██████╗  ██╗   ██╗ ██╗ ██████╗  ███████╗',
                    '████╗  ██║ ██╔════╝ ██╔═══██╗ ██║   ██║ ██║ ██╔══██╗ ██╔════╝',
                    '██╔██╗ ██║ █████╗   ██║   ██║ ██║   ██║ ██║ ██║  ██║ █████╗  ',
                    '██║╚██╗██║ ██╔══╝   ██║   ██║ ╚██╗ ██╔╝ ██║ ██║  ██║ ██╔══╝  ',
                    '██║ ╚████║ ███████╗ ╚██████╔╝  ╚████╔╝  ██║ ██████╔╝ ███████╗',
                    '╚═╝  ╚═══╝ ╚══════╝  ╚═════╝    ╚═══╝   ╚═╝ ╚═════╝  ╚══════╝',
                    ''
                }
            else
                db.custom_header = {
                    '',
                    '███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
                    '████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
                    '██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
                    '██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
                    '██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
                    '╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
                    ''
                }
            end
        end
    }

    -- Toggleterm
    use {
        "akinsho/toggleterm.nvim",
        tag = '*',
        config = function()
            require("toggleterm").setup({
                size = vim.o.columns * 0.4,
                direction = "vertical"
            })
        end
    }

    -- nvim-colorizer
    use {
        'NvChad/nvim-colorizer.lua',
        config = function()
            require("colorizer").setup({
                filetypes = {
                    "lua", "css", "html", "javascript", "typescript", "react",
                    "svelte", "vue"
                },
                user_default_options = {
                    RGB = true, -- #RGB hex codes
                    RRGGBB = true, -- #RRGGBB hex codes
                    names = false, -- "Name" codes like Blue or blue
                    RRGGBBAA = true, -- #RRGGBBAA hex codes
                    AARRGGBB = false, -- 0xAARRGGBB hex codes
                    rgb_fn = true, -- CSS rgb() and rgba() functions
                    hsl_fn = true, -- CSS hsl() and hsla() functions
                    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
                    css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
                    -- Available modes for `mode`: foreground, background,  virtualtext
                    mode = "background", -- Set the display mode.
                    -- Available methods are false / true / "normal" / "lsp" / "both"
                    -- True is same as normal
                    tailwind = true, -- Enable tailwind colors
                    -- parsers can contain values used in |user_default_options|
                    virtualtext = "■"
                },
                -- all the sub-options of filetypes apply to buftypes
                buftypes = {}
            })
        end
    }

    -- nvim-cursorline
    use {
        'yamatsum/nvim-cursorline',
        config = function()
            require('nvim-cursorline').setup {
                cursorline = {enable = true, timeout = 10, number = false},
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = {underline = true}
                }
            }
        end
    }

    -- Bootstrap packer
    if packer_bootstrap then require("packer").sync() end
end)
