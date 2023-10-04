local hl = function(name, table)
  vim.api.nvim_set_hl(0, name, table)
end

local M = {}

function M.with_config(config)
  M.config = vim.tbl_extend("force", {
    mason = true,
    navic = true,
    neo_tree = true,
    bufferline = true,
    telescope = true,
    indentblankline = true,
    notify = false,
    cmp = true,
    illuminate = false,
    nvimtree = false,
    gitsigns = true,
    alpha = true,
  }, config or M.config or {})
end

function M.setup(colors, config)
  M.with_config(config)

  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end

  M.colors = colors

  -- For Statusline
  hl("normalmode", { fg = M.colors.base0B, bold = true })
  hl("command", { fg = M.colors.base0A, bold = true })
  hl("visualmode", { fg = M.colors.purple, bold = true })
  hl("Insert", { fg = M.colors.base0D, bold = true })
  hl("Terminal", { link = "Insert", bold = true })
  hl("Replace", { fg = M.colors.red, bold = true })
  hl("linestatus", { fg = "white", bold = true })
  hl("dir", { fg = M.colors.base00, bg = M.colors.red, bold = true })
  hl("dir_sep", { fg = M.colors.red, bg = M.colors.base00 })

  --indent-blankline depracted!
  if M.config.indentblankline then
    hl("@ibl.scope.underline.1", { bg = M.colors.one_bg3 })
    hl("IndentBlankLineChar", { fg = M.colors.grey_fg })
    hl("indentblankline", { fg = M.colors.grey_fg })
  end

  if M.config.cmp then
    --auto completion
    -- hl("CmpItemMenuDefault", { fg = M.colors.base0D }
    hl("CmpItemMenu", { fg = M.colors.base0D })
    hl("CmpItemAbbr", { fg = M.colors.white })
    hl("CmpItemAbbrDefault", { link = "CmpItemAbbr" })
    hl("CmpItemAbbrMatch", { fg = M.colors.blue })
    hl("CmpBorder", { fg = M.colors.grey })
    hl("CmpDocumentation", { fg = M.colors.white, bg = M.colors.grey })
    hl("CmpDocumentationBorder", { link = "CmpBorder" })
    -- hl('CmpItemMenuDefault', { link = 'CmpItemAbbr' })
    hl("CmpItemKindConstant", { fg = M.colors.base09 })
    hl("CmpItemKindFunction", { fg = M.colors.base0D })
    hl("CmpItemKindIdentifier", { fg = M.colors.base08 })
    hl("CmpItemKindField", { fg = M.colors.base08 })
    hl("CmpItemKindVariable", { fg = M.colors.base0E })
    hl("CmpItemKindSnippet", { fg = M.colors.red })
    hl("CmpItemKindText", { fg = M.colors.base0B })
    hl("CmpItemKindStructure", { fg = M.colors.base0E })
    hl("CmpItemKindType", { fg = M.colors.base0A })
    hl("CmpItemKindMethod", { fg = M.colors.base0D })
    hl("CmpItemKindConstrucor", { fg = M.colors.blue })
    hl("CmpItemKindFolder", { fg = M.colors.base07 })
    hl("CmpItemKindModule", { fg = M.colors.base0A })
    hl("CmpItemKindProperty", { fg = M.colors.base08 })
    hl("CmpItemKindUnit", { fg = M.colors.base0E })
    hl("CmpItemKindFile", { fg = M.colors.base07 })
    hl("CmpItemKindColor", { fg = M.colors.red })
    hl("CmpItemKindRefrence", { fg = M.colors.base05 })
    hl("CmpItemKindStruct", { fg = M.colors.base0E })
    hl("CmpItemKindOperator", { fg = M.colors.base08 })
    hl("CmpItemKindTypeParameter", { fg = M.colors.base08 })
    hl("CmpItemKindCopilot", { fg = M.colors.green })
  end

  --Default
  -- hl("YankyPut", { link = "IncSearch" })
  -- hl("YankyYanked", { link = "IncSearch" })
  hl("StatusLine", { link = "Normal" })
  hl("MatchWord", { fg = nil, bg = M.colors.grey })
  hl("MatchParen", { link = "MatchWord" })
  hl("PMenu", { bg = M.colors.one_bg })
  hl("PMenuSbar", { link = "PMenu" })
  hl("PMenuSel", { fg = M.colors.black, bg = M.colors.pmenu_bg })
  hl("PMenuThumb", { bg = M.colors.grey })
  hl("Italic", { fg = M.colors.grey, italic = true })
  hl("CursorLineNr", { fg = M.colors.white })
  hl("LineNr", { fg = M.colors.grey })
  hl("FloatBorder", { fg = M.colors.blue })
  hl("NormalFloat", { fg = M.colors.white, bg = M.colors.darker_black })
  hl("NvimInternalError", { fg = M.colors.red })
  hl("WinSeparator", { fg = M.colors.line })
  hl("Normal", { fg = M.colors.base05, bg = M.colors.base00 })
  hl("EndofBuffer", { fg = M.colors.base00 })
  hl("Debug", { fg = M.colors.base08 })
  hl("Directory", { fg = M.colors.base0D })
  hl("NvimTreeBufferLine", { fg = M.colors.white, bg = M.colors.statusline_bg })
  hl("Error", { fg = M.colors.black, bg = M.colors.base08 })
  hl("ErrorMsg", { fg = M.colors.base08, bg = M.colors.base00 })
  hl("Exception", { fg = M.colors.base08 })
  hl("FoldColumn", { fg = M.colors.base0C, bg = M.colors.base01 })
  hl("Folded", { fg = M.colors.white, bg = M.colors.base01 })
  hl("InSearch", { fg = M.colors.base01, bg = M.colors.base0A })
  hl("CurSearch", { link = "InSearch" })
  hl("Macro", { fg = M.colors.base08 })
  hl("ModeMsg", { fg = M.colors.base0B })
  hl("MoreMsg", { fg = M.colors.base0B })
  hl("Question", { fg = M.colors.base0D })
  hl("Search", { fg = M.colors.white, bg = "#3d59a1" })
  hl("Subtitute", { fg = M.colors.base01, bg = M.colors.base0A, sp = nil })
  hl("SpecialKey", { fg = M.colors.base03 })
  hl("TooLong", { fg = M.colors.base08 })
  hl("UnderLined", { fg = M.colors.base0B, underline = true })
  hl("Visual", { bg = M.colors.base02 })
  hl("VisualNOS", { fg = M.colors.base08 })
  hl("WarningMsg", { fg = M.colors.base08 })
  hl("WildMenu", { fg = M.colors.base08, bg = M.colors.base0A })
  hl("Title", { fg = M.colors.base0D, sp = nil })
  hl("Cursor", { fg = M.colors.base00, bg = M.colors.base07 })
  hl("NonText", { fg = M.colors.base03 })
  hl("SignColumn", { bg = M.colors.base00, sp = nil })
  hl("CursorColumn", { bg = M.colors.base01 })
  hl("CursorLine", { bold = true })
  hl("QuickFixLine", { bg = M.colors.base01 })
  hl("healthSuccess", { fg = M.colors.green, bg = M.colors.black })

  --Diff
  hl("DiffAdd", { fg = M.colors.blue })
  hl("DiffAdded", { fg = M.colors.green })
  hl("DiffChange", { fg = M.colors.light_grey })
  hl("DiffChangeDelete", { fg = M.colors.red })
  hl("DiffModified", { fg = M.colors.orange })
  hl("DiffDelete", { fg = M.colors.red })
  hl("DiffRemoved", { fg = M.colors.red })

  -- git commits
  hl("gitcommitOverflow", { fg = M.colors.base08 })
  hl("gitcommitSummary", { fg = M.colors.base08 })
  hl("gitcommitComment", { fg = M.colors.base03 })
  hl("gitcommitUntracked", { fg = M.colors.base03 })
  hl("gitcommitDiscarded", { fg = M.colors.base03 })
  hl("gitcommitSelected", { fg = M.colors.base03 })
  hl("gitcommitHeader", { fg = M.colors.base0E })
  hl("gitcommitSelectedType", { fg = M.colors.base0D })
  hl("gitcommitUnmergedType", { fg = M.colors.base0D })
  hl("gitcommitDiscardedType", { fg = M.colors.base0D })
  hl("gitcommitBranch", { fg = M.colors.base09 })
  hl("gitcommitUntrackedFile", { fg = M.colors.base0A })
  hl("gitcommitUnmergedFile", { fg = M.colors.base08 })
  hl("gitcommitDiscardedFile", { fg = M.colors.base08 })
  hl("gitcommitSelectedFile", { fg = M.colors.base0B })

  --Lsp
  hl("LspReferenceText", { fg = nil, bg = M.colors.one_bg2 })
  hl("LspReferenceRead", { link = "LspReferenceText" })
  hl("LspReferenceWrite", { link = "LspReferenceText" })
  hl("DiagnosticHint", { fg = M.colors.purple })
  hl("DiagnosticError", { fg = M.colors.red })
  hl("DiagnosticWarn", { fg = M.colors.yellow })
  hl("DiagnosticInformation", { fg = M.colors.green })
  hl("LspSignatureActiveParameter", { fg = M.colors.black, bg = M.colors.green })
  hl("RenamerTitle", { fg = M.colors.black, bg = M.colors.red })
  hl("RenamerBorder", { fg = M.colors.red })

  if M.config.mason then
    --Madon
    hl("MasonHeader", { fg = M.colors.black, bg = M.colors.red })
    hl("MasonHighlight", { fg = M.colors.blue })
    hl("MasonHighlightBlock", { fg = M.colors.black, bg = M.colors.green })
    hl("MasonHighlightBlockBold", { link = "MasonHighlightBlock" })
    hl("MasonHeaderSecondary", { link = "MasonHighlightBlock" })
    hl("MasonMuted", { fg = M.colors.light_grey })
    hl("MasonMutedBlock", { fg = M.colors.light_grey, bg = M.colors.one_bg })
  end

  if M.config.nvimtree then
    --NvimTree
    hl("NvimTreeEmptyFolderName", { fg = M.colors.folder_bg })
    hl("NvimTreeEndOfBuffer", { fg = M.colors.darker_black })
    hl("NvimTreeFolderIcon", { fg = M.colors.folder_bg })
    hl("NvimTreeFolderName", { fg = M.colors.folder_bg })
    hl("NvimTreeGitDirty", { fg = M.colors.base0D })
    hl("NvimTreeIndentMarker", { fg = M.colors.grey_fg })
    hl("NvimTreeNormal", { bg = M.colors.darker_black })
    hl("NvimTreeNormalNC", { bg = M.colors.darker_black })
    hl("NvimTreeOpenedFolderName", { fg = M.colors.folder_bg })
    hl("NvimTreeGitIgnored", { fg = M.colors.light_grey })
    hl("NvimTreeWinSeparator", { fg = M.colors.darker_black, bg = M.colors.darker_black })
    hl("NvimTreeWindowPicker", { fg = M.colors.red, bg = M.colors.black2 })
    hl("NvimTreeCursorLine", { bg = M.colors.black2 })
    hl("NvimTreeGitNew", { fg = M.colors.green })
    hl("NvimTreeGitDeleted", { fg = M.colors.red })
    hl("NvimTreeSpecialFile", { fg = M.colors.yellow })
    hl("NvimTreeRootFolder", { fg = M.colors.base0E })
  end

  --syntax
  hl("Comment", { fg = M.colors.grey_fg, italic = true })
  hl("Conceal", { sp = nil })
  hl("bold", { bold = true })
  hl("Italic", { italic = true })
  hl("Boolean", { fg = M.colors.base09 })
  hl("Character", { fg = M.colors.base08 })
  hl("Conditional", { fg = M.colors.base0E })
  hl("Constant", { link = "Boolean" })
  hl("Define", { fg = M.colors.base0E, sp = nil })
  hl("Delimiter", { fg = M.colors.base0F })
  hl("Float", { link = "Boolean" })
  hl("Function", { fg = M.colors.base0D })
  hl("Identifier", { fg = M.colors.base08, sp = nil })
  hl("Include", { fg = M.colors.base0D })
  hl("Keyword", { fg = M.colors.base0E })
  hl("Label", { fg = M.colors.base0A })
  hl("Number", { fg = M.colors.base09 })
  hl("Operator", { fg = M.colors.base05, sp = nil })
  hl("PreProc", { fg = M.colors.base0A })
  hl("Repeat", { fg = M.colors.base0A })
  hl("Special", { fg = M.colors.base0C })
  hl("SpecialChar", { fg = M.colors.base0F })
  hl("Statement", { fg = M.colors.base08 })
  hl("StorageClass", { fg = M.colors.base0A })
  hl("String", { fg = M.colors.base0B })
  hl("Structure", { fg = M.colors.base0E })
  hl("Tag", { fg = M.colors.base0A })
  hl("Todo", { fg = M.colors.base0A, bg = M.colors.base01 })
  hl("Type", { fg = M.colors.base0A, sp = nil })
  hl("Typedef", { fg = M.colors.base0A })

  if M.config.telescope then
    --Telescope
    hl("TelescopeBorder", { fg = M.colors.darker_black, bg = M.colors.darker_black })
    hl("TelescopePromptBorder", { fg = M.colors.black2, bg = M.colors.black2 })
    hl("TelescopePromptTitle", { fg = M.colors.black, bg = M.colors.red })
    hl("TelescopePromptNormal", { fg = M.colors.white, bg = M.colors.black2 })
    hl("TelescopePromptPrefix", { fg = M.colors.red, bg = M.colors.black2 })
    hl("TelescopeNormal", { bg = M.colors.base00 })
    hl("TelescopePreviewNormal", { fg = M.colors.darker_black })
    hl("TelescopePreviewTitle", { fg = M.colors.black2, bg = M.colors.green })
    hl("TelescopePreviewBorder", { fg = M.colors.darker_black, bg = M.colors.darker_black })
    hl("TelescopeResultsBorder", { fg = M.colors.white, bg = M.colors.base00 })
    hl("TelescopeResultsTitle", { fg = M.colors.black, bg = M.colors.yellow })
    hl("TelescopeResultsDiffAdd", { fg = M.colors.green })
    hl("TelescopeResultsDiffChange", { fg = M.colors.yellow })
    hl("TelescopeResultsDiffDelete", { fg = M.colors.red })
    hl("TelescopeSelection", { fg = M.colors.white, bg = M.colors.grey, bold = true })
  end

  --treesitter
  hl("@annotation", { fg = M.colors.base0F })
  hl("@attribute", { fg = M.colors.base0A })
  hl("@constructor", { fg = M.colors.base0C })
  hl("@constant.builtin", { fg = M.colors.base09 })
  hl("@constant.macro", { fg = M.colors.base08 })
  hl("@error", { fg = M.colors.base08 })
  hl("@exception", { fg = M.colors.base08 })
  hl("@float", { fg = M.colors.base09 })
  hl("@keyword", { fg = M.colors.base0E })
  hl("@keyword.function", { fg = M.colors.base0E })
  hl("@keyword.return", { fg = M.colors.base0E })
  hl("@function.builtin", { fg = M.colors.base0D })
  hl("@function.macro", { fg = M.colors.base08 })
  hl("@operator", { link = "@keyword.operator" })
  hl("@keyword.operator", { fg = M.colors.base0E })
  hl("@method", { fg = M.colors.base0D })
  hl("@namespace", { fg = M.colors.base08 })
  hl("@none", { fg = M.colors.base05 })
  hl("@parameter", { fg = M.colors.base08 })
  hl("@reference", { fg = M.colors.base05 })
  hl("@repeat", { link = "@keyword" })
  hl("@punctuation.bracket", { fg = M.colors.base0F })
  hl("@punctuation.delimiter", { fg = M.colors.base0F })
  hl("@punctuation.special", { fg = M.colors.base08 })
  hl("@string.regex", { fg = M.colors.base0C })
  hl("@string.escape", { fg = M.colors.base0C })
  hl("@symbol", { fg = M.colors.base0B })
  hl("@tag", { fg = M.colors.base0A })
  hl("@tag.attribute", { fg = M.colors.base0E })
  hl("@tag.delimiter", { fg = M.colors.base0F })
  hl("@text", { fg = M.colors.white })
  hl("@text.strong", { bold = true })
  hl("@text.attribute", { fg = M.colors.base0D })
  hl("@text.title", { fg = M.colors.base0D, bold = true })
  hl("@text.emphasis", { fg = M.colors.base09, italic = true })
  hl("@text.strike", { fg = M.colors.base00 })
  hl("@text.literal", { fg = M.colors.base09 })
  hl("@text.uri", { fg = M.colors.base0B, underline = true })
  hl("@type.builtin", { fg = M.colors.base0A })
  hl("@variable.builtin", { fg = M.colors.base09 })
  -- hl("@variable", { fg = M.colors.white })
  hl("@definition", { sp = M.colors.base04, underline = true })
  hl("TSDefinitionUsage", { sp = M.colors.base04, underline = true })
  hl("@scope", { bold = true })
  hl("@field", { fg = M.colors.base08 })
  hl("@field.key", { fg = M.colors.base0D })
  hl("@property", { fg = M.colors.base08 })
  hl("@include", { link = "Include" })
  hl("@conditional", { link = "Conditional" })
  hl("@spell", { fg = nil })
  hl("@variable", { fg = nil })
  -- Semantic
  hl("@lsp.type.class", { link = "Structure" })
  hl("@lsp.type.decorator", { link = "Function" })
  hl("@lsp.type.enum", { link = "Type" })
  hl("@lsp.type.enumMember", { link = "Constant" })
  hl("@lsp.type.function", { link = "@function" })
  hl("@lsp.type.interface", { link = "Structure" })
  hl("@lsp.type.macro", { link = "@macro" })
  hl("@lsp.type.method", { link = "@method" })
  hl("@lsp.type.namespace", { link = "@namespace" })
  hl("@lsp.type.parameter", { link = "@parameter" })
  hl("@lsp.type.property", { link = "@property" })
  hl("@lsp.type.struct", { link = "Structure" })
  hl("@lsp.type.type", { link = "@type" })
  hl("@lsp.type.typeParamater", { link = "TypeDef" })
  hl("@lsp.type.variable", { link = "@variable" })

  if M.config.alpha then
    --Alpha
    hl("AlphaHeader", { fg = M.colors.blue, bold = true })
    hl("AlphaButtons", { link = "rainbowcol1" })
    hl("AlphaFooter", { fg = M.colors.green, italic = true })
  end

  if M.config.gitsigns then
    --gitsigns
    hl("GitSignsAdd", { fg = M.colors.green })
    hl("GitSignsAddPreview", { fg = M.colors.black, bg = M.colors.green, bold = true })
    hl("GitSignsChange", { bg = M.colors.base00, fg = M.colors.yellow })
    hl("GitSignsDelete", { fg = M.colors.red })
    hl("GitSignsDeletePreview", { fg = M.colors.black, bg = M.colors.red, bold = true })
    hl("git_head", { fg = "red", bold = true })
    hl("git_sep", { bg = M.colors.red })
  end

  if M.config.navic then
    -- Winbar
    hl("NavicIconsFunction", { link = "@keyword.function" })
    hl("NavicIconsMethod", { link = "@method" })
    hl("NavicIconsConstructor", { link = "@method" })
    hl("NavicIconsClass", { link = "@constructor" })
    hl("NavicIconsString", { link = "String" })
    hl("NavicIconsArray", { link = "String" })
    hl("NavicIconsField", { link = "@field" })
    hl("NavicIconsPackage", { link = "@repeat" })
    hl("NavicIconsFile", { link = "CmpItemKindFile" })
    hl("NavicIconsProperty", { link = "@property" })
    hl("NavicIconsEnum", { link = "CmpItemKindEnum" })
    hl("NavicIconsEnumMember", { link = "CmpItemKindEnum" })
    hl("NavicIconsObject", { link = "@field" })
    hl("NavicIconsBoolean", { link = "Boolean" })
    hl("NavicIconsNumber", { link = "@number" })
    hl("NavicSeparator", { link = "linestatus" })
  end

  -- Neo-tree
  if M.config.neo_tree then
    hl("NeoTreeNormal", { bg = M.colors.darker_black })
    hl("NeoTreeDirectoryIcon", { fg = M.colors.folder_bg })
    hl("NeoTreeNormalNC", { link = "NeoTreeNormal" })
    hl("NeoTreeEndofBuffer", { link = "NeoTreeNormal" })
    hl("NeoTreeCursorLine", { bg = nil, bold = true })
  end

  -- BufferLine
  if M.config.bufferline then
    hl("BufferLineIndicatorSelected", { fg = M.colors.blue })
    hl("BufferLineTabSelected", { fg = M.colors.white, bold = true })
    hl("BufferLineTabSeparatorVisible", { link = "BufferLineIndicatorVisible" })
    hl("BufferLineTabSeparatorSelected", { link = "BufferLineIndicatorSelected" })
    hl("BufferLineCloseButton", { fg = M.colors.red, bg = "#1b1e2c" })
    hl("BufferLineCloseButtonSelected", { fg = M.colors.red, bg = M.colors.base00, bold = true })
  end
end

return M
