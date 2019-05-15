local idx
function init_hud_displays(player)
	idx = player:hud_add({
	     hud_elem_type = "image",
	     position      = {x = 0.214, y = 0.82},
	     offset        = {x = 0,   y = 0},
	     text          = "",
	     alignment     = {x = 0, y = 0},  -- center aligned
	     scale         = {x = 0.3, y = 0.3}, -- covered later
	})
end
function update_hud_displays(player)
	local dir = player:get_look_horizontal()
	local deg = math.floor(math.deg(dir))
	local angel = ""
	if deg <= 315 and deg >= 225 then
		angel = "plusx.png"
	elseif deg <= 224 and deg >= 135 then
		angel = "minusz.png"
	elseif deg <= 134 and deg >= 45 then
		angel = "minusx.png"
	elseif deg <= 44 and deg >= 0 then
		angel = "plusz.png"
	elseif deg >= 315 then
		angel = "plusz.png"
	end
	player:hud_change(
		idx,
		"text",
		angel
	)
end
minetest.register_on_joinplayer(init_hud_displays)

local updatetimer = 0
minetest.register_globalstep(function(dtime)
  updatetimer = updatetimer + dtime
  if updatetimer > 0.1 then
    local players = minetest.get_connected_players()
    for i=1, #players do
      update_hud_displays(players[i])
    end
    updatetimer = updatetimer - dtime
  end
end)
