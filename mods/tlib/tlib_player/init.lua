local modpath = minetest.get_modpath(minetest.get_current_modname())
tlib_player = {
    default_skin = "liberator_skin.png",
}

dofile(modpath .. "/inventory.lua")

minetest.register_on_joinplayer(function(player)
    player:set_sun({visible = false, sunrise_visible = false})
    player:set_moon({visible = false})
    player:override_day_night_ratio(1)
    local attributes = player:get_nametag_attributes()
    attributes.color.a = 0
    player:set_nametag_attributes(attributes)

    --> Set the player's skin.
    player_api.set_texture(player, 1, tlib_player.default_skin)
    if minetest.get_modpath("3d_armor") and minetest.global_exists("armor") then
        local old_func = armor.get_player_skin
        armor.get_player_skin = function(self, name)
            local playerobj = minetest.get_player_by_name(name)
            if playerobj and player_api.get_textures(playerobj)[1] == tlib_player.default_skin then
                return tlib_player.default_skin
            else
                return old_func(self, name)
            end
        end
    end
    if tlib_core.server_mode == "play" then
        player:set_pos(tlib_core.default_spawn)
    end
    if not minetest.is_creative_enabled(player:get_player_name()) then
        sfinv.set_page(player, "tlib_player:home")
    end
end)