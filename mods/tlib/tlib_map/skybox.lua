local skybox = {
    'skybox_top.png',
    'skybox_bot.png',
    'skybox_left.png',
    'skybox_right.png',
    'skybox_front.png',
    'skybox_back.png'
 }

 minetest.register_on_joinplayer(function(player)
    player:set_sky({type = "skybox", textures = skybox, clouds = false})
    player:set_sun({visible = false, sunrise_visible = false})
    player:set_moon({visible = false})
end)