tlib_player.starter_inventory = {
    "rangedweapons:m16", "rangedweapons:glock17",
    "rangedweapons:556mm 65535", "rangedweapons:10mm 65535",
    "tlib_armor:helmet_starter", "tlib_armor:chestplate_starter", "tlib_armor:leggings_starter", "tlib_armor:boots_starter",
}
minetest.register_on_newplayer(function(player)
    minetest.chat_send_player(player:get_player_name(), minetest.colorize("#00FF00", "Hello Liberator! Take a look around the ship for any help."))
    local inv = player:get_inventory()
    for _, item in pairs(tlib_player.starter_inventory) do
        inv:add_item("main", item)
    end
end)

local formspec = {
    "label[0.1,0.1;Hello World!]",
}

sfinv.register_page("tlib_player:home", {
    title = "Home",
    get = function(self, player, context)
        return sfinv.make_formspec(player, context, table.concat(formspec, ""), true)
    end,
})

sfinv.override_page("mtg_craftguide:craftguide", {
    is_in_nav = function(self, player, context)
        return tlib_core.server_mode == "mapedit" or minetest.is_creative_enabled(player:get_player_name())
    end
})

sfinv.override_page("sfinv:crafting", {
    is_in_nav = function(self, player, context)
        return tlib_core.server_mode == "mapedit" or minetest.is_creative_enabled(player:get_player_name())
    end
})