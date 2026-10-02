---@brief
---
--- https://detachhead.github.io/basedpyright
---
--- `basedpyright`, a static type checker and language server for python
---
--- Tagged hints are disabled by default. See Pyright for more details.
--- Set `basedpyright.disableTaggedHints = false` to re-enable.

local function set_python_path(command)
  local path = command.args
  local clients = vim.lsp.get_clients {
    bufnr = vim.api.nvim_get_current_buf(),
    name = 'basedpyright',
  }
  for _, client in ipairs(clients) do
    if client.settings then
      ---@diagnostic disable-next-line: param-type-mismatch
      client.settings.python = vim.tbl_deep_extend('force', client.settings.python or {}, { pythonPath = path })
    else
      client.config.settings = vim.tbl_deep_extend('force', client.config.settings, { python = { pythonPath = path } })
    end
    client:notify('workspace/didChangeConfiguration', { settings = nil })
  end
end

---@type vim.lsp.Config
return {
  cmd = { 'basedpyright-langserver', '--stdio' },
  filetypes = { 'python' },
  root_markers = {
    'pyrightconfig.json',
    'pyproject.toml',
    'setup.py',
    'setup.cfg',
    'requirements.txt',
    'Pipfile',
    '.git',
  },
  ---@type lspconfig.settings.basedpyright
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = 'openFilesOnly',
        -- VSCode (Pylance) defaults to minimal checking ("off", opt-in "basic").
        -- basedpyright defaults to "recommended" (= everything as warning), which is
        -- why you see stub/unknown-type noise. "basic" ≈ VSCode with type checking on.
        typeCheckingMode = 'basic',
        -- Fall back to library source when no stubs exist; kills most
        -- "stub not found" noise without hiding real errors.
        useLibraryCodeForTypes = true,
        diagnosticSeverityOverrides = {
          -- "stub file not found for ..." (reportMissingTypeStubs)
          reportMissingTypeStubs = 'none',
          -- "type of X is unknown" noise from untyped 3rd-party libs
          reportUnknownParameterType = 'none',
          reportUnknownArgumentType = 'none',
          reportUnknownLambdaType = 'none',
          reportUnknownVariableType = 'none',
          reportUnknownMemberType = 'none',
          -- basedpyright-only Any rules (not part of pyright basic/standard)
          reportAny = 'none',
          reportExplicitAny = 'none',
          -- missing/untyped-annotation noise (VSCode basic doesn't nag these)
          reportMissingParameterType = 'none',
          reportUntypedFunctionDecorator = 'none',
          reportUntypedClassDecorator = 'none',
          reportUntypedBaseClass = 'none',
          reportUntypedNamedTuple = 'none',
          -- basedpyright-only strictness not present in VSCode defaults
          reportPrivateLocalImportUsage = 'none',
          reportImplicitRelativeImport = 'none',
          reportInvalidCast = 'none',
          reportUnsafeMultipleInheritance = 'none',
          reportUnusedParameter = 'none',
          reportIgnoreCommentWithoutRule = 'none',
        },
        -- Default is true upstream; set explicitly so untyped 3rd-party
        -- libs fall back to source instead of "stub not found" errors.
        -- Per-project pyproject.toml / pyrightconfig.json still wins when present.
      },
      -- ruff handles organize-imports; avoid two providers fighting.
      disableOrganizeImports = true,
      disableTaggedHints = true,
    },
  },
  on_attach = function(client, bufnr)
    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightOrganizeImports', function()
      local params = {
        command = 'basedpyright.organizeimports',
        arguments = { vim.uri_from_bufnr(bufnr) },
      }

      -- Using client.request() directly because "basedpyright.organizeimports" is private
      -- (not advertised via capabilities), which client:exec_cmd() refuses to call.
      -- https://github.com/neovim/neovim/blob/c333d64663d3b6e0dd9aa440e433d346af4a3d81/runtime/lua/vim/lsp/client.lua#L1024-L1030
      ---@diagnostic disable-next-line: param-type-mismatch
      client.request('workspace/executeCommand', params, nil, bufnr)
    end, {
      desc = 'Organize Imports',
    })

    vim.api.nvim_buf_create_user_command(bufnr, 'LspPyrightSetPythonPath', set_python_path, {
      desc = 'Reconfigure basedpyright with the provided python path',
      nargs = 1,
      complete = 'file',
    })
  end,
}
