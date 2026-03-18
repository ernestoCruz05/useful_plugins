mplug.add_listener(function(event, state)
	if event.type ~= "UserCommand" then
		return
	end
	print("[carousel] got command:", event.name)

	local active_tag = state.active_tags[1]
	if not active_tag then
		return
	end
	local active = active_tag - 1
	print("[carousel] active tag (0-indexed):", active)
	print("[carousel] tag_count:", state.tag_count)

	local tag_count = state.tag_count or 9

	if event.name == "tag_right" then
		local next_tag = active + 1
		if next_tag >= tag_count then
			next_tag = 0
		end
		print("[carousel] switching to tag:", next_tag, "bitmask:", (1 << next_tag))
		mplug.exec("mmsg -s -t " .. (next_tag + 1))
	elseif event.name == "tag_left" then
		local prev_tag = active - 1
		if prev_tag < 0 then
			prev_tag = tag_count - 1
		end
		print("[carousel] switching to tag:", prev_tag, "bitmask:", (1 << prev_tag))
		mplug.exec("mmsg -s -t " .. (prev_tag + 1))
	end
end)
