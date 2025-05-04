local function config()
  local conditions = require("heirline.conditions")
  local utils = require("heirline.utils")
  local bg = "bg"

  local ViMode = {
    init = function(self)
      self.mode = vim.fn.mode(1) -- :h mode()
    end,
    static = {
      mode_names = { -- change the strings if you like it vvvvverbose!
        n = "N",
        no = "N?",
        nov = "N?",
        noV = "N?",
        ["no\22"] = "N?",
        niI = "Ni",
        niR = "Nr",
        niV = "Nv",
        nt = "Nt",
        v = "V",
        vs = "Vs",
        V = "V_",
        Vs = "Vs",
        ["\22"] = "^V",
        ["\22s"] = "^V",
        s = "S",
        S = "S_",
        ["\19"] = "^S",
        i = "I",
        ic = "Ic",
        ix = "Ix",
        R = "R",
        Rc = "Rc",
        Rx = "Rx",
        Rv = "Rv",
        Rvc = "Rv",
        Rvx = "Rv",
        c = "C",
        cv = "Ex",
        r = "...",
        rm = "M",
        ["r?"] = "?",
        ["!"] = "!",
        t = "T",
      },
      mode_colors = {
        n = "red",
        i = "green",
        v = "cyan",
        V = "cyan",
        ["\22"] = "cyan",
        c = "orange",
        s = "purple",
        S = "purple",
        ["\19"] = "purple",
        R = "orange",
        r = "orange",
        ["!"] = "red",
        t = "red",
      },
    },

    provider = function(self)
      return " %2(" .. self.mode_names[self.mode] .. "%) "
    end,
    hl = function(self)
      local mode = self.mode:sub(1, 1) -- get only the first mode character
      return { fg = self.mode_colors[mode], bold = true, bg = bg }
    end,
    -- Re-evaluate the component only on ModeChanged event!
    -- Also allows the statusline to be re-evaluated when entering operator-pending mode
    update = {
      "ModeChanged",
      pattern = "*:*",
      callback = vim.schedule_wrap(function()
        vim.cmd("redrawstatus")
      end),
    },
  }

  local FileNameBlock = {
    -- let's first set up some attributes needed by this component and its children
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(0)
    end,
    hl = { bg = bg },
  }
  -- We can now define some children separately and add them later

  local FileIcon = {
    init = function(self)
      local filename = self.filename
      local extension = vim.fn.fnamemodify(filename, ":e")
      self.icon, self.icon_color = require("nvim-web-devicons").get_icon_color(filename, extension, { default = true })
    end,
    provider = function(self)
      return self.icon and (" " .. self.icon .. " ")
    end,
    hl = function(self)
      return { fg = self.icon_color }
    end,
  }

  local FileName = {
    provider = function(self)
      local filename = vim.fn.fnamemodify(self.filename, ":.")
      if filename == "" then
        return "[No Name]"
      end
      if not conditions.width_percent_below(#filename, 0.25) then
        filename = vim.fn.pathshorten(filename)
      end
      return filename
    end,
    hl = { fg = "fg", bg = bg },
  }

  local FileFlags = {
    {
      condition = function()
        return vim.bo.modified
      end,
      provider = "[+]",
      hl = { fg = "green", bg = bg },
    },
    {
      condition = function()
        return not vim.bo.modifiable or vim.bo.readonly
      end,
      provider = " ",
      hl = { fg = "orange", bg = bg },
    },
  }

  local FileNameModifer = {
    hl = function()
      if vim.bo.modified then
        -- use `force` because we need to override the child's hl foreground
        return { bold = true, force = true, bg = bg }
      end
    end,
  }

  -- let's add the children to our FileNameBlock component
  FileNameBlock = utils.insert(
    FileNameBlock,
    FileIcon,
    utils.insert(FileNameModifer, FileName), -- a new table where FileName is a child of FileNameModifier
    FileFlags,
    { provider = "%<" } -- this means that the statusline is cut here when there's not enough space
  )

  -- local FileType = {
  --   provider = function()
  --     return string.upper(vim.bo.filetype)
  --   end,
  --   hl = { fg = utils.get_highlight("Type").fg, bold = true, bg = bg },
  -- }

  local FileSize = {
    provider = function()
      -- stackoverflow, compute human readable file size
      local suffix = { "b", "k", "M", "G", "T", "P", "E" }
      local fsize = vim.fn.getfsize(vim.api.nvim_buf_get_name(0))
      fsize = (fsize < 0 and 0) or fsize
      if fsize < 1024 then
        return fsize .. suffix[1]
      end
      local i = math.floor((math.log(fsize) / math.log(1024)))
      return string.format("%.1f%s", fsize / math.pow(1024, i), suffix[i + 1])
    end,
    hl = { fg = "fg", bg = bg },
  }
  local LSPActive = {
    condition = conditions.lsp_attached,
    update = { "LspAttach", "LspDetach" },

    -- You can keep it simple,
    -- provider = " [LSP]",

    -- Or complicate things a bit and get the servers names
    provider = function()
      local names = {}
      for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
        table.insert(names, server.name)
      end
      return " [" .. table.concat(names, " ") .. "]"
    end,
    hl = { fg = "green", bold = true, bg = bg },
  }
  local Diagnostics = {

    condition = conditions.has_diagnostics,

    static = {
      error_icon = " ",
      warn_icon = " ",
      info_icon = " ",
      hint_icon = " ",
    },

    init = function(self)
      self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
    end,

    update = { "DiagnosticChanged", "BufEnter" },

    {
      provider = " ",
      hl = { bg = bg },
    },
    {
      provider = function(self)
        -- 0 is just another output, we can decide to print it or not!
        return self.errors > 0 and (self.error_icon .. self.errors .. " ")
      end,
      hl = { fg = "#ec5f67", bg = bg },
    },
    {
      provider = function(self)
        return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
      end,
      hl = { fg = "#ECBE7B", bg = bg },
    },
    {
      provider = function(self)
        return self.info > 0 and (self.info_icon .. self.info .. " ")
      end,
      hl = { fg = "#008080", bg = bg },
    },
    {
      provider = function(self)
        return self.hints > 0 and (self.hint_icon .. self.hints .. " ")
      end,
      hl = { bg = bg },
    },
    {
      provider = " ",
      hl = { bg = bg },
    },
  }

  BoundaryLeft = {
    provider = "▊ ",
    hl = {
      fg = "#51afef",
      bg = bg,
    },
  }
  BoundaryRight = {
    provider = " ▊",
    hl = {
      fg = "#51afef",
      bg = bg,
    },
  }

  local Ruler = {
    provider = "%9(%l/%L%):%2c %P",
    hl = {
      bg = bg,
    },
  }

  local Git = {
    condition = conditions.is_git_repo,

    init = function(self)
      self.status_dict = vim.b.gitsigns_status_dict
      self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = "orange", bg = bg },

    { -- git branch name
      provider = function(self)
        if self.status_dict.head then
          return " " .. self.status_dict.head .. " "
        end
      end,
      hl = { bold = true, bg = bg },
    },
    {
      provider = function(self)
        local count = self.status_dict.added or 0
        return count > 0 and (" " .. count .. " ")
      end,
      hl = { fg = "green", bg = bg },
    },
    {
      provider = function(self)
        local count = self.status_dict.changed or 0
        return count > 0 and (" " .. count .. " ")
      end,
      hl = { fg = "orange", bg = bg },
    },
    {
      provider = function(self)
        local count = self.status_dict.removed or 0
        return count > 0 and (" " .. count .. " ")
      end,
      hl = { fg = "red", bg = bg },
    },
  }
  local TablineBufnr = {
    provider = function(self)
      return tostring(self.bufnr) .. ". "
    end,
    hl = "Comment",
  }

  -- we redefine the filename component, as we probably only want the tail and not the relative path
  local TablineFileName = {
    provider = function(self)
      -- self.filename will be defined later, just keep looking at the example!
      local filename = self.filename
      filename = filename == "" and "[No Name]" or vim.fn.fnamemodify(filename, ":t")
      return filename
    end,
    hl = function(self)
      return { bold = self.is_active or self.is_visible, italic = true }
    end,
  }

  -- this looks exactly like the FileFlags component that we saw in
  -- #crash-course-part-ii-filename-and-friends, but we are indexing the bufnr explicitly
  -- also, we are adding a nice icon for terminal buffers.
  local TablineFileFlags = {
    {
      condition = function(self)
        return vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
      end,
      provider = "[+]",
      hl = { fg = "green" },
    },
    {
      condition = function(self)
        return not vim.api.nvim_get_option_value("modifiable", { buf = self.bufnr })
          or vim.api.nvim_get_option_value("readonly", { buf = self.bufnr })
      end,
      provider = function(self)
        if vim.api.nvim_get_option_value("buftype", { buf = self.bufnr }) == "terminal" then
          return "  "
        else
          return " "
        end
      end,
      hl = { fg = "orange" },
    },
  }

  local TablineFileNameBlock = {
    init = function(self)
      self.filename = vim.api.nvim_buf_get_name(self.bufnr)
    end,
    hl = function(self)
      if self.is_active then
        return "TabLineSel"
      else
        return "TabLine"
      end
    end,
    on_click = {
      callback = function(_, minwid, _, button)
        if button == "m" then -- close on mouse middle click
          vim.schedule(function()
            vim.api.nvim_buf_delete(minwid, { force = false })
          end)
        else
          vim.api.nvim_win_set_buf(0, minwid)
        end
      end,
      minwid = function(self)
        return self.bufnr
      end,
      name = "heirline_tabline_buffer_callback",
    },
    TablineBufnr,
    FileIcon, -- turns out the version defined in #crash-course-part-ii-filename-and-friends can be reutilized as is here!
    TablineFileName,
    TablineFileFlags,
  }

  -- a nice "x" button to close the buffer
  local TablineCloseButton = {
    condition = function(self)
      return not vim.api.nvim_get_option_value("modified", { buf = self.bufnr })
    end,
    { provider = " " },
    {
      provider = "󰅙 ",
      hl = { fg = "gray" },
      on_click = {
        callback = function(_, minwid)
          vim.schedule(function()
            vim.api.nvim_buf_delete(minwid, { force = false })
            vim.cmd.redrawtabline()
          end)
        end,
        minwid = function(self)
          return self.bufnr
        end,
        name = "heirline_tabline_close_buffer_callback",
      },
    },
  }

  -- { "", "" }
  -- { "", "" }
  local TablineBufferBlock = utils.surround({ "", "" }, function(self)
    if self.is_active then
      return utils.get_highlight("TabLineSel").bg
    else
      return utils.get_highlight("TabLine").bg
    end
  end, { TablineFileNameBlock, TablineCloseButton })

  local get_bufs = function()
    return vim.tbl_filter(function(bufnr)
      return vim.api.nvim_get_option_value("buflisted", { buf = bufnr })
    end, vim.api.nvim_list_bufs())
  end

  -- initialize the buflist cache
  local buflist_cache = {}

  -- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
  vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
    callback = function()
      vim.schedule(function()
        local buffers = get_bufs()
        for i, v in ipairs(buffers) do
          buflist_cache[i] = v
        end
        for i = #buffers + 1, #buflist_cache do
          buflist_cache[i] = nil
        end

        -- check how many buffers we have and set showtabline accordingly
        if #buflist_cache > 1 then
          vim.o.showtabline = 2 -- always
        elseif vim.o.showtabline ~= 1 then -- don't reset the option if it's already at default value
          vim.o.showtabline = 1 -- only when #tabpages > 1
        end
      end)
    end,
  })

  local BufferLine = utils.make_buflist(
    TablineBufferBlock,
    { provider = " ", hl = { fg = "gray" } },
    { provider = " ", hl = { fg = "gray" } },
    function()
      return buflist_cache
    end,
    false
  )

  local StatusColumn = {
    condition = function()
      return vim.bo.filetype ~= "NvimTree"
    end,
    static = {
      gitsign_nid = nil,
    },
    init = function(self)
      self.sign = "%=%{v:relnum?v:relnum:v:lnum} %s"
      self.color = nil

      if vim.v.virtnum ~= 0 then
        self.sign = ""
        if self.gitsign_nid == nil then
          self.gitsign_nid = vim.api.nvim_get_namespaces()["gitsigns_signs_"]
          if self.gitsign_nid == nil then
            return
          end
        end
        local lnum = vim.v.lnum
        local signs = vim.api.nvim_buf_get_extmarks(
          0,
          self.gitsign_nid,
          { lnum - 1, 0 },
          { lnum - 1, 0 },
          { details = true, hl_name = true, type = "sign", limit = 1 }
        )
        for _, sign in ipairs(signs) do
          local detail = sign[4]
          if detail ~= nil then
            self.sign = "%=" .. detail["sign_text"]
            self.color = vim.api.nvim_get_hl(0, { name = detail["sign_hl_group"] })
          end
        end
      end
    end,

    provider = function(self)
      return self.sign
    end,
    hl = function(self)
      return self.color
    end,
  }
  local Navic = {
    condition = function()
      return require("nvim-navic").is_available()
    end,
    provider = function()
      return require("nvim-navic").get_location({ highlight = true })
    end,
    update = "CursorMoved",
  }

  return {
    statusline = {
      BoundaryLeft,
      ViMode,
      Git,
      { provider = "%=", hl = { bg = bg } },
      FileSize,
      FileNameBlock,
      { provider = "%=", hl = { bg = bg } },
      LSPActive,
      Diagnostics,
      { provider = "%=", hl = { bg = bg } },
      Ruler,
      BoundaryRight,
    },
    tabline = {
      BufferLine,
    },
    statuscolumn = {
      StatusColumn,
    },

    winbar = {
      FileNameBlock,
      { provider = "  " },
      Navic,
    },
    opts = {
      disable_winbar_cb = function(args)
        return conditions.buffer_matches({
          buftype = { "nofile", "prompt", "help", "quickfix", "NvimTree", "terminal" },
          filetype = { "^git.*" },
        }, args.buf)
      end,
    },
  }
end

return {
  "rebelot/heirline.nvim",
  version = "*",
  config = function()
    local heirline = require("heirline")
    heirline.setup(config())
  end,
}
