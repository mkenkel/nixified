return {
  "cenk1cenk2/schema-companion.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope.nvim" },
  },
  config = function()
    require("schema-companion").setup({
      -- if you have telescope you can register the extension -- not loaded automatically.
      enable_telescope = true,
      matchers = {
        require("schema-companion.matchers.kubernetes").setup({ version = "master" }),
      },
      schemas = {
        {
          name = "Kubernetes master",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/master-standalone-strict/all.json",
        },
      }
    })
    vim.keymap.set("n", "<leader>ss",
      "<cmd>lua require('telescope').extensions.schema_companion.select_schema()<CR>",
      { desc = "Select from all Schemas." })

    vim.keymap.set("n", "<leader>sms",
      "<cmd>lua require('telescope').extensions.schema_companion.select_from_matching_schemas()<CR>",
      { desc = "Select from matching Schemas." })
  end,
}
