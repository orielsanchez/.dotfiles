return {
  { -- Fuzzy Finder (files, lsp, etc)
    "nvim-telescope/telescope.nvim",
    event = "VimEnter",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      { "nvim-telescope/telescope-ui-select.nvim" },
      { "nvim-tree/nvim-web-devicons",            enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      -- See `:help telescope` and `:help telescope.setup()`
      local fb_actions = require("telescope").extensions.file_browser.actions
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ff",
        ":lua require'telescope'.extensions.file_browser.file_browser({ path = vim.fn.expand('%:p:h') })<CR>",
        { noremap = true, silent = true, desc = "Open file browser at current file" }
      )
      require("telescope").setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          mappings = {
            i = { ["<c-enter>"] = "to_fuzzy_refine" },
          },
          initial_mode = "insert",
          selection_strategy = "reset",
          sorting_strategy = "ascending",
          color_devicons = true,
          layout_strategy = "horizontal",
          prompt_position = "top",
        },
        pickers = {
          current_buffer_fuzzy_find = {},
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
          file_browser = {
            initial_mode = "normal",
            cwd_to_path = true,
            grouped = true,
            hidden = false,
            depth = 1,
            auto_depth = false,
            hijack_netrw = true,
            use_fd = true,
            git_status = true,
            display_stat = { date = true, mode = true },
            mappings = {
              ["n"] = {
                ["h"] = fb_actions.toggle_hidden,
              },
            },
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "file_browser")
      pcall(require("telescope").load_extension, "ui-select")

      -- See `:help telescope.builtin`
      local builtin = require("telescope.builtin")
      local fb = require("telescope").extensions.file_browser
      vim.keymap.set("n", "<leader>sp", builtin.help_tags, { desc = "[S]earch hel[p]" })
      vim.keymap.set("n", "<leader>fb", fb.file_browser, { desc = "[F]ile [B]rowser" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
      vim.keymap.set("n", "<leader>l", "<CMD>bnext<CR>", { desc = "Go to next buffer" })
      vim.keymap.set("n", "<leader>h", "<CMD>bprevious<CR>", { desc = "Go to previous buffer" })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({
          grep_open_files = true,
          prompt_title = "Live Grep in Open Files",
        })
      end, { desc = "[S]earch [/] in Open Files" })

      vim.keymap.set("n", "<leader>sh", function()
        builtin.live_grep({
          cwd = "~",
          -- search_dirs = { "." },
          prompt_title = "Live Grep $Home",
        })
      end, { desc = "[S]earch [H]ome" })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]earch [N]eovim files" })
    end,
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
}
-- vim: ts=2 sts=2 sw=2 et
