tlib_map.registered_maps = {}
tlib_map.map_index = 0

function tlib_map.register_map(name, def)
    tlib_map.registered_maps[name] = def
    tlib_map.map_index = tlib_map.map_index + 1
end

function tlib_map.place_map()
    local offset = vector.new(608 * tlib_map.map_index, 5000, 5000)
    local vm = minetest.get_voxel_manip()
    local pos1 = vector.subtract(offset, 200)
    local pos2 =vector.add(offset, 200)
    --minetest.delete_area(pos1, pos2)
    local emin, emax = vm:read_from_map(pos1, pos2)
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})
    local data = vm:get_data()

    local mid = {x = (emin.x + emax.x) / 2, y = (emin.y + emax.y) / 2, z = (emin.z + emax.z) / 2}

    local x_diff = (emax.x - emin.x) / 2
    local y_diff = (emax.y - emin.y) / 2
    local z_diff = (emax.z - emin.z) / 2

    local radius = math.min(x_diff, y_diff, z_diff, 10)

    -- Modify the radius of the asteroid using Perlin noise
    local perlin = minetest.get_perlin(0, 3, 0.5, 10)
    for x = -x_diff, x_diff do
        for y = -y_diff, y_diff do
            for z = -z_diff, z_diff do
                local dist = math.sqrt(x*x + y*y + z*z)
                local n = perlin:get_2d({x = x + mid.x, y = z + mid.z})
                if dist < radius + n * 3 then
                    data[area:index(x + mid.x, y + mid.y, z + mid.z)] = minetest.get_content_id("default:dirt")
                end
            end
        end
    end

    -- Add holes to the asteroid using Perlin noise
    local perlin2 = minetest.get_perlin(0, 3, 0.5, 10)
    for x = -x_diff, x_diff do
        for y = -y_diff, y_diff do
            for z = -z_diff, z_diff do
                local dist = math.sqrt(x*x + y*y + z*z)
                local n = perlin2:get_3d({x = x + mid.x, y = y + mid.y, z = z + mid.z})
                if dist > radius - 3 and dist < radius - 1 and n > 0.3 then
                    data[area:index(x + mid.x, y + mid.y, z + mid.z)] = minetest.get_content_id("air")
                end
            end
        end
    end

    -- Update the voxel manipulator and add the generated node to the world
    vm:set_data(data)
    vm:write_to_map()
    return offset
end

tlib_map.register_map("test1", {})

minetest.register_chatcommand("generate_asteroid", {
    description = "Generates a random asteroid at a position",
    privs = {server = true},
    func = function(name, param)
        local pos = tlib_map.place_map()
        minetest.chat_send_player(name, minetest.pos_to_string(pos, 2))
    end
})