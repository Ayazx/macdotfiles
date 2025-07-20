return {
    { "nvim-lua/plenary.nvim" }, -- lua functions that many plugins use
    {"christoomey/vim-tmux-navigator" }, -- tmux & split window navigation


    -- Mini Nvim
   {"echasnovski/mini.nvim", version = false },
    -- Comments
    {
        'echasnovski/mini.comment',
        version = false,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
        },
        config = function()
            -- disable the autocommand from ts-context-commentstring
            require('ts_context_commentstring').setup {
                enable_autocmd = false,
            }

            require("mini.comment").setup {
                -- tsx, jsx, html , svelte comment support
                options = {
                    custom_commentstring = function()
                        return require('ts_context_commentstring.internal').calculate_commentstring({ key =
                            'commentstring' })
                            or vim.bo.commentstring
                    end,
                },
            }
        end,
    },

    -- File explorer (this works properly with oil unlike nvim-tree)

{
  'echasnovski/mini.files',
  version = false,
  lazy = false,
  config = function()
    local MiniFiles = require("mini.files")

    -- local col = vim.o.columns
    -- local preview_enabled = col>=80
    -- local preview_width = preview_enabled and math.max(20, math.floor(col * 0.6)) or 0
    -- local focus_width = preview_enabled and (col - preview_width) or col

    MiniFiles.setup({
      windows = {
        preview = true,
        width_focus = math.floor(vim.o.columns * 0.2),
        width_preview = math.floor(vim.o.columns * 0.7),
        -- preview = preview_enabled,
        -- width_focus = focus_width,
        -- width_preview = preview_width,
      },
      mappings = {
        go_in = 'l',
        go_in_plus = 'L',
        go_out = 'h',
        go_out_plus = 'H',
        close = 'q',
        reset = '<BS>',
        reveal_cwd = '@',
        synchronize = '=',
        trim_left = '<',
        trim_right = '>',
        show_help = 'g?',
        delete = 'dd',
        open = '<CR>',
      },
    content = {
                    preview = function(path, bufnr)
                    if vim.fn.isdirectory(path) == 0 then
                        local ok, data = pcall(vim.fn.readfile, path, '', 50)
                        if ok then
                            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, data)
                        end
                    end
                end
                },
    })

    -- Toggle file explorer
    vim.keymap.set("n", "<leader>ee", function()
      MiniFiles.open(nil, true)
    end, { desc = "Toggle mini file explorer" })

    -- Reveal current file
    vim.keymap.set("n", "<leader>ef", function()
      local file_path = vim.api.nvim_buf_get_name(0)
      MiniFiles.open(file_path, false)
      MiniFiles.reveal_cwd()
    end, { desc = "Open mini.files at current file" })
  end,
},




    -- Surround
    {
        "echasnovski/mini.surround",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- Add custom surroundings to be used on top of builtin ones. For more
            -- information with examples, see `:h MiniSurround.config`.
            custom_surroundings = nil,

            -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
            highlight_duration = 300,

            -- Module mappings. Use `''` (empty string) to disable one.
            -- INFO:
            -- saiw surround with no whitespace
            -- saw surround with whitespace
            mappings = {
                add = 'sa',            -- Add surrounding in Normal and Visual modes
                delete = 'ds',         -- Delete surrounding
                find = 'sf',           -- Find surrounding (to the right)
                find_left = 'sF',      -- Find surrounding (to the left)
                highlight = 'sh',      -- Highlight surrounding
                replace = 'sr',        -- Replace surrounding
                update_n_lines = 'sn', -- Update `n_lines`

                suffix_last = 'l',     -- Suffix to search with "prev" method
                suffix_next = 'n',     -- Suffix to search with "next" method
            },

            -- Number of lines within which surrounding is searched
            n_lines = 20,

            -- Whether to respect selection type:
            -- - Place surroundings on separate lines in linewise mode.
            -- - Place surroundings on each line in blockwise mode.
            respect_selection_type = false,

            -- How to search for surrounding (first inside current line, then inside
            -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
            -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
            -- see `:h MiniSurround.config`.
            search_method = 'cover',

            -- Whether to disable showing non-error feedback
            silent = false,
        },
    },
    -- Get rid of whitespace
    {
        "echasnovski/mini.trailspace",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local miniTrailspace = require("mini.trailspace")

            miniTrailspace.setup({
                only_in_normal_buffers = true,
            })
            vim.keymap.set("n", "<leader>cw", function() miniTrailspace.trim() end, { desc = "Erase Whitespace" })

            -- Ensure highlight never reappears by removing it on CursorMoved
            vim.api.nvim_create_autocmd("CursorMoved", {
                pattern = "*",
                callback = function()
                    require("mini.trailspace").unhighlight()
                end,
            })
        end,
    },
    -- Split & join
    {
        "echasnovski/mini.splitjoin",
        config = function()
            local miniSplitJoin = require("mini.splitjoin")
            miniSplitJoin.setup({
                mappings = { toggle = "" }, -- Disable default mapping
            })
            vim.keymap.set({ "n", "x" }, "sj", function() miniSplitJoin.join() end, { desc = "Join arguments" })
            vim.keymap.set({ "n", "x" }, "sk", function() miniSplitJoin.split() end, { desc = "Split arguments" })
        end,
    },
}
