tlib_player = {
    default_skin = "liberator_skin.png",
}

minetest.register_on_joinplayer(function(player)
    local attributes = player:get_nametag_attributes()
    attributes.color.a = 0
    player:set_nametag_attributes(attributes)
    player_api.set_texture(player, 1, tlib_player.default_skin)
    if tlib_core.server_mode == "play" then
        player:set_pos(tlib_core.default_spawn)
    end
end)