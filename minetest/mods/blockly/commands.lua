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
