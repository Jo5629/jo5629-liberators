--> https://github.com/minetest/minetest/blob/fe6da3a16bd2d284085d35e450f2896b460b252b/builtin/client/register.lua#L53.
local function make_registration()
    local t = {}
    local registerfunc = function(func)
        t[#t + 1] = func
    end
    return t, registerfunc
end

tlib_core.registered_on_warp, tlib_core.register_on_warp = make_registration()