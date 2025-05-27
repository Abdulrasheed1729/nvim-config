return {
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'Abdulrasheed1729/telescope-fzf-native.nvim',
        build = 'zig build -Doptimize=ReleaseSafe',

      },
    },
    config = function()
      require('telescope').setup {
        pickers = {
          find_files = {
            theme = 'ivy'
          },
          help_tags = {
            theme = 'ivy'
          },
        },
        extensions = {
          fzf = {},
        }
      }


      require('telescope').load_extension('fzf')

      vim.keymap.set('n', '<space>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp tags' })
      vim.keymap.set('n', '<space>fd', require('telescope.builtin').find_files, { desc = '[F]ind in directory' })
      vim.keymap.set('n', '<space>en', function()
        require('telescope.builtin').find_files {
          cwd = vim.fn.stdpath('config')
        }
      end, { desc = 'Find in [E]ditor [N]eovim' })
      vim.keymap.set('n', '<space>ep', function()
        require('telescope.builtin').find_files {
          cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy')
        }
      end, { desc = 'Find in [E]ditor [P]lugins' })
      require "config.telescope.multigrep".setup()
    end
  }
}
