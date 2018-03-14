minetest.register_chatcommand("jump", {
  description = "Jump the player coordinates",
  func = function(name)
    local player = minetest.get_player_by_name(name)
    local pos = player:getpos()

    player:moveto({
      x = math.floor(pos.x),
      y = math.floor(pos.y) + 50,
      z = math.floor(pos.z)
    })
  end,
})

minetest.register_chatcommand("highjump", {
  description = "Jump the player coordinates",
  func = function(name)
    local player = minetest.get_player_by_name(name)
    local pos = player:getpos()

    player:moveto({
      x = math.floor(pos.x),
      y = math.floor(pos.y) + 120,
      z = math.floor(pos.z)
    })
  end,
})

dofile(minetest.get_modpath("user_help_commands").."/position/first.txt")
dofile(minetest.get_modpath("user_help_commands").."/position/second.txt")
dofile(minetest.get_modpath("user_help_commands").."/position/third.txt")
dofile(minetest.get_modpath("user_help_commands").."/position/fourth.txt")


dofile(minetest.get_modpath("user_help_commands").."/position/red.txt")
dofile(minetest.get_modpath("user_help_commands").."/position/blue.txt")
