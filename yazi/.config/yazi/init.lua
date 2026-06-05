-- Init for yazi-git plugin
require("git"):setup()

-- Show username@hostname in header
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)

-- Add uid:gid and mtime to status line
Status:children_add(function()
    local h = cx.active.current.hovered
    if not h or ya.target_family() ~= "unix" then
        return ""
    end

    local time = math.floor(h.cha.mtime or 0)
    if time == 0 then
        time = ""
    else
        time = os.date("%d.%m.%Y", time)
	end

    return ui.Line {
        ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
        ":",
        ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
        " ",
        ui.Span(time):fg("yellow"),
        " ",
    }
end, 500, Status.RIGHT)

Status:children_add(function()
	local sel = cx.active.selected
	if #sel == 0 then return ui.Line({}) end
	local f = io.open("/tmp/yazi-sel-size", "r")
	local label = f and f:read("*a") or string.format(" %d sel: … ", #sel)
	if f then f:close() end
	if label == "" then label = string.format(" %d sel: … ", #sel) end
	return ui.Line({ ui.Span(label):fg("yellow") })
end, 3000, Status.RIGHT)


Status:children_remove(5, Status.RIGHT)
Status:children_remove(6, Status.RIGHT)

