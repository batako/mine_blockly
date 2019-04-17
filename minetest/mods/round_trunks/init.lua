--[[
    Round Tree Trunks - Turns cubic tree trunks into cylindrical.
    Copyright (C) 2018  Hamlet
    Thanks to Astrobe for his tuning tips.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
--]]


--
-- Configuration
--

local round_trunks_leaves = minetest.settings:get_bool("round_trunks_leaves")

if (round_trunks_leaves == nil) then
	round_trunks_leaves = false
end


--
-- General variables
--

local minetest_log_level = minetest.settings:get("debug_log_level")
local mod_load_message = "[Mod] Round Trunks [v0.2.1] loaded."


--
-- Changes to be applied
--

local round_trunk = {
	drawtype = "mesh",
	mesh = "round_trunks_trunk.obj",
	paramtype = "light",
	paramtype2 = "facedir",
	selection_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4}
	},
	collision_box = {
		type = "fixed",
		fixed = {-0.4, -0.5, -0.4, 0.4, 0.5, 0.4}
	},
}

local alternative_leaves = {
	drawtype = "plantlike",
	visual_scale = 1.0
}

local textures_default_tree = {
	tiles = {
		"round_trunks_default_tree_top.png",
		"round_trunks_default_tree_top.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png",
		"default_tree.png"
	}
}

local textures_pine_tree = {
	tiles = {
		"round_trunks_pine_top.png",
		"round_trunks_pine_top.png",
		"default_pine_tree.png",
		"default_pine_tree.png",
		"default_pine_tree.png",
		"default_pine_tree.png"
	}
}

local textures_acacia_tree = {
	tiles = {
		"round_trunks_acacia_tree_top.png",
		"round_trunks_acacia_tree_top.png",
		"default_acacia_tree.png",
		"default_acacia_tree.png",
		"default_acacia_tree.png",
		"default_acacia_tree.png"
	}
}

local textures_aspen_tree = {
	tiles = {
		"round_trunks_aspen_tree_top.png",
		"round_trunks_aspen_tree_top.png",
		"default_aspen_tree.png",
		"default_aspen_tree.png",
		"default_aspen_tree.png",
		"default_aspen_tree.png"
	}
}


--
-- Nodes to be overriden
--

local tree_nodes = {
	"default:tree", "default:jungletree", "default:pine_tree",
	"default:acacia_tree", "default:aspen_tree"
}

local leaves = {
	"default:leaves", "default:jungleleaves", "default:pine_needles",
	"default:acacia_leaves", "default:aspen_leaves", "default:bush_leaves",
	"default:acacia_bush_leaves"
}


--
-- Nodes overriders
--

for n = 1, 5 do
	minetest.override_item(tree_nodes[n], round_trunk)
end

minetest.override_item("default:tree", textures_default_tree)
minetest.override_item("default:pine_tree", textures_pine_tree)
minetest.override_item("default:acacia_tree", textures_acacia_tree)
minetest.override_item("default:aspen_tree", textures_aspen_tree)


if (round_trunks_leaves == true) then
	for n = 1, 7 do
		minetest.override_item(leaves[n], alternative_leaves)
	end
end


--
-- Minetest engine debug logging
--

if (minetest_log_level == nil) or (minetest_log_level == "action") or
	(minetest_log_level == "info") or (minetest_log_level == "verbose") then

	minetest.log("action", mod_load_message)
end
