return {
  'windwp/nvim-autopairs',
  dependencies = "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  config = function()
    -- import autopairs
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      check_ts = true,                      -- Check treesitter
      ts_config = {
        lua = { "string" },                 -- Don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- Dont add pairs in javascript template_string treesitter nodes
        java = false,                       -- Don't check treesitter when in java.
      },
    })

    -- import nvim-autopairs completion functionality
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")

    -- Import nvim-cmp plugin (Completions plugin)
    local cmp = require("cmp")

    -- Make autopairs and completion work together
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}
