local on_key_releases,nr = {},0
function minetest.register_on_key_release(func)
	nr = nr+1
	on_key_releases[nr] = func
end
 
local on_key_presses,np = {},0
function minetest.register_on_key_press(func)
	np = np+1
	on_key_presses[np] = func
end
 
local playerkeys = {}
minetest.register_globalstep(function()
	for _,player in pairs(minetest.get_connected_players()) do
		local last_keys = playerkeys[player:get_player_name()]
		for key,stat in pairs(player:get_player_control()) do
			if stat then
				if not last_keys[key] then
					for i = 1,np do
						on_key_presses[i](player, key)
					end
					last_keys[key] = true
				end
			elseif last_keys[key] then
				for i = 1,nr do
					on_key_releases[i](player, key)
				end
				last_keys[key] = false
			end
		end
	end
end)
 
minetest.register_on_joinplayer(function(player)
	playerkeys[player:get_player_name()] = {}
end)

 
function fnc_go_programming(player, key)
    if key=="aux1" then

local formspec = "size[1,0.0]" .. "position[0.05,0.0]" .. "label[0,0;PAUSE]"
minetest.show_formspec(player:get_player_name(), "default:team_choose", formspec)

    end
end


minetest.register_on_key_release(function(player, key)
     fnc_go_programming(player, key)
end)

minetest.register_on_key_press(function(player, key)
end)

