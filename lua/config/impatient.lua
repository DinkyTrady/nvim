local status, impatent = pcall(require, "impatent")
if not status then
	return
end

impatent.enable_profile()
