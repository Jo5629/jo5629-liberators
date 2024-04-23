local modpath = minetest.get_modpath(minetest.get_current_modname())

tlib_core = {
    version = "0.0.1-alpha",
    server_mode = minetest.settings:get_bool("creative_mode", false) and "mapedit" or "play",
}

local function always_day()
    minetest.set_timeofday(0.5)
    minetest.after(60, function()
        always_day()
    end)
end
always_day()