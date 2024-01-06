return {
  "goolord/alpha-nvim",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      [[                                                                         ]],
      [[                               :                                         ]],
      [[ L.                     ,;    t#,                                        ]],
      [[ EW:        ,ft       f#i    ;##W.              t                        ]],
      [[ E##;       t#E     .E#t    :#L:WE              Ej            ..       : ]],
      [[ E###t      t#E    i#W,    .KG  ,#D  t      .DD.E#,          ,W,     .Et ]],
      [[ E#fE#f     t#E   L#D.     EE    ;#f EK:   ,WK. E#t         t##,    ,W#t ]],
      [[ E#t D#G    t#E :K#Wfff;  f#.     t#iE#t  i#D   E#t        L###,   j###t ]],
      [[ E#t  f#E.  t#E i##WLLLLt :#G     GK E#t j#f    E#t      .E#j##,  G#fE#t ]],
      [[ E#t   t#K: t#E  .E#L      ;#L   LW. E#tL#i     E#t     ;WW; ##,:K#i E#t ]],
      [[ E#t    ;#W,t#E    f#E:     t#f f#:  E#WW,      E#t    j#E.  ##f#W,  E#t ]],
      [[ E#t     :K#D#E     ,WW;     f#D#;   E#K:       E#t  .D#L    ###K:   E#t ]],
      [[ E#t      .E##E      .D#;     G#t    ED.        E#t :K#t     ##D.    E#t ]],
      [[ ..         G#E        tt      t     t          E#t ...      #G      ..  ]],
      [[             fE                                 ,;.          j           ]],
      [[              ,                                                          ]],
      [[                                                                         ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("e", "  > New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("f", "  > Find file", ":cd $HOME/Workspace | Telescope find_files<CR>"),
      dashboard.button("r", "  > Recent", ":Telescope oldfiles<CR>"),
      dashboard.button("s", "  > Settings", ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
      dashboard.button("q", "  > Quit NVIM", ":qa<CR>"),
    }

    -- Set footer
    --   NOTE: This is currently a feature in my fork of alpha-nvim (opened PR #21, will update snippet if added to main)
    --   To see test this yourself, add the function as a dependency in packer and uncomment the footer lines
    --   ```init.lua
    --   return require('packer').startup(function()
    --       use 'wbthomason/packer.nvim'
    --       use {
    --           'goolord/alpha-nvim', branch = 'feature/startify-fortune',
    --           requires = {'BlakeJC94/alpha-nvim-fortune'},
    --           config = function() require("config.alpha") end
    --       }
    --   end)
    --   ```
    -- local fortune = require("alpha.fortune")
    -- dashboard.section.footer.val = fortune()

    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[
    autocmd FileType alpha setlocal nofoldenable
    ]])
  end,
}
