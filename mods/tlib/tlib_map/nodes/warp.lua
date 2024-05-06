local planets = tlib_core.planets
local gui = flow.widgets
local warp_formspec = flow.make_gui(function(player, ctx)
    local vbox = {name = "vbox1", h = 6, w = 7, spacing = 0.5}
    for _, planet in pairs(planets) do
        table.insert(vbox, gui.ButtonExit{
            w = 4,
            h = 1.2,
            name = planet,
            label = string.format("TELEPORT TO: %s", planet),
            on_event = function(player, ctx)
                minetest.chat_send_player(player:get_player_name(), string.format(minetest.colorize("#47FF47", "TELEPORTING TO: %s"), planet))
            end,
        })
    end
    return gui.Vbox{
        gui.Label{label = "WARP TO:", align_h = "centre"},
        gui.ScrollableVBox(vbox),
    }
end)

minetest.register_node("tlib_map:warp_node", {
    description = "Warp Node",
    groups = {immortal = 1},
    tiles = {
        "warp_side.png",
        "warp_side.png",
        "warp_side.png",
        "warp_side.png",
        "warp_side.png",
        "warp_front.png",
    },
    paramtype2 = "facedir",
    sounds = default.node_sound_metal_defaults(),
    on_construct = function(pos)
        minetest.get_meta(pos):set_string("infotext", "Warp To Planet")
    end,
    on_rightclick = function (pos, node, clicker, itemstack, pointed_thing)
        warp_formspec:show(clicker:get_player_name())
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