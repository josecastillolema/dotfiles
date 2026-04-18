local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
  config = {
    -- Automatically closes the repl window on process end
    close_window_on_exit = true,
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      python = require("iron.fts.python").ipython,
      --ocaml = require("iron.fts.ocaml").utop,
      ocaml = {
        --close = ";;",
        command = {
          "utop",
        },
        format = function(lines) table.insert(lines, ";;\13") return lines end,
      },
    },
    -- How the repl window will be displayed
    repl_open_cmd = require('iron.view').split.vertical.botright(0.4),
  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    send_motion = "<M-CR>",
    visual_send = "<M-CR>",
    send_file = "<space>rf",
    send_line = "<space>rl",
    send_until_cursor = "<space>ru",
    send_mark = "<space>rs",
    mark_motion = "<space>rm",
    mark_visual = "<space>rm",
    remove_mark = "<space>rd",
    cr = "<space>r<cr>",
    interrupt = "<space>ri",
    exit = "<space>rq",
    clear = "<space>rc",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.bufhidden = "wipe"
  end,
})

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>r', '<cmd>IronRepl<cr>')
vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

