in this dir ill put flake templates, depending on ecosystem used so that i can get started with a
project straight away. below are the packages that i used to have installed that i decided to
seperate from my global config into per-project flakes:

```
# language servers (note that the some language servers are also linters, so it can overlap)
basedpyright
pyright # not in vim.lsp.enable, kept because mason had it
ruff # doubles as the python linter for nvim-lint
texlab # latex
clang-tools # clangd + clang-format come from the same package
rust-analyzer
roslyn-ls # c#; roslyn.nvim falls back to Microsoft.CodeAnalysis.LanguageServer on PATH
jdt-language-server # ships the `jdtls` wrapper that ftplugin/java.lua launches

# formatters
black
rustfmt
csharpier
google-java-format
# uncomment only if u want latex installed on the machine as it takes a long time.
# texliveFull
pgformatter # binary is `pg_format`
taplo
prettier

# linters
lua51Packages.luacheck
vale
```
