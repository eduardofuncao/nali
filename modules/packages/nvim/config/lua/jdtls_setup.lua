vim.pack.add({ 'https://github.com/mfussenegger/nvim-jdtls' })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    local ok, mod = pcall(require, 'jdtls')
    if not ok or type(mod) ~= 'table' or type(mod.start_or_attach) ~= 'function' then
      vim.notify('jdtls: plugin not loadable: ' .. tostring(mod), vim.log.levels.ERROR)
      return
    end

    local root = vim.fs.root(0, { 'mvnw', 'gradlew', 'settings.gradle', 'build.gradle', 'pom.xml', '.git' })
    if not root then
      vim.notify('jdtls: no project root found', vim.log.levels.WARN)
      return
    end

    local workspace = vim.fn.stdpath('cache') .. '/jdtls/' .. vim.fn.fnamemodify(root, ':p:h:t')
    vim.fn.mkdir(workspace, 'p')

    local cmd = { 'jdtls' }
    -- Server itself runs on Java 21 regardless of PATH/openjdk version.
    if vim.env.JAVA21_HOME and vim.env.JAVA21_HOME ~= '' then
      table.insert(cmd, '--java-executable=' .. vim.env.JAVA21_HOME .. '/bin/java')
    end
    -- nixpkgs jdtls wrapper has no JDTLS_JVM_ARGS support, convert to --jvm-arg.
    if vim.env.JDTLS_JVM_ARGS and vim.env.JDTLS_JVM_ARGS ~= '' then
      table.insert(cmd, '--jvm-arg=' .. vim.env.JDTLS_JVM_ARGS)
    end
    table.insert(cmd, '-data')
    table.insert(cmd, workspace)

    mod.start_or_attach({
      cmd = cmd,
      root_dir = root,
      settings = {
        java = {
          configuration = {
            runtimes = {
              { name = 'JavaSE-11', path = vim.env.JAVA11_HOME },
              { name = 'JavaSE-21', path = vim.env.JAVA21_HOME, default = true },
            },
          },
          import = {
            maven = { enabled = true },
            gradle = { enabled = true, wrapper = { enabled = true } },
          },
        },
      },
      init_options = { bundles = {} },
    })

    vim.keymap.set('n', 'gf', function() require('jdtls').organize_imports() end,
      { buffer = true, desc = 'Organize imports' })
    vim.keymap.set('v', '<leader>ev', function() require('jdtls').extract_variable() end,
      { buffer = true, desc = 'Extract variable' })
    vim.keymap.set('v', '<leader>em', function() require('jdtls').extract_method() end,
      { buffer = true, desc = 'Extract method' })
  end,
})
