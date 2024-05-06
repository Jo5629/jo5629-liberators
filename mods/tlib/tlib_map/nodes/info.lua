local gui = flow.widgets
local info_text = {
    minetest.colorize("#01FFFF", "PRESIDENT'S MESSAGE"),
    "   Hello soldier! You are part of the Croxerth Army of Liberators, a prestigious group.",
    "We are in a battle for control over the Rithiea sector against the Merilians. If this",
    "sector falls, our home planet of Croxerth will be at stake of possible collapse. It",
    "comprises of three planets: Goiyama, Aruta, and Chonoe B12. Your goal along with",
    "your fellow Liberators are to take back the sector and defeat the Merilians through",
    "any means necessary.",
    "   If you need any help on mechanics, please continue reading below for any more info.",
    "Godspeed soldier. Your planet is counting on you.",
    "- President Gekko, Commander in Chief\n",
    minetest.colorize("#47FF47", "HELP"),
    "- To teleport to different planets, use the red node that says 'Warp to Planet' and",
    "then choose which planet you want to enter.",
    "- Multiple features are being developed by the Croxians and will be released as time",
    "goes on.\n",
    minetest.colorize("#FF0000", "UPDATES")
}
local info_formspec = flow.make_gui(function(player, ctx)
    local vbox = {name = "vbox1", h = 8, w = 12, spacing = 0.5}
    table.insert(vbox, gui.Label{label = table.concat(info_text, "\n")})
    return gui.Vbox{
        gui.Label{label = "INFORMATION PAGE", align_h = "centre"},
        gui.ScrollableVBox(vbox),
    }
end)

minetest.register_node("tlib_map:info_node", {
    description = "Info Node",
    groups = {immortal = 1},
    tiles = {
        "info_side.png",
        "info_side.png",
        "info_side.png",
        "info_side.png",
        "info_side.png",
        "info_front.png",
    },
    paramtype2 = "facedir",
    sounds = default.node_sound_metal_defaults(),
    on_construct = function(pos)
        minetest.get_meta(pos):set_string("infotext", "Information")
    end,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        info_formspec:show(clicker:get_player_name())
    end,
    on_blast = function() end,
    on_destruct = function() end,
    can_dig = function(pos, player)
		local item_name = player:get_wielded_item():get_name()
		if item_name == "tlib_map:adminpick" then
			return true
		end
		return false
	end,
})