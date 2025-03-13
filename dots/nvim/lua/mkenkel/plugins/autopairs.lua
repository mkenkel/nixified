return {
  'windwp/nvim-autopairs',
  dependencies = "hrsh7th/nvim-cmp",
  event = "InsertEnter",

  opts = {
    check_ts = true,                      -- Check treesitter
    ts_config = {
      lua = { "string" },                 -- Don't add pairs in lua string treesitter nodes
      javascript = { "template_string" }, -- Dont add pairs in javascript template_string treesitter nodes
      java = false,                       -- Don't check treesitter when in java.
    },

  },
  -- Make autopairs and completion work together
  require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done()),
}
