require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "dockerfile",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "toml",
    "typescript",
    "vim",
    "yaml",
    "java"
  },
  highlight = {
    enable = true,
  },
  sync_install = false,
  auto_install = true,
}