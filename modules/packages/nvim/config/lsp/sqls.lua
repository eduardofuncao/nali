--@brief
---
--- https://github.com/sqls-server/sqls
---
--- ```lua
--- vim.lsp.config('sqls', {
---   cmd = {"path/to/command", "-config", "path/to/config.yml"};
---   ...
--- })
--- ```
--- Sqls can be installed via `go install github.com/sqls-server/sqls@latest`. Instructions for compiling Sqls from the source can be found at [sqls-server/sqls](https://github.com/sqls-server/sqls).
---
--- Squix integration: squix owns the connection config. Run `squix lsp` (or it
--- regenerates on `squix init`/`squix switch`) to write ~/.config/squix/lsp/sqls.yml,
--- then point sqls at it. The active squix connection is listed first, so sqls
--- uses it as default.
---
---@type vim.lsp.Config
return {
  cmd = { 'sqls', '-config', os.getenv('HOME') .. '/.config/squix/lsp/sqls.yml' },
  filetypes = { 'sql', 'mysql' },
  settings = {},
}
