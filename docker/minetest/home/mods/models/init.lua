-- Models mod for minetest
-- Allows players to choose their player model in-game
-- License: WTFPL
-- Based on the skins mod by Zeg9 (WTFPL)

models = {}
models.models = {}

dofile(minetest.get_modpath("models").."/list.lua")

models.file = minetest.get_worldpath() .. "/playermodels.txt"
models.load = function()
	local input = io.open(models.file, "r")
	local data = nil
	if input then
		data = input:read('*all')
	end
	if data and data ~= "" then
		lines = string.split(data,"\n")
		for _, line in ipairs(lines) do
			data = string.split(line, ' ', 2)
			models.models[data[1]] = data[2]
		end
		io.close(input)
	end
end
models.load()
print("[Models]: Loaded saved player model settings")

models.save = function()
	local output = io.open(models.file,'w')
	for name, skin in pairs(models.models) do
		if name and skin then
			output:write(name .. " " .. skin .. "\n")
		end
	end
	io.close(output)
end

models.update_player_skin = function(player)
	local name = player:get_player_name()
	local modelname = models.models[name]
	player:set_properties({
		visual = "mesh",
		mesh = models.list[modelname].mesh,
		textures = models.list[modelname].textures,
		visual_size = models.list[modelname].visual_size,
		collisionbox = models.list[modelname].collisionbox
	})
	models.save()
end

models.formspec = {}
models.formspec.main = function(name)
	page = models.pages[name]
	if page == nil then page = 0 end
	local formspec = "size[8,7.5]"
		.. "button[0,0;2,.5;main;Back]"
		.. "label[0,.5;]"
		.. "label[0,1.5;Choose a model below:]"
	formspec = formspec .. "image[3,.5;2,1;"..models.list[models.models[name]].textures[1].."]"
	local imodel = 0
	local isprite = 0
	local smodel = 0 -- Skip models, used for pages
	local ssprite = 0 -- Skip sprites, used for pages
	for modelname, modelprops in pairs(models.list) do
		if smodel < page*8 then smodel = smodel + 1 else
			if imodel < 8 then
				formspec = formspec .. "image_button["..(imodel)..",2;1,2;"..modelprops.preview..";models_set_"..modelname..";]"
			end
			imodel = imodel +1
		end
	end
	if page > 0 then
		formspec = formspec .. "button[0,7;1,.5;models_page_"..(page-1)..";<<]"
	end
	formspec = formspec .. "label[3,6.5;Page "..page.."]"
	if imodel > 8 or isprite > 8 then
		formspec = formspec .. "button[7,7;1,.5;models_page_"..(page+1)..";>>]"
	end
	return formspec
end

models.pages = {}

minetest.register_on_joinplayer(function(player)
	local p_name = player:get_player_name()
	models.models[player:get_player_name()] = "boy02"
	models.update_player_skin(player)
	inventory_plus.register_button(player,"models","Model")
end)

minetest.register_on_player_receive_fields(function(player,formname,fields)
	if fields.models then
		inventory_plus.set_inventory_formspec(player,models.formspec.main(player:get_player_name()))
	end
	for field, _ in pairs(fields) do
		if string.sub(field,0,string.len("models_set_")) == "models_set_" then
			models.models[player:get_player_name()] = string.sub(field,string.len("models_set_")+1)
			models.update_player_skin(player)
			inventory_plus.set_inventory_formspec(player,models.formspec.main(player:get_player_name()))
		end
		if string.sub(field,0,string.len("models_page_")) == "models_page_" then
			models.pages[player:get_player_name()] = tonumber(string.sub(field,string.len("models_page_")+1))
			inventory_plus.set_inventory_formspec(player,models.formspec.main(player:get_player_name()))
		end
	end
end)
