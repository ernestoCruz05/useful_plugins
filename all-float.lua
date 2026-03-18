local known = {}
local FLOAT_TAG = 4
math.randomseed(os.time())

mplug.add_listener(function(event, state)
	if event.type == "ToplevelUpdated" and not known[event.id] then
		known[event.id] = true
		for _, tag in ipairs(state.active_tags) do
			if tag == FLOAT_TAG then
				mplug.focus_window(event.id)
				mplug.exec("mmsg -d togglefloating")
				local out = state.outputs[1]
				if out then
					local w = math.random(math.floor(out.width_px * 0.6), math.floor(out.width_px * 0.7))
					local h = math.random(math.floor(out.height_px * 0.6), math.floor(out.height_px * 0.7))
					local x = math.random(0, out.width_px - w)
					local y = math.random(0, out.height_px - h)
					mplug.exec("mmsg -d resizewin," .. w .. "," .. h)
					mplug.exec("mmsg -d movewin," .. x .. "," .. y)
				end
			end
		end
	end
	if event.type == "ToplevelClosed" then
		known[event.id] = nil
	end
end)
