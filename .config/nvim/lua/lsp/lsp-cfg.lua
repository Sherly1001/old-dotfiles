-- vi: ts=2 sw=2

local system_signs = require('settings.signs')

require('mason-lspconfig').setup()
require('mason').setup {
  ui = {
    icons = {
      package_installed = system_signs.installed,
      package_pending = system_signs.pending,
      package_uninstalled = system_signs.uninstalled,
    }
  }
}

-- setup lsp server
local cfg = require('lspconfig')
local cap = require('cmp_nvim_lsp').default_capabilities()

package.preload['lsp.lsp'] = nil
local lsp = require('lsp.lsp')

local gopts = {
  capabilities = cap,
}

for name, opt in pairs(lsp) do
  if opt then
    opt = vim.tbl_extend('force', gopts, opt)
  end

  cfg[name].setup(opt)
end

-- setup nvim-cmp
local cmp = require('cmp')

local feedkey = function(key, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn['vsnip#anonymous'](args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert({
    ['<c-space>'] = cmp.mapping.complete(),
    ['<cr>'] = cmp.mapping.confirm({ select = true }),

    ['<tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available'](1) == 1 then
        feedkey('<Plug>(vsnip-expand-or-jump)', '')
      else
        fallback()
      end
    end, { 'i', 's' }),

    ['<s-tab>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkey('<Plug>(vsnip-jump-prev)', '')
      end
    end, { 'i', 's' }),
  }),

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
  }, {
    { name = 'path' },
    { name = 'buffer' },
  })
}

local signs = {
  { name = 'DiagnosticSignError', text = system_signs.error },
  { name = 'DiagnosticSignWarn', text = system_signs.warn },
  { name = 'DiagnosticSignHint', text = system_signs.hint },
  { name = 'DiagnosticSignInfo', text = system_signs.info },
}

for _, sign in ipairs(signs) do
  vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
end

local config = {
  virtual_text = false,
  signs = {
    active = signs,
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = 'minimal',
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
}

vim.diagnostic.config(config)

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = 'rounded',
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = 'rounded',
})
