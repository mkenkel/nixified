return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  opts = {
    prompt_for_file_name = false,
    file_name = "%M-%D-%YYYY-at-%H-%M-%S",
    extension = "avif", ---@type string
    process_cmd = "convert - -quality 75 avif:-", ---@type string
    -- drag and drop options
    drag_and_drop = {
      enabled = true, ---@type boolean | fun(): boolean
      insert_mode = false, ---@type boolean | fun(): boolean
    },
  },
    -- filetype specific options
  filetypes = {
    markdown = {
      -- encode spaces and special characters in file path
      url_encode_path = true, ---@type boolean
      template = "![$FILE_NAME]($FILE_PATH)", ---@type string
  },

  keys = {
    -- suggested keymap
    { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
