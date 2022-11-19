local M = {}

M.highlight = setmetatable({}, {
	__newindex = function(_, hlgroup, args)
		if "string" == type(args) then
			vim.cmd(("hi! link %s %s"):format(hlgroup, args))
			return
		end

		local guifg, guibg, gui, guisp = args.guifg or nil, args.guibg or nil, args.gui or nil, args.guisp or nil
		local cmd = { "hi", hlgroup }
		if guifg then
			table.insert(cmd, "guifg=" .. guifg)
		end
		if guibg then
			table.insert(cmd, "guibg=" .. guibg)
		end
		if gui then
			table.insert(cmd, "gui=" .. gui)
		end
		if guisp then
			table.insert(cmd, "guisp=" .. guisp)
		end
		vim.cmd(table.concat(cmd, " "))
	end,
})

function M.with_config(config)
	M.config = vim.tbl_extend("force", {
		telescope = true,
		indentblankline = true,
		notify = true,
		ts_rainbow = true,
		cmp = true,
		illuminate = true,
	}, config or M.config or {})
end

function M.setup(colors, config)
	M.with_config(config)

	if type(colors) == "string" then
		colors = M.colorschemes[colors]
	end

	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.cmd("set termguicolors")

	M.colors = colors or M.colorschemes[vim.env.BASE16_THEME] or M.colorschemes["schemer-dark"]
	local hi = M.highlight
	--blanklinee
	hi.IndentBlankLineChar = { guifg = M.colors.line }
	hi.IndentBlankLineSpaceChar = { guifg = M.colors.line }

	--auto completion
	hi.CmpItemAbbr = {
		guifg = M.colors.white,
	}
	hi.CmpItemAbbrDefault = "CmpItemAbbr"
	hi.CmpItemAbbrMatch = {
		guifg = M.colors.blue,
		gui = "bold",
	}
	hi.CmpBorder = { guifg = M.colors.grey }
	hi.CmpDocumentation = { guifg = M.colors.white, guibg = M.colors.grey }
	hi.CmpDocumentationBorder = "CmpBorder"
	hi.CmpItemMenuDefault = "CmpItemAbbr"
	hi.CmpItemKindConstant = {
		guifg = M.colors.base09,
	}
	hi.CmpItemKindFunction = {
		guifg = M.colors.base0D,
	}
	hi.CmpItenKindIdentifier = {
		guifg = M.colors.base08,
	}
	hi.CmpItemKindField = {
		guifg = M.colors.base08,
	}
	hi.CmpItemKindVariable = {
		guifg = M.colors.base0E,
	}
	hi.CmpItemKindSnippet = {
		guifg = M.colors.red,
	}
	hi.CmpItemKindText = {
		guifg = M.colors.base0B,
	}
	hi.CmpItemKindStructure = {
		guifg = M.colors.base0E,
	}
	hi.CmpItemKindType = {
		guifg = M.colors.base0A,
	}
	hi.CmpItemeKindKeyword = {
		guifg = M.colors.base07,
	}
	hi.CmpItemKindMethod = {
		guifg = M.colors.base0D,
	}
	hi.CmpItemKindConstrucor = {
		guifg = M.colors.blue,
	}
	hi.CmpItemKindFolder = { guifg = M.colors.base07 }
	hi.CmpItemKindModule = { guifg = M.colors.base0A }
	hi.CmpItemKindProperty = { guifg = M.colors.base08 }
	hi.CmpItemKindUnit = { guifg = M.colors.base0E }
	hi.CmpItemKindFile = { guifg = M.colors.base07 }
	hi.CmpItemKindColor = { guifg = M.colors.red }
	hi.CmpItemKindRefrence = { guifg = M.colors.base05 }
	hi.CmpItemKindStruct = { guifg = M.colors.base0E }
	hi.CmpItemKindOperator = { guifg = M.colors.base05 }
	hi.CmpItemKindTypeParameter = { guifg = M.colors.base08 }
	hi.CmpItemKindCopilot = { guifg = M.colors.green }
	--Default
	hi.Statusline = { guifg = M.colors.base00, guibg = M.colors.statusline_bg }
	hi.MatchWord = {
		guifg = nil,
		guibg = M.colors.grey,
	}
	hi.MatchParen = "MatchWord"
	hi.PMenu = { guibg = M.colors.one_bg }
	hi.PMenuSbar = { guibg = M.colors.one_bg }
	hi.PMenuSel = {
		guifg = M.colors.black,
		guibg = M.colors.pmenu_bg,
	}
	hi.PMenuThumb = { guibg = M.colors.grey }
	hi.Comment = { guifg = M.colors.grey_fg, gui = "italic" }
	hi.CursorLineNr = { guifg = M.colors.white }
	hi.LineNr = { guifg = M.colors.grey }
	hi.FloatBorder = { guifg = M.colors.blue }
	hi.NormalFloat = { guifg = M.colors.white }
	hi.NvimInternalError = { guifg = M.colors.red }
	hi.WinSeparator = { guifg = M.colors.line }
	hi.PackerPackageName = { guifg = M.colors.red }
	hi.PackerSucces = { guifg = M.colors.green }
	hi.PackerStatusSucces = { guifg = M.colors.base08 }
	hi.PackerStatusCommit = { guifg = M.colors.blue }
	hi.PackerProgress = { guifg = M.colors.blue }
	hi.PacketOutput = { guifg = M.colors.red }
	hi.PackerStatus = { guifg = M.colors.blue }
	hi.PackerHash = { guifg = M.colors.blue }
	hi.Normal = {
		guifg = M.colors.base05,
		guibg = M.colors.base00,
	}
	hi.EndofBuffer = { guifg = M.colors.base00 }
	hi.Debug = { guifg = M.colors.base08 }
	hi.Directory = { guifg = M.colors.base0D }
	hi.Error = {
		guifg = M.colors.black,
		guibg = M.colors.base08,
	}
	hi.ErrorMsg = {
		guifg = M.colors.base08,
		guibg = M.colors.base00,
	}
	hi.Exception = { guifg = M.colors.base08 }
	hi.FoldColumn = {
		guifg = M.colors.base0C,
		guibg = M.colors.base01,
	}
	hi.Folded = {
		guifg = M.colors.white,
		guibg = M.colors.base01,
	}
	hi.InSearch = {
		guifg = M.colors.base01,
		guibg = M.colors.base09,
	}
	hi.Macro = { guifg = M.colors.base08 }
	hi.ModeMsg = { guifg = M.colors.base0B }
	hi.MoreMsg = { guifg = M.colors.base0B }
	hi.Question = { guifg = M.colors.base0D }
	hi.Search = {
		guifg = M.colors.base01,
		guibg = M.colors.base0A,
	}
	hi.Subtitute = {
		guifg = M.colors.base01,
		guibg = M.colors.base0A,
	}
	hi.SpecialKey = { guifg = M.colors.base03 }
	hi.TooLong = { guifg = M.colors.base08 }
	hi.UnderLined = { guifg = M.colors.base0B }
	hi.Visual = { guibg = M.colors.base02 }
	hi.VisualNOS = { guifg = M.colors.base08 }
	hi.WarningMsg = { guifg = M.colors.base08 }
	hi.WildMenu = {
		guifg = M.colors.base08,
		guibg = M.colors.base0A,
	}
	hi.Title = { guifg = M.colors.base0D }
	hi.Cursor = {
		guifg = M.colors.base00,
		guibg = M.colors.base05,
	}
	hi.NonText = { guifg = M.colors.base03 }
	hi.SignColumn = { guibg = M.colors.base00 }
	hi.ColorColumn = { guibg = M.colors.base01 }
	hi.CursorColumn = { guibg = M.colors.base01 }
	hi.CursorLine = { guifg = nil, guibg = M.colors.one_bg, guisp = nil }
	hi.QuickFixLine = { guibg = M.colors.base01 }
	hi.healthSuccess = {
		guifg = M.colors.green,
		guibg = M.colors.black,
	}

	--Diff
	hi.DiffAdd = { guifg = M.colors.blue }
	hi.DiffAdded = { guifg = M.colors.green }
	hi.DiffChange = { guifg = M.colors.light_grey }
	hi.DiffChangeDelete = { guifg = M.colors.red }
	hi.DiffModified = { guifg = M.colors.orange }
	hi.DiffDelete = { guifg = M.colors.red }
	hi.DiffRemoved = { guifg = M.colors.red }

	-- git commits
	hi.gitcommitOverflow = { guifg = M.colors.base08 }
	hi.gitcommitSummary = { guifg = M.colors.base08 }
	hi.gitcommitComment = { guifg = M.colors.base03 }
	hi.gitcommitUntracked = { guifg = M.colors.base03 }
	hi.gitcommitDiscarded = { guifg = M.colors.base03 }
	hi.gitcommitSelected = { guifg = M.colors.base03 }
	hi.gitcommitHeader = { guifg = M.colors.base0E }
	hi.gitcommitSelectedType = { guifg = M.colors.base0D }
	hi.gitcommitUnmergedType = { guifg = M.colors.base0D }
	hi.gitcommitDiscardedType = { guifg = M.colors.base0D }
	hi.gitcommitBranch = { guifg = M.colors.base09 }
	hi.gitcommitUntrackedFile = { guifg = M.colors.base0A }
	hi.gitcommitUnmergedFile = { guifg = M.colors.base08 }
	hi.gitcommitDiscardedFile = { guifg = M.colors.base08 }
	hi.gitcommitSelectedFile = { guifg = M.colors.base0B }

	--Lsp
	hi.LspReferenceText = {
		guifg = M.colors.darker_black,
		guibg = M.colors.white,
	}
	hi.LspReferenceRead = {
		guifg = M.colors.darker_black,
		guibg = M.colors.white,
	}
	hi.LspReferenceWrite = {
		guifg = M.colors.darker_black,
		guibg = M.colors.white,
	}
	hi.DiagnosticHint = { guifg = M.colors.purple }
	hi.DiagnosticError = { guifg = M.colors.red }
	hi.DiagnosticWarn = { guifg = M.colors.yellow }
	hi.DiagnosticInformation = { guifg = M.colors.green }
	hi.LspSignatureActiveParameter = {
		guifg = M.colors.black,
		guibg = M.colors.green,
	}
	hi.RenamerTitle = { guifg = M.colors.black, guibg = M.colors.red }
	hi.RenamerBorder = { guifg = M.colors.red }

	--Madon
	hi.MasonHeader = { guibg = M.colors.red, guifg = M.colors.black }
	hi.MasonHighlight = { guifg = M.colors.blue }
	hi.MasonHighlightBlock = {
		guifg = M.colors.black,
		guibg = M.colors.green,
	}
	hi.MasonHighlightBlockBold = {
		guifg = M.colors.black,
		guibg = M.colors.green,
	}
	hi.MasonHeaderSecondary = {
		guifg = M.colors.black,
		guibg = M.colors.green,
	}
	hi.MasonMuted = { guifg = M.colors.light_grey }
	hi.MasonMutedBlock = {
		guifg = M.colors.light_grey,
		guibg = M.colors.one_bg,
	}

	--NvimTree
	hi.NvimTreeEmptyFolderName = { guifg = M.colors.folder_bg }
	hi.NvimTreeEndOfBuffer = { guifg = M.colors.darker_black }
	hi.NvimTreeFolderIcon = { guifg = M.colors.folder_bg }
	hi.NvimTreeFolderName = { guifg = M.colors.folder_bg }
	hi.NvimTreeGitDirty = { guifg = M.colors.base0D }
	hi.NvimTreeIndentMarker = { guifg = M.colors.grey_fg }
	hi.NvimTreeNormal = { guibg = M.colors.darker_black }
	hi.NvimTreeNormalNC = { guibg = M.colors.darker_black }
	hi.NvimTreeOpenedFolderName = { guifg = M.colors.folder_bg }
	hi.NvimTreeGitIgnored = { guifg = M.colors.light_grey }
	hi.NvimTreeWinSeparator = {
		guifg = M.colors.darker_black,
		guibg = M.colors.darker_black,
	}
	hi.NvimTreeWindowPicker = { guifg = M.colors.red, guibg = M.colors.black2 }
	hi.NvimTreeCursorLine = { guibg = M.colors.black2 }
	hi.NvimTreeGitNew = { guifg = M.colors.green }
	hi.NvimTreeGitDeleted = { guifg = M.colors.red }
	hi.NvimTreeSpecialFile = { guifg = M.colors.yellow }
	hi.NvimTreeRootFolder = { guifg = M.colors.base0E }

	--syntax
	hi.Boolean = { guifg = M.colors.base09 }
	hi.Character = { guifg = M.colors.base08 }
	hi.Conditional = { guifg = M.colors.base0E }
	hi.Constant = { guifg = M.colors.base08 }
	hi.Define = { guifg = M.colors.base0E }
	hi.Delimiter = { guifg = M.colors.base0F }
	hi.Float = { guifg = M.colors.base09 }
	hi.Function = { guifg = M.colors.base0D }
	hi.Identifier = { guifg = M.colors.base08 }
	hi.Include = { guifg = M.colors.base0D }
	hi.Keyword = { guifg = M.colors.base0E }
	hi.Label = { guifg = M.colors.base0A }
	hi.Number = { guifg = M.colors.base09 }
	hi.Operator = { guifg = M.colors.base05 }
	hi.PreProc = { guifg = M.colors.base0A }
	hi.Repeat = { guifg = M.colors.base0A }
	hi.Special = { guifg = M.colors.base0C }
	hi.SpecialChar = { guifg = M.colors.base0F }
	hi.Statement = { guifg = M.colors.base08 }
	hi.StorageClass = { guifg = M.colors.base0A }
	hi.String = { guifg = M.colors.base0B }
	hi.Structure = { guifg = M.colors.base0E }
	hi.Tag = { guifg = M.colors.base0A }
	hi.Todo = { guifg = M.colors.base0A, guibg = M.colors.base01 }
	hi.Type = { guifg = M.colors.base0A }
	hi.Typedef = { guifg = M.colors.base0A }

	--Telescope
	hi.TelescopeBorder = { guifg = M.colors.darker_black, guibg = M.colors.darker_black }
	hi.TelescopePromptBorder = { guifg = M.colors.black2, guibg = M.colors.black2 }
	hi.TelescopePromptNormal = { guifg = M.colors.white, guibg = M.colors.black2 }
	hi.TelescopePromptPrefix = { guifg = M.colors.red, guibg = M.colors.black2 }
	hi.TelescopeNormal = { guibg = M.colors.base00 }
	hi.TelescopePreviewNormal = { guibg = M.colors.darker_black }
	hi.TelescopePreviewTitle = { guifg = M.colors.black, guibg = M.colors.green }
	hi.TelescopePreviewBorder = { guifg = M.colors.darker_black, guibg = M.colors.darker_black }
	hi.TelescopePromptTitle = { guifg = M.colors.black, guibg = M.colors.red }
	hi.TelescopeResultsBorder = { guifg = M.colors.white, guibg = M.colors.base00 }
	hi.TelescopeResultsTitle = { guifg = M.colors.black, guibg = M.colors.yellow }
	hi.TelescopeSelection = { guibg = M.colors.grey, guifg = M.colors.white }
	hi.TelescopeResultsDiffAdd = { guifg = M.colors.green }
	hi.TelescopeResultsDiffChange = { guifg = M.colors.yellow }
	hi.TelescopeResultsDiffDelete = { guifg = M.colors.red }

	--treesitter
	hi["@annotation"] = { guifg = M.colors.base0F }
	hi["@attribute"] = { guifg = M.colors.base0A }
	hi["@constructor"] = { guifg = M.colors.base0C }
	hi["@constant.builtin"] = { guifg = M.colors.base09 }
	hi["@constant.macro"] = { guifg = M.colors.base08 }
	hi["@error"] = { guifg = M.colors.base08 }
	hi["@exception"] = { guifg = M.colors.base08 }
	hi["@float"] = { guifg = M.colors.base09 }
	hi["@keyword"] = { guifg = M.colors.base0E }
	hi["@keyword.function"] = { guifg = M.colors.base0E }
	hi["@keyword.return"] = { guifg = M.colors.base0E }
	hi["@function.builtin"] = { guifg = M.colors.base0D }
	hi["@function.macro"] = { guifg = M.colors.base08 }
	hi["@keyword.operator"] = { guifg = M.colors.base0E }
	hi["@method"] = { guifg = M.colors.base0D }
	hi["@namespace"] = { guifg = M.colors.base08 }
	hi["@none"] = { guifg = M.colors.base05 }
	hi["@parameter"] = { guifg = M.colors.base08 }
	hi["@reference"] = { guifg = M.colors.base05 }
	hi["@punctuation.bracket"] = { guifg = M.colors.base0F }
	hi["@punctuation.delimiter"] = { guifg = M.colors.base0F }
	hi["@punctuation.special"] = { guifg = M.colors.base08 }
	hi["@string.regex"] = { guifg = M.colors.base0C }
	hi["@string.escape"] = { guifg = M.colors.base0C }
	hi["@symbol"] = { guifg = M.colors.base0B }
	hi["@tag"] = { guifg = M.colors.base0A }
	hi["@tag.attribute"] = { guifg = M.colors.base08 }
	hi["@tag.delimiter"] = { guifg = M.colors.base0F }
	hi["@text"] = { guifg = M.colors.base05 }
	hi["@text.strong"] = { gui = "bold" }
	hi["@text.emphasis"] = { guifg = M.colors.base09, gui = "italic" }
	hi["@text.strike"] = { guifg = M.colors.base00 }
	hi["@text.literal"] = { guifg = M.colors.base09 }
	hi["@text.url"] = { guifg = M.colors.base09, gui = "underline" }
	hi["@type.builtin"] = { guifg = M.colors.base0A }
	hi["@variable.builtin"] = { guifg = M.colors.base09 }
	hi["@definition"] = { guisp = M.colors.base04, gui = "underline" }
	hi.TSDefinitionUsage = { guisp = M.colors.base04, gui = "underline" }
	hi["@scope"] = { gui = "bold" }
	hi["@field"] = { guifg = M.colors.base08 }
	-- hi["@field.key"] = { guifg = M.colors.base0D }
	hi["@property"] = { guifg = M.colors.base08 }
	hi["@include"] = { guifg = M.colors.base0D }
	hi["@conditional"] = { guifg = M.colors.base0E }

	--ts rainbow
	hi.rainbowcol1 = { guifg = M.colors.yellow }
	hi.rainbowcol2 = { guifg = M.colors.blue }
	hi.rainbowcol3 = { guifg = M.colors.green }
	hi.rainbowcol4 = { guifg = M.colors.base0D }
	hi.rainbowcol5 = { guifg = M.colors.pink }
	hi.rainbowcol6 = { guifg = M.colors.base0E }
	hi.rainbowcol7 = { guifg = M.colors.base0F }

	--Alpha
	hi.AlphaHeader = { guifg = M.colors.blue, gui = "bold" }
	hi.AlphaButtons = "rainbowcol1"
	hi.AlphaFooter = { guifg = M.colors.green, gui = "italic" }

	--gitsigns
	hi.GitSignsAdd = { guifg = M.colors.green }
	hi.GitSignsChange = { guibg = M.colors.base00, guifg = M.colors.yellow }
	hi.GitSignsDelete = { guifg = M.colors.red }
end

function M.available_colorschemes()
	return vim.tbl_keys(M.colorschemes)
end

M.colorschemes = {}
setmetatable(M.colorschemes, {
	__index = function(t, key)
		t[key] = require(string.format("colors.%s", key))
		return t[key]
	end,
})

return M
