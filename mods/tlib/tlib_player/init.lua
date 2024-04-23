tlib_player = {
    default_skin = "liberator_skin.png",
    default_spawn = {x = 0, y = 1, z = 0}
}

minetest.register_on_joinplayer(function(player)
    local attributes = player:get_nametag_attributes()
    attributes.color.a = 0
    player:set_nametag_attributes(attributes)
    player_api.set_texture(player, 1, tlib_player.default_skin)
    player:set_pos(tlib_player.default_spawn)
end)