local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
	return
end

local Rule_ok, Rule = pcall(require, "nvim-autopairs.rule")
if not Rule_ok then
	return
end

local ts_conds_ok, conds = pcall(require, "nvim-autopairs.ts-conds")
if not ts_conds_ok then
	return
end

local cond_ok, cond = pcall(require, "nvim-autopairs.conds")
if not cond_ok then
	return
end

local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" } }

npairs.add_rules {
	Rule("%", "%", "lua"):with_pair(conds.is_ts_node { "string", "comment" }),
	Rule("$", "$", "lua"):with_pair(conds.is_not_ts_node { "function" }),
	Rule(" ", " ")
		:with_pair(function(opts)
			local pair = opts.line:sub(opts.col - 1, opts.col)
			return vim.tbl_contains({
				brackets[1][1] .. brackets[1][2],
				brackets[2][1] .. brackets[2][2],
				brackets[3][1] .. brackets[3][2],
			}, pair)
		end)
		:with_move(cond.none())
		:with_cr(cond.none())
		:with_del(function(opts)
			local col = vim.api.nvim_win_get_cursor(0)[2]
			local context = opts.line:sub(col - 1, col + 2)
			return vim.tbl_contains({
				brackets[1][1] .. "  " .. brackets[1][2],
				brackets[2][1] .. "  " .. brackets[2][2],
				brackets[3][1] .. "  " .. brackets[3][2],
			}, context)
		end),
	Rule("%(.*%)%s*%=>$", " {  }", { "typescript", "typescriptreact", "javascript" })
		:use_regex(true)
		:set_end_pair_length(2),
}
for _, bracket in pairs(brackets) do
	Rule("", " " .. bracket[2])
		:with_pair(cond.none())
		:with_move(function(opts)
			return opts.char == bracket[2]
		end)
		:with_cr(cond.none())
		:with_del(cond.none())
		:use_key(bracket[2])
end
