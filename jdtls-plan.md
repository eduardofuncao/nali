# nvim-jdtls plan — backend_appjobs-omni

Target repo: Maven wrapper, Boot 2.4.4, Java 11, Lombok + MapStruct.
Fits current `hjem` + `vim.lsp` layout.

## 1. Nix `modules/packages/programming.nix`

Add: `jdt-language-server`, `maven`, `jdk11`, `jdk21`, `lombok`. Keep `openjdk`.

Add `environment.sessionVariables`:
- `JAVA11_HOME="${pkgs.jdk11}/lib/openjdk"`
- `JAVA21_HOME="${pkgs.jdk21}/lib/openjdk"`
- `JDTLS_JVM_ARGS="-javaagent:${pkgs.lombok}/share/java/lombok.jar"`

Why env: `hjem` symlinks static lua, no Nix interpolation. Lua reads `vim.env`.
`jdtls` wrapper converts `JDTLS_JVM_ARGS` to `--jvm-arg`. Jar path `${pkgs.lombok}/share/java/lombok.jar` verified.

## 2. Plugin load `modules/packages/nvim/config/lua/jdtls.lua` (new)

```lua
vim.pack.add({ 'https://github.com/mfussenegger/nvim-jdtls' })
```

Edit `config/init.lua`: add `require("jdtls")` before FileType fires.

## 3. Main config `modules/packages/nvim/config/ftplugin/java.lua` (new)

- No `vim.lsp.enable("jdtls")`. Use `require('jdtls').start_or_attach(config)`.
- `cmd = { 'jdtls' }`
- `root_dir = vim.fs.root(0, { 'mvnw', 'gradlew', '.git', 'pom.xml' })`
- Workspace per-project: `vim.fn.stdpath('cache') .. '/jdtls/' .. vim.fn.fnamemodify(root, ':p:h:t')`
- `settings.java.configuration.runtimes`:
  - `{ name = 'JavaSE-11', path = vim.env.JAVA11_HOME }`
  - `{ name = 'JavaSE-21', path = vim.env.JAVA21_HOME, default = true }`
  - Server runs 21, project compiles 11.
- `import = { maven = { enabled = true }, gradle = { enabled = false } }`, MapStruct via Maven import.
- `init_options = { bundles = {} }`
- Keys: `gf` organize imports, `<leader>ev/em` extract var/method. Reuse `<leader>f`, `grd` from `lsp-config.lua`.

## 4. Wire `modules/packages/nvim/neovim.nix`

Add hjem entries:
- `".config/nvim/lua/jdtls.lua".source`
- `".config/nvim/ftplugin/java.lua".source`

Keep `jdtls` out of `config/lua/lsp-config.lua` enable list (conflicts with `start_or_attach`).

## 5. `config/lua/treesitter.lua`

Add `"java"` to `install()` + FileType autocmd pattern.

## 6. Verify

- `nixos-rebuild switch --flake .#<host>`
- `jdtls --help`, `echo $JDTLS_JVM_ARGS`
- `nvim /home/eduardo/projects/petz/repo-back/backend_appjobs-omni/.../*.java`
- `:checkhealth vim.lsp`, `:LspInfo`
- Lombok `@Data` resolves, `org.springframework.*` completes, no `invalid target release: 11`.

## Notes

- No Spring Tools LS. Classpath completion from Maven deps enough. No Boot property/bean smarts.
- Formatter: LSP default. Repo `settings/codestyle/intellij-java-google-style.xml` is IntelliJ format, jdtls needs Eclipse xml — convert later if needed.
