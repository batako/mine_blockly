-- Log accesses to driver stands and changes to switches

advtrains.log = function() end

if minetest.settings:get_bool("advtrains_enable_logging") then
	function advtrains.log (event, player, pos, data)
		minetest.log("action", "advtrains: " ..event.." by "..player.." at "..minetest.pos_to_string(pos).." -- "..(data or ""))
	end
end
