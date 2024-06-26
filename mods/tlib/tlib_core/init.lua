local modpath = minetest.get_modpath(minetest.get_current_modname())

tlib_core = {
    server_mode = minetest.settings:get_bool("creative_mode", false) and "mapedit" or "play",
    planets = {"Aruta", "Chonoe B12", "Goiyama"},
    default_spawn = vector.new(0, 1, 0),
    worldpath = minetest.get_worldpath() .. "/tlib",
}
minetest.mkdir(tlib_core.worldpath)

dofile(modpath .. "/callbacks.lua")
dofile(modpath .. "/drops.lua")