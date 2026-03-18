local LAYOUT_TILE = 0
local LAYOUT_SCROLLER = 1

local tag_layouts = {}

local function layout_for(count)
	if count <= 2 then
		return LAYOUT_TILE
	else
		return LAYOUT_SCROLLER
	end
end

local function has_fullscreen(state)
	for _, win in pairs(state.toplevels) do
		if win.fullscreen then
			return true
		end
	end
	return false
end

mplug.add_listener(function(event, state)
	if event.type ~= "OutputTag" and event.type ~= "ToplevelUpdated" and event.type ~= "ToplevelClosed" then
		return
	end

	if has_fullscreen(state) then
		return
	end

	local active = state.active_tags[1]
	if not active then
		return
	end

	local info = state.tags[active]
	if not info then
		return
	end

	local desired = layout_for(info.clients)

	if tag_layouts[active] == desired then
		return
	end

	tag_layouts[active] = desired
	mplug.dispatch("set_layout " .. desired)
end)
