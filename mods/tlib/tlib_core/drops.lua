local default_item_drop = minetest.item_drop
function minetest.item_drop(itemstack, dropper, ...)
    local name = itemstack:get_name()
    local itemdef = minetest.registered_items[name]
    if itemdef.groups.tlib_nodrop ~= nil then
        return itemstack
    end
    return default_item_drop(itemstack, dropper, ...)
end