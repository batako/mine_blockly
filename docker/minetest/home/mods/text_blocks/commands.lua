minetest.register_chatcommand("createtextblock", {
  params = "materialtext x y z dx dy dz",
  description = "Text to block of <material> at (<x>, <y>, <z>) direction (<dx>, <dy>, <dz>",
  func = function(name, param)
    local found, _, materialitext, xx, yy, zz, dx, dy, dz = param:find("^(.*)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)$")

    if found == nil then
      return
    end

    xx = tonumber(xx)
    yy = tonumber(yy)
    zz = tonumber(zz)
    dx = tonumber(dx)
    dy = tonumber(dy)
    dz = tonumber(dz)

    local materialtextstring = materialitext
    local materialtextchar = ""

    while string.len(materialtextstring) >= 1 do
      materialtextchar = string.sub(materialtextstring, 1, 1)
      materialtextstring = string.sub(materialtextstring, 2)

      if(materialtextchar >= "0" and materialtextchar <= "9") or
        (materialtextchar >= "A" and materialtextchar <= "z") then
        minetest.add_node({ x = xx, y = yy, z = zz}, { name = "text_blocks:" .. materialtextchar })

      else
        minetest.add_node({ x = xx, y = yy, z = zz}, { name = "text_blocks:empty" })

      end

      xx = xx + dx
      yy = yy + dy
      zz = zz + dz
    end
  end,
})

minetest.register_chatcommand("deletetextblock", {
  params = "materialtext x y z dx dy dz",
  description = "Text to block of air at (<x>, <y>, <z>) direction (<dx>, <dy>, <dz>",
  func = function(name, param)
    local found, _, materialitext, xx, yy, zz, dx, dy, dz = param:find("^(.*)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)$")

    if found == nil then
      return
    end

    xx = tonumber(xx)
    yy = tonumber(yy)
    zz = tonumber(zz)

    dx = tonumber(dx)
    dy = tonumber(dy)
    dz = tonumber(dz)

    local materialtextstring = materialitext
    local materialtextchar = ""

    while string.len(materialtextstring)>=1 do
      materialtextchar = string.sub(materialtextstring, 1, 1)
      materialtextstring = string.sub(materialtextstring, 2)

      minetest.add_node({ x = xx, y = yy, z = zz}, { name = "air" })

      xx = xx + dx
      yy = yy + dy
      zz = zz + dz
    end
  end,
})
