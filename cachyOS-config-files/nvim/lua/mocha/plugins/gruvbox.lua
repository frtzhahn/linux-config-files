-- return {
--     "slugbyte/lackluster.nvim",
--     lazy = false,
--     priority = 1000,
--     init = function()
--         vim.cmd.colorscheme("lackluster")
--         -- vim.cmd.colorscheme("lackluster-hack") -- my favorite
--         -- vim.cmd.colorscheme("lackluster-mint")
--     end,
-- }




-- return {
--   "ellisonleao/gruvbox.nvim",
--   priority = 1000,
--   config = function()
--     require("gruvbox").setup({
      -- transparent_mode = true, -- enable transparent background
--     })
--
--     vim.o.background = "dark" -- or "light"
--     vim.cmd.colorscheme("gruvbox")
--   end,
-- }

-- github themes
return {
  'projekt0n/github-nvim-theme',
  name = 'github-theme',
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  config = function()
    require('github-theme').setup({
      -- ...
    })

    -- vim.cmd('colorscheme github_dark_dimmed')
    vim.cmd('colorscheme github_dark_high_contrast')
    -- vim.cmd('colorscheme github_dark_default')
  end,
}


--gruvbox v2
-- return {
-- "xero/miasma.nvim",
-- lazy = false,
-- priority = 1000,
-- config = function()
-- 	vim.cmd("colorscheme miasma")
-- end,
-- }
