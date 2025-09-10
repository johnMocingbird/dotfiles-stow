return {
  "neovim/nvim-lspconfig",
  opts = function(_, opts)
    opts.servers.graphql = {
      filetypes = { "graphql", "gql", "javascript", "typescript", "javascriptreact", "typescriptreact" },
    }
  end,
}