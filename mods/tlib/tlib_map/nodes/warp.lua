minetest.register_node("tlib_map:warp_node", {
    description = "Warp Node",
    tiles = {
        "warp_side.png",
        "warp_side.png",
        "warp_side.png",
        "warp_side.png",
        "warp_side.png",
        "warp_front.png",
    },
    paramtype2 = "facedir",
    on_construct = function(pos)
        minetest.get_meta(pos):set_string("infotext", "Warp To Planet")
    end
})