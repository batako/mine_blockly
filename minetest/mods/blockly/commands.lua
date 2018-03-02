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
