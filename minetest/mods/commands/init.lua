local admin = minetest.setting_get("name")

if admin == nil or admin == '' then
  admin = "ADMIN"
end

minetest.register_globalstep(
  function(dtime)
    f = (io.open("/dev/shm/minetest-message", "r"))

    if f ~= nil then
      f:close()

      for line in io.lines('/dev/shm/minetest-message') do
        local message = line

        if message ~= nil then
          local player = minetest.get_player_by_name("singleplayer")
          local cmd, param = string.match(message, "^/([^ ]+) *(.*)")

          if not param then
            param = ""
          end

          local cmd_def = minetest.chatcommands[cmd]

          if cmd_def then
            cmd_def.func("singleplayer", param)
          else
            minetest.chat_send_all(admin..": "..message)
          end
        end
      end

      os.remove("/dev/shm/minetest-message")
    end
  end
)

minetest.register_chatcommand("createblock", {
  params = "material x y z",
  description = "Creates block of <material> at (<x>, <y>, <z>)",
  func = function(name, param)
    local found, _, material, xx, yy, zz = param:find("^(.*)%s+([+-]?%d+)%s+([+-]?%d+)%s+([+-]?%d+)$")

    if found == nil then
      return
    end

    xx=tonumber(xx)
    yy=tonumber(yy)
    zz=tonumber(zz)

    minetest.add_node({ x = xx, y = yy, z = zz}, { name = material })
  end,
})
