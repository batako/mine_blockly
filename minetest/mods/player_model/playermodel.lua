--[[
Copyright (c) 2015, Robert 'Bobby' Zenz
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]


--- PlayerModel is a system that adds a player model complete with animations.
playermodel = {
	--- If the system should be automatically activated.
	activate_automatically = settings.get_bool("playermodel_activate", true),
	
	--- If the system is active/has been activated.
	active = false,
	
	--- The animation for when the player is digging. Defaults to 189/199.
	animation_digging = nil,
	
	--- The animation for when the player is laying on the ground. Defaults
	-- to 162/167.
	animation_laying = nil,
	
	--- The providers for the animations.
	animation_providers = List:new(),
	
	--- The animation for when the player is sitting. Defaults to 81/161.
	animation_sitting = nil,
	
	--- The animation for when the player is standing still. Defaults to 0/80.
	animation_standing = nil,
	
	--- The animation for when the player is walking. Defaults to 168/188.
	animation_walking = nil,
	
	--- The animation for when the player is walking and digging. Defaults
	-- to 200/220.
	animation_walking_digging = nil,
	
	--- The frame speed of the animations. Defaults to 30.
	frame_speed = settings.get_number("playermodel_frame_speed", 30),
	
	--- The frame speed of the animations when the player is sneaking.
	-- Defaults to 15.
	frame_speed_sneaking = settings.get_number("playermodel_frame_speed_sneaking", 15),
	
	--- The interval in which the animation is updated. Defaults to 0.066.
	interval = settings.get_number("playermodel_interval", 0.066),
	
	--- The name of the model that will be used. Defaults to "character.x".
	model = settings.get_string("playermodel_model_name", "boy.x"),
	
	--- A cache so that animations are not needlessly set.
	player_information = {},
	
	--- The texture of the model that is used. Defaults to "character.png".
	texture = { settings.get_string("playermodel_model_texture", "Boy02.png") },
	
	--- The size of the model. Defaults to 1/1.
	size = settings.get_pos2d("playermodel_model_size", { x = 1, y = 1 })
}


--- Activates the system, if it is not disabled by the configuration.
function playermodel.activate()
	if playermodel.activate_automatically then
		playermodel.activate_internal()
	end
end

--- Activates the system, without checking the configuration.
function playermodel.activate_internal()
	if not playermodel.active then
		playermodel.animation_providers:add(playermodel.default_animation_provider)
		
		scheduler.schedule(
			"playermodel",
			playermodel.interval,
			playermodel.perform_animation_updates,
			scheduler.OVERSHOOT_POLICY_RUN_ONCE)
		
		minetest.register_on_joinplayer(playermodel.activate_model_on_player)
		
		playermodel.active = true
	end
end

--- Activates the model on the given player.
--
-- @param player The Player object on which to activate the model.
function playermodel.activate_model_on_player(player)
	playermodel.set_player_model(player, playermodel.model, playermodel.texture, playermodel.size)
end

--- The default animation provider that is registered as first provider.
--
-- @param player The Player object for which to get the animation.
-- @return The animation and the frame speed.
function playermodel.default_animation_provider(player)
	local controls = player:get_player_control()
	
	local animation = nil
	
	if player:get_hp() == 0 then
		animation = playermodel.animation_laying
	elseif controls.up or controls.down or controls.left or controls.right then
		if controls.LMB then
			animation = playermodel.animation_walking_digging
		else
			animation = playermodel.animation_walking
		end
	elseif controls.LMB then
		animation = playermodel.animation_digging
	else
		animation = playermodel.animation_standing
	end
	
	local frame_speed = animation.speed
	
	if frame_speed == nil then
		frame_speed = playermodel.frame_speed
	end
	
	if controls.sneak then
		frame_speed = animation.sneak_speed
		
		if frame_speed == nil then
			frame_speed = playermodel.frame_speed_sneaking
		end
	end
	
	return animation, frame_speed
end

--- Determines the animation and frame speed for the current state of
-- the given player. Invokes all registered providers.
--
-- @param player The Player Object.
-- @return The animation and the frame speed.
function playermodel.determine_animation(player)
	local animation, frame_speed = nil
	
	playermodel.animation_providers:foreach(function(provider, index)
		local provided_animation, provided_frame_speed = provider(player)
		
		if provided_animation ~= nil then
			animation = provided_animation
		end
		if provided_frame_speed ~= nil then
			frame_speed = provided_frame_speed
		end
	end)
	
	return animation, frame_speed
end

--- Gets the specified animation from the configuration.
--
-- @param name The name of the animation.
-- @param default_x The default value for x.
-- @param default_y The default value for y.
-- @return The table of the animation, with x, y and speed values.
function playermodel.get_animation(name, default_x, default_y)
	return settings.get_table(
		"playermodel_animation_" .. name,
		{ x = default_x, y = default_y },
		"x", "y", "speed", "sneak_speed")
end

--- Initializes all necessary variables.
function playermodel.init()
	playermodel.animation_digging = playermodel.get_animation("digging", 189, 199)
	playermodel.animation_laying = playermodel.get_animation("laying", 162, 167)
	playermodel.animation_sitting = playermodel.get_animation("sitting", 81, 161)
	playermodel.animation_standing = playermodel.get_animation("standing", 0, 80)
	playermodel.animation_walking = playermodel.get_animation("walking", 168, 188)
	playermodel.animation_walking_digging = playermodel.get_animation("walking_digging", 200, 220)
end

--- Performs animation updates on all players.
function playermodel.perform_animation_updates()
	for index, player in ipairs(minetest.get_connected_players()) do
		playermodel.update_player_animation(player)
	end
end

--- Registers a provider for player animations.
--
-- Animation providers are invoked on every global step of Minetest by default,
-- that means it should be as lightweight as possible.
--
-- @param provider The provider. A function that accepts a Player object and
--                 returns the animation that should be used, or nil.
function playermodel:register_animation_provider(provider)
	playermodel.animation_providers:add(provider)
end

--- Sets the player information on the given player, but only if it has changed.
--
-- @param player The Player object on which to set the animation.
-- @param animation The animation.
-- @param frame_speed The frame speed.
function playermodel.set_player_animation(player, animation, frame_speed)
	local info = playermodel.player_information[player:get_player_name()]
	
	if info == nil then
		info = {
			current_animation = nil,
			current_frame_speed = nil
		}
		playermodel.player_information[player:get_player_name()] = info
	end
	
	if info.animation ~= animation or info.frame_speed ~= frame_speed then
		player:set_animation(
			animation,
			frame_speed,
			0,
			true)
		
		info.animation = animation
		info.frame_speed = frame_speed
	end
end

--- Sets the given model, textures and size on the player.
--
-- @param player The Player object on which to set the model.
-- @param model The name of the model/mesh to use. Can be nil to keep
--              the current value.
-- @param textures The textures to use. Can be nil to keep the current value.
-- @param size The size of the mode, a table with x and y values. Can be nil
--             to keep the current value.
function playermodel.set_player_model(player, model, textures, size)
	local properties = player:get_properties()
	
	properties.visual = "mesh"
	
	if model ~= nil then
		properties.mesh = model
	end
	if textures ~= nil then
		properties.textures = textures
	end
	if size ~= nil then
		properties.visual_size = size
	end
	
	player:set_properties(properties)
end

--- Updates the animation of the given player.
--
-- @param player The Player object which to update.
function playermodel.update_player_animation(player)
	local animation, frame_speed = playermodel.determine_animation(player)
	
	playermodel.set_player_animation(player, animation, frame_speed)
end

