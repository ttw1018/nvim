local node_modules = function()
  if jit.os == "OSX" then
    return "/Users/twtang/.localbin/node-v22.12.0-darwin-x64/lib/node_modules"
  else
    return "/usr/lib/node_modules"
  end
end

local latex_pdf_view = function()
  if jit.os == "OSX" then
    return "skim"
  else
    return "zathura"
  end
end

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
  {
    "neovim/nvim-lspconfig",
    event = "BufRead",
    version = "*",
    opts = {
      on_attach = function()
        local map = vim.keymap.set
        local opts = { noremap = true, silent = true }

        map("n", "gd", vim.lsp.buf.definition, opts)
        map("n", "gi", vim.lsp.buf.implementation, opts)
        map("n", "gr", vim.lsp.buf.references, opts)

        map("n", "<leader>ca", vim.lsp.buf.code_action, opts)
        map("n", "<leader>rn", vim.lsp.buf.rename, opts)
        map("n", "<leader>k", vim.lsp.buf.hover, opts)
        map("n", "<leader>d", vim.diagnostic.open_float, opts)

        if vim.bo.filetype == "tex" then
          map("n", "<leader>jj", "<cmd>TexlabForward<cr>")
          map("n", "<leader>rn", "<cmd>TexlabChangeEnvironment<cr>")
          map("n", "<leader>ll", "<cmd>VimtexCompile<cr>")
        end
      end,

      servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = {
                version = "LuaJIT",
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          },
        },
        texlab = {
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
        },
        pyright = {},
        clangd = {},
        volar = {
          init_options = {
            typescript = {
              tsdk = node_modules() .. "/typescript/lib",
            },
          },
        },
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = "@vue/typescript-plugin",
                location = node_modules() .. "/@vue/typescript-plugin",
                languages = { "javascript", "typescript", "vue" },
              },
            },
          },
          filetypes = {
            "javascript",
            "typescript",
            "vue",
          },
        },
        gopls = {},
        rust_analyzer = {},
      },
    },

    config = function(_, opts)
      local lspconfig = require("lspconfig")
      for server, config in pairs(opts.servers) do
        config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        config.on_attach = opts.on_attach
        lspconfig[server].setup(config)
      end
    end,
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    event = "BufRead",
    version = "*",
    lazy = true,
    config = function()
      require("mason").setup()
    end,
  },
  {
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
  },
}
