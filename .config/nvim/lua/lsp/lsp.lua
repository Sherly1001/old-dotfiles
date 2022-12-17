-- vi: ts=2 sw=2

local lsp = {
  bashls = {},
  tsserver = {},
  clangd = {},
  gopls = {},
  rust_analyzer = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
      },
    },
  },
}

return lsp
