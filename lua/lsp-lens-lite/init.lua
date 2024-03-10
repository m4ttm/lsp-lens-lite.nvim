local lens = require("lsp-lens-lite.lens-util")
local config = require("lsp-lens-lite.config")
local highlight = require("lsp-lens-lite.highlight")

local M = {}

local augroup = vim.api.nvim_create_augroup("lsp_lens_lite", { clear = true })

function M.setup(opts)
  config.setup(opts)
  highlight.setup()

  vim.api.nvim_create_user_command("LspLensLiteOn", lens.lsp_lens_lite_on, {})
  vim.api.nvim_create_user_command("LspLensLiteOff", lens.lsp_lens_lite_off, {})
  vim.api.nvim_create_user_command("LspLensLiteToggle", lens.lsp_lens_lite_toggle, {})

  vim.api.nvim_create_autocmd({ "LspAttach", "TextChanged", "BufEnter" }, {
    group = augroup,
    callback = lens.procedure,
  })
end

return M
