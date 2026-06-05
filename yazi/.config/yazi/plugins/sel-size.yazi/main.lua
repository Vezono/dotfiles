--- @since 26.5.6

local TMPFILE = "/tmp/yazi-sel-size"

local get_urls = ya.sync(function(_)
	local sel = cx.active.selected
	if #sel == 0 then return nil end
	local t = {}
	for _, url in pairs(sel) do t[#t + 1] = tostring(url) end
	return t
end)

return {
	entry = function()
		while true do
			local urls = get_urls()
			if not urls then
				local f = io.open(TMPFILE, "w")
				if f then f:write("") f:close() end
				ya.sleep(0.5)
			else
				local total = 0
				for _, path in ipairs(urls) do
					local out = Command("du"):arg("-sb"):arg(path):output()
					if out and out.status.success then
						local n = out.stdout:match("^(%d+)")
						if n then total = total + tonumber(n) end
					end
				end
				local label = string.format(" %d sel: %s ", #urls, ya.readable_size(total))
				local f = io.open(TMPFILE, "w")
				if f then f:write(label) f:close() end
				ya.sleep(0.5)
			end
		end
	end,
}
