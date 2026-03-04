return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", desc = "Markdown render toggle" },
    { "<leader>me", "<cmd>RenderMarkdown enable<CR>", desc = "Markdown render enable" },
    { "<leader>md", "<cmd>RenderMarkdown disable<CR>", desc = "Markdown render disable" },
    { "<leader>mx", "<cmd>RenderMarkdown expand<CR>", desc = "Markdown render expand" },
    { "<leader>mc", "<cmd>RenderMarkdown contract<CR>", desc = "Markdown render contract" },
  },
  opts = {
    file_types = { "markdown" },
  },
}
