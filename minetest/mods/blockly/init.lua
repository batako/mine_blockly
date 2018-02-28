local mod_path = minetest.get_modpath("blockly")
local commands_path = mod_path .. "/../../blockly"

os.execute("mkdir -p " .. commands_path)

dofile(mod_path .. "/commands.lua")
dofile(mod_path .. "/mobs.lua")


function split(str, delim)
  local pattern = "[^"..delim.."]*"..delim
  local result = {}

  for item in string.gmatch(str, pattern) do
    local tmp = item:gsub(delim,"")
    table.insert(result, tmp)
  end

  return result
end


function exec_command(command)
  local handle = io.popen(command, "r")
  local content = handle:read("*all")

  handle:close()

  return content
end


function load_file(filepath)
  f = (io.open(filepath, "r"))

  if f ~= nil then
    f:close()

    for line in io.lines(filepath) do
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
          local admin = minetest.setting_get("name")
          if admin == nil or admin == '' then
            admin = "ADMIN"
          end
          minetest.chat_send_all(admin..": "..message)
        end
      end
    end

    os.remove(filepath)
  end
end


minetest.register_globalstep(
  function(dtime)
    local file_list_command = "ls -p " .. commands_path .. " | grep -v /"
    local result = exec_command(file_list_command)
    local files = split(result, "\n")

    for _, file in pairs(files) do
      load_file(commands_path .. "/" .. file)
    end
  end
)
