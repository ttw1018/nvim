local pdviewer = function()
  if jit.os == "OSX" then
    return {
      executable = "/Applications/Skim.app/Contents/SharedSupport/displayline",
      args = {
        "-r",
        "-b",
        "-g",
        "%l",
        "%p",
        "%f",
      },
    }
  else
    return {
      executable = "zathura",
      args = { "--synctex-forward", "%l:1:%f", "%p" },
    }
  end
end

return {
  cmd = { "texlab" },
  filetypes = { "tex", "plaintex", "bib" },
  root_markers = { ".git", ".latexmkrc", "latexmkrc", ".texlabroot", "texlabroot", "Tectonic.toml" },
  settings = {
    texlab = {
      build = {
        executable = "latexmk",
        args = {
          "--silent",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-outdir=build",
          "-xelatex",
          "%f",
        },
        pdfDirectory = "build",
      },
      forwardSearch = pdviewer(),
    },
  },
}
