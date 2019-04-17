minetest.register_chatcommand("createblock", {
  params = "material x y z",
  description = "Creates block of <material> at (<x>, <y>, <z>)",
  func = function(name, param)
    local found, _, material, xx, yy, zz = param:find("^(.*)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)$")

    if found == nil then
      return
    end

    xx = tonumber(xx)
    yy = tonumber(yy)
    zz = tonumber(zz)

    minetest.add_node({ x = xx, y = yy, z = zz}, { name = material })
  end,
})

minetest.register_chatcommand("placeonplayer", {
  params = "material playername x y z moveplayer",
  description = "Creates block <material> near <playername> at (<x>, <y>, <z>)",
  func = function(name, param)
		local found, _, material, playername, xx, yy, zz, moveplayer = param:find("^(.*)%s+(.*)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+(.*)$")

		if found == nil then
		  print("failed")
		  return
		end

		local player = minetest.get_player_by_name(playername)
		if not player then
		  print("player not found")
		  return
		else
		local pos = player:getpos()

		xc = tonumber(pos.x + xx)
		yc = tonumber(pos.y + yy + 0.5)
		zc = tonumber(pos.z + zz)

		print(yc)

		minetest.add_node({ x = xc, y = yc, z = zc}, { name = material })
		if moveplayer == "TRUE" then
		  minetest.after(0, function() player:set_pos({x=xc, y=yc+1, z=zc}) end)
		end
    end
  end,
})

minetest.register_chatcommand("createcube", {
params = "material playername x1 y1 z1 x2 y2 z2",
 description = "Fill block of <material> at (<x>, <y>, <z>)",

func = function (name, param)
    local found, _, material, playername, x1, y1, z1, x2, y2, z2 = param:find("^(.*)%s+(.*)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)$")
    if found == nil then
      print("failed")
      return
    end

    local player = minetest.get_player_by_name(playername)
    if not player then
      print("player not found")
      return
    else
      local block_id  = minetest.get_content_id(material)
      local pos = vector.round(player:getpos())
      if tonumber(x1) == 0 and tonumber(z1) == 0 then
        player:set_pos({x=pos.x, y=pos.y + y2 + 1, z=pos.z})
      end
      if tonumber(x2) ~= 0 then x2 = x2 - 1 end
      if tonumber(y2) ~= 0 then y2 = y2 - 1 end
      if tonumber(z2) ~= 0 then z2 = z2 - 1 end
      if tonumber(x2) > 15 then x2 = 14 end
      if tonumber(y2) > 30 then y2 = 29 end
      if tonumber(z2) > 15 then z2 = 14 end
      local pos1 = minetest.string_to_pos(pos.x..','..pos.y..','..pos.z)
      local pos2 = minetest.string_to_pos(pos.x + x2..','..pos.y + y2..','..pos.z + z2)
      local vm = minetest.get_voxel_manip()
      local emin, emax = vm:read_from_map(pos1, pos2)
      local a = VoxelArea:new{
          MinEdge = emin,
          MaxEdge = emax
      }    
      local data = vm:get_data()
      -- Modify data
        for z = pos1.z, pos2.z do
            for y = pos1.y, pos2.y do
                for x = pos1.x, pos2.x do
                    local vi = a:index(x, y, z)
                    data[vi] = block_id
                end
            end
        end
        vm:set_data(data)
        vm:write_to_map(true)
        for z = pos1.z+1, pos2.z-1 do
            for y = pos1.y+1, pos2.y-1 do
                for x = pos1.x+1, pos2.x-1 do
                    local vi = a:index(x, y, z)
                    data[vi] = minetest.get_content_id("air")
                end
            end
        end
        vm:set_data(data)
        vm:write_to_map(true)
      end 
end
})

minetest.register_chatcommand("spawnentity", {
  params = "x y z entity actions",
  description = "Adds <entity> to do <actions>  at (<x>, <y>, <z>)",
  func = function(name, param)
    local found, _, xx, yy, zz, entity, actions = param:find("^([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+(.+)%s+(.+)$")
    local staticdata = "return "..actions

    if found == nil then
      return
    end

    minetest.add_entity(
      {
        x = tonumber(xx),
        y = tonumber(yy),
        z = tonumber(zz)
      },
      entity,
      staticdata
    )
  end,
})

minetest.register_chatcommand("bring", {
  params = "player x y z",
  description = "Teleport player to (<x>, <y>, <z>)",
  func = function(name, param)
    local found, _, player_name, xx, yy, zz = param:find("^(.*)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)$")

    if found == nil then
      return
    end

    local player = minetest.get_player_by_name(player_name)
    if player then
      player:setpos({
        x = tonumber(xx),
        y = tonumber(yy),
        z = tonumber(zz)
      })
    end
  end,
})

minetest.register_chatcommand("bring_all", {
  params = "x y z",
  description = "Teleport connected players to near (<x>, <y>, <z>)",
  func = function(name, param)
    local found, _, xx, yy, zz = param:find("^([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)$")

    if found == nil then
      return
    end

    xx = tonumber(xx)
    yy = tonumber(yy)
    zz = tonumber(zz)

    math.randomseed(os.time())

    local range = 10
    local min_x = xx - range
    local max_x = xx + range
    local min_y = yy
    local max_y = yy + range
    local min_z = zz - range
    local max_z = zz + range

    for _,player in ipairs(minetest.get_connected_players()) do
      player:setpos({
        x = math.random(min_x, max_x),
        y = math.random(min_y, max_y),
        z = math.random(min_z, max_z)
      })
    end
  end,
})
