return {
  "ggandor/flit.nvim",
  version = "*",
  dependencies = "ggandor/leap.nvim",
  opts = {
    keys = { f = "f", F = "F", t = "t", T = "T" },
    -- A string like "nv", "nvo", "o", etc.
    labeled_modes = "nv",
    multiline = true,
  },
}
