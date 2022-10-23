vim.g.vimtex_compiler_progname = 'nvr'
vim.g.vimtex_compiler_latexmk_engines = {
  ['_'] = '-xelatex',
}
vim.g.vimtex_quickfix_open_on_warning=0

vim.g.vimtex_compiler_latexmk = {
  ["build_dir"] = "output",
  ["continuous"] = 0,
  ["options"] = {
    "-verbose",
    "-file-line-error",
    "-shell-escape",
    "-synctex=1",
    "-interaction=nonstopmode",
  }
}
