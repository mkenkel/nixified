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
        {
          name = "Kubernetes v1.30",
          uri =
          "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.3-standalone-strict/all.json",
        },
      }
    })
  end,
}
