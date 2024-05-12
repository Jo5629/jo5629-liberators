local gui = flow.widgets
local planets_info = {
    minetest.colorize("#1478F2", "CROXERTH:"),
    "- Our beautiful home.",
    "- Advanced technology is being developed there.",
    "- Home to the Croxerth Army of Liberators.",
    minetest.colorize("#B97A56", "\nGOIYAMA:"),
    "- DIFFICULTY = 1",
    "- Full of iron-rich soil.",
    "- Mostly desert.",
    minetest.colorize("#C3C3C3", "\nCHONOE B12:"),
    "- DIFFICULTY = 2",
    "- Rock-hard planet full of valuable materials deep in \nits core.",
    "- Very mountainous terrain.",
    minetest.colorize("#00A8F3", "\nARUTA:"),
    "- DIFFICULTY = 3",
    "- Cold and desolate planet.",
    "- Home of the Merilians.",
    "- Heavily defended.",
    minetest.colorize("#FF0000", "\nPLANETS CONTROLLED BY THE MERILIANS AS OF \nMAY 6, 2124:"),
    "- GOIYAMA\n- CHONOE B12\n- ARUTA"
}
local galaxy_formspec = flow.make_gui(function(player, ctx)
    local vbox = {name = "vbox1", w = 7, h = 9, spacing = 0.2}
    table.insert(vbox, gui.Label{label = table.concat(planets_info, "\n")})
    return gui.Hbox{
        gui.Image{w = 16, h = 9, texture_name = "galaxy_map.png", padding = 0,align_h = "left"},
        gui.ScrollableVBox(vbox)
    }
end)

minetest.register_node("tlib_map:galaxy_node", {
    description = "Galaxy Map Node",
    groups = {immortal = 1},
    tiles = {
        "galaxy_node_side.png",
        "galaxy_node_side.png",
        "galaxy_node_side.png",
        "galaxy_node_side.png",
        "galaxy_node_side.png",
        "galaxy_node_front.png",
    },
    paramtype2 = "facedir",
    sounds = default.node_sound_metal_defaults(),
    on_construct = function(pos)
        minetest.get_meta(pos):set_string("infotext", "The Liberators' Galaxy Map")
    end,
    on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
        galaxy_formspec:show(clicker:get_player_name())
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