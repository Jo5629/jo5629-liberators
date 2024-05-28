local skybox = {
    "skybox_up.png",
    "skybox_down.png",
    "skybox_front.png",
    "skybox_back.png",
    "skybox_left.png",
    "skybox_right.png",
 }

 minetest.register_on_joinplayer(function(player)
    player:set_sky({type = "skybox", textures = skybox, clouds = false})
    player:set_sun({visible = false, sunrise_visible = false})
    player:set_moon({visible = false})
    player:override_day_night_ratio(1)
end)