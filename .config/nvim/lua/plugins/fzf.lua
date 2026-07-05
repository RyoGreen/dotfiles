local fzf = require("fzf-lua")

fzf.setup({
  fzf_colors = true,
  winopts = {
    height = 0.85,
    width = 0.85,
    row = 0.40,
    col = 0.50,
    border = "rounded",
    backdrop = 60,
    title_pos = "center",
    title_flags = false,
    preview = {
      border = "rounded",
      layout = "flex",
      scrollbar = "float",
    },
  },
  fzf_opts = {
    ["--pointer"] = "▌",
    ["--marker"] = "▏",
  },
  files = {
    prompt = "  Files ❯ ",
    fd_opts = [[--color=never --type f --hidden --follow --exclude .git]],
    winopts = { preview = { hidden = "hidden" } },
  },
  buffers = {
    prompt = "  Buffers ❯ ",
    winopts = { preview = { hidden = "hidden" } },
  },
  grep = {
    prompt = "  Grep ❯ ",
    rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git'",
  },
})
