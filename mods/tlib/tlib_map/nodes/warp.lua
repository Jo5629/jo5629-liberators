local gui = flow.widgets
local warp_formspec = flow.make_gui(function(player, ctx)
    local vbox = {name = "vbox1", h = 6, w = 7, spacing = 0.5}
    for _, planet in pairs(tlib_core.planets) do
        table.insert(vbox, gui.ButtonExit{
            w = 4,
            h = 1.2,
            name = planet,
            label = string.format("TELEPORT TO: %s", planet),
            on_event = function(player, ctx)
                local name = player:get_player_name()
                for _, callback in ipairs(tlib_core.registered_on_warp) do
                    if not callback(name, planet) then
                        minetest.chat_send_player(name, minetest.colorize("#FF0000", "Was unable to warp."))
                        return
                    end
                end
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

local hud = mhud.init()
tlib_core.register_on_warp(function(pname, planet)
    local player = minetest.get_player_by_name(pname)
    if not player then return end
    hud:add(player, "map_image", {
        hud_elem_type = "image",
        position = {x = 0.5, y = 0.5},
        image_scale = 200,
        z_index = 1000,
        texture = "loading_map_image.png",
    })

    hud:add(player, "loading_text", {
        hud_elem_type = "text",
        position = {x = 0.5, y = 0.5,},
        alignment = {x = "center", y = "up"},
        text_scale = 3,
        text = "TELEPORTING TO: " .. planet,
        color = 0x47FF47,
        z_index = 1001,
    })
    minetest.after(5, function()
        hud:remove_all()
    end)
end)