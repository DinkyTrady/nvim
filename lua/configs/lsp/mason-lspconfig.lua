local M = {}

function M.setup()
	local status, masonlsp = pcall(require, "mason-lspconfig")
	if not status then
		return
	end

	masonlsp.setup({
		ensure_installed = { "html", "cssls", "tsserver", "emmet_ls", "jsonls" },
		automatic_installation = false,
	})
end

return M
