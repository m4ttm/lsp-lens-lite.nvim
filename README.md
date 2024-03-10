# lsp-lens-lite.nvim

Fork of [lsp-lens.nvim](https://github.com/VidocqH/lsp-lens.nvim). The original lsp-lens.nvim adds adds a code lens for LSPs which do not implement a `textDocument/codeLens` request. This is achieved by using the `textDocument/documentSymbol` request to get nodes to prefix with a code lens then counts the results of `textDocument/references` and `textDocument/definition` requests to create the code lens.

A problem is that some LSPs do not implement a `textDocument/documentSymbol` request, so the original lsp-lens.nvim does not work with them. This fork adds a workaround for this problem by using treesitter to get the nodes to prefix with a code lens, and only uses the LSP to obtain results to count to display in the code lens.

<img width="376" alt="image" src="https://user-images.githubusercontent.com/16725418/217580076-7064cc80-664c-4ade-8e66-a0c75801cf17.png">

## Installation

### Prerequisite

neovim >= 0.8

lsp server correctly setup

### Lazy

```lua
require("lazy").setup({
  'm4ttm/lsp-lens-lite.nvim'
})
```

### Usage

```lua
require'lsp-lens-lite'.setup({})
```

## Configs

Below is the default config

```lua
local SymbolKind = vim.lsp.protocol.SymbolKind

require'lsp-lens-lite'.setup({
  enable = true,
  include_declaration = false,      -- Reference include declaration
  sections = {                      -- Enable / Disable specific request, formatter example looks 'Format Requests'
    definition = false,
    references = true,
    implements = true,
    git_authors = true,
  },
  filetypes = {},
  -- Target Symbol Kinds to show lens information
  target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
  -- Symbol Kinds that may have target symbol kinds as children
  wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
})
```

### Format Requests

```lua
require'lsp-lens-lite'.setup({
  sections = {
    definition = function(count)
        return "Definitions: " .. count
    end,
    references = function(count)
        return "References: " .. count
    end,
    implements = function(count)
        return "Implements: " .. count
    end,
    git_authors = function(latest_author, count)
        return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
    end,
  }
})

```

## Commands

```
:LspLensLiteOn
:LspLensLiteOff
:LspLensLiteToggle
```

## Highlight

```lua
{
  LspLensLite = { link = "Comment" },
}
```

## Known Bug

- Due to a [known issue](https://github.com/neovim/neovim/issues/16166) with the neovim `nvim_buf_set_extmark()` api, the function and method defined on the first line of the code may cause the len to display at the -1 index line, which is not visible.

## Thanks

[lspsaga by glepnir](https://github.com/glepnir/lspsaga.nvim#customize-appearance)
