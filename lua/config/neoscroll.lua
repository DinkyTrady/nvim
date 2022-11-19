local status, neoscroll = pcall(require, "neoscroll")
if not status then
	return
end

neoscroll.setup {
	mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb", "Up", "Down" },
}
