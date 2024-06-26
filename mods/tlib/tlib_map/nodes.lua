local nodes_modpath = minetest.get_modpath(minetest.get_current_modname()) .. "/nodes"

dofile(nodes_modpath .. "/info.lua")
dofile(nodes_modpath .. "/warp.lua")
dofile(nodes_modpath .. "/galaxy_node.lua")

--> Most of the code from https://github.com/MT-CTF/capturetheflag/blob/master/mods/ctf/ctf_map/nodes.lua

minetest.register_tool("tlib_map:adminpick", {
	description = "Admin pickaxe used to break indestructible nodes.\nRightclick to remove non-indestructible nodes",
	inventory_image = "default_tool_diamondpick.png^default_obsidian_shard.png",
	range = 16,
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level = 3,
		groupcaps = {
			immortal = {times = {[1] = 0.2}, uses = 0, maxlevel = 3}
		},
		damage_groups = {fleshy = 10000}
	},
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing and pointed_thing.under then
			minetest.remove_node(pointed_thing.under)
		end
	end,
})

local mod_prefixes = {
	default = "";
	stairs = "";
	wool = "wool_";
	walls = "walls_";
}

-- See Lua API, section "Node-only groups"
local preserved_groups = {
	bouncy = true;
	fence = true;
	connect_to_raillike = true;
	wall = true;
	disable_jump = true;
	fall_damage_add_percent = true;
	slippery = true;
}

local function make_immortal(def)
	local groups = {immortal = 1}
	for group in pairs(preserved_groups) do
		groups[group] = def.groups[group]
	end
	def.groups = groups
	def.floodable = false
	def.description = def.description and ("Indestructible " .. def.description)
	def.on_blast = function() end
	def.on_destruct = function() end
	def.can_dig = function(pos, player)
		local item_name = player:get_wielded_item():get_name()
		if item_name == "tlib_map:adminpick" then
			return true
		end
		return false
	end

	return def
end

local queue = {}
for name, def in pairs(minetest.registered_nodes) do
	local mod, nodename = name:match"(..-):(.+)"
	local prefix = mod_prefixes[mod]
	if nodename and prefix and name ~= "default:torch" and
			not (def.groups and (def.groups.immortal or def.groups.not_in_creative_inventory)) then
		local new_name = "tlib_map:" .. prefix .. nodename -- HACK to preserve backwards compatibility
		local new_def = table.copy(def)
		if def.drop == name then
			new_def.drop = new_name
		end
		make_immortal(new_def)
		table.insert(queue, {name = new_name, def = new_def})
	end
end

for _, node in pairs(queue) do
	minetest.register_node(node.name, node.def)
end

minetest.register_alias("tlib_map:torch", "default:torch")
minetest.register_alias("tlib_map:torch_wall", "default:torch_wall")
minetest.register_alias("tlib_map:torch_ceiling", "default:torch_ceiling")