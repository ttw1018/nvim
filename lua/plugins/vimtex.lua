local latex_pdf_view = function()
  if jit.os == "OSX" then
    return "skim"
  else
    return "zathura"
  end
end

return {
  "lervag/vimtex",
  version = "*",
  init = function()
    local g = vim.g
    g.vimtex_compiler_latexmk_engines = {
      _ = "-xelatex",
    }
    g.vimtex_view_method = latex_pdf_view()
    g.vimtex_compiler_latexmk = {
      aux_dir = "build",
      out_dir = "build",
      continuous = 1,
      options = {
        "-verbose",
        "-synctex=1",
        "-file-line-error",
        "-interaction=nonstopmode",
        "-outdir=build",
      },
    }
    g.vimtex_quickfix_open_on_warning = 0
    g.vimtex_quickfix_ignore_filters = {}
  end,
}
