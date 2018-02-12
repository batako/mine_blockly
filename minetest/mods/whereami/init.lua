local S
if (minetest.get_modpath("intllib")) then
  S = intllib.Getter()
else
  S = function(s,a,...)a={a,...}return s:gsub("@(%d+)",function(n)return a[tonumber(n)]end)end
end

local whereami = {}
whereami.playerhuds = {}
whereami.settings = {}
whereami.settings.hud_pos = { x = 0.5, y = 0 }
whereami.settings.hud_offset = { x = 0, y = 15 }
whereami.settings.hud_alignment = { x = 0, y = 0 }

local set = tonumber(minetest.setting_get("whereami_hud_pos_x"))
if set then whereami.settings.hud_pos.x = set end
set = tonumber(minetest.setting_get("whereami_hud_pos_y"))
if set then whereami.settings.hud_pos.y = set end
set = tonumber(minetest.setting_get("whereami_hud_offset_x"))
if set then whereami.settings.hud_offset.x = set end
set = tonumber(minetest.setting_get("whereami_hud_offset_y"))
if set then whereami.settings.hud_offset.y = set end
set = minetest.setting_get("whereami_hud_alignment")
if set == "left" then
  whereami.settings.hud_alignment.x = 1
elseif set == "center" then
  whereami.settings.hud_alignment.x = 0
elseif set == "right" then
  whereami.settings.hud_alignment.x = -1
end


function whereami.init_hud(player)
  local name = player:get_player_name()

  whereami.playerhuds[name] = player:hud_add({
    hud_elem_type = "text",
    text = "",
    position = whereami.settings.hud_pos,
    offset = { x = whereami.settings.hud_offset.x, y = whereami.settings.hud_offset.y },
    alignment = whereami.settings.hud_alignment,
    number = 0xFFFFFF,
    scale= { x = 100, y = 20 },
  })
end

function whereami.update_hud_displays(player)
  local name = player:get_player_name()
  local pos = vector.round(player:getpos())

  player:hud_change(
    whereami.playerhuds[name],
    "text",
    S("Coordinates: X=@1, Y=@2, Z=@3", pos.x, pos.y, pos.z)
  )
end

minetest.register_on_newplayer(whereami.init_hud)
minetest.register_on_joinplayer(whereami.init_hud)

minetest.register_on_leaveplayer(function(player)
  whereami.playerhuds[player:get_player_name()] = nil
end)


local updatetimer = 0
minetest.register_globalstep(function(dtime)
  updatetimer = updatetimer + dtime
  if updatetimer > 0.1 then
    local players = minetest.get_connected_players()
    for i=1, #players do
      whereami.update_hud_displays(players[i])
    end
    updatetimer = updatetimer - dtime
  end
end)
