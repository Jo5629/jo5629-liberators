armor:register_armor("tlib_armor:helmet_starter", {
	description = "Starter Helmet",
	inventory_image = "tlib_armor_inv_helmet_starter.png",
	armor_groups = {fleshy=10},
	groups = {armor_head=1, armor_heal=5, armor_use=0, armor_water=1, tlib_nodrop = 1},
})

armor:register_armor("tlib_armor:chestplate_starter", {
	description = "Starter Chestplate",
	inventory_image = "tlib_armor_inv_chestplate_starter.png",
	armor_groups = {fleshy=10},
	groups = {armor_torso=1, armor_heal=5, armor_use=0, armor_water=1, tlib_nodrop = 1},
})

armor:register_armor("tlib_armor:leggings_starter", {
	description = "Starter Leggings",
	inventory_image = "tlib_armor_inv_leggings_starter.png",
	armor_groups = {fleshy=10},
	groups = {armor_legs=1, armor_heal=5, armor_use=0, armor_water=1, tlib_nodrop = 1},
})

armor:register_armor("tlib_armor:boots_starter", {
	description = ("Starter Boots"),
	inventory_image = "tlib_armor_inv_boots_starter.png",
	armor_groups = {fleshy=10},
	groups = {armor_feet=1, armor_heal=5, armor_use=0, physics_speed=0.2, armor_water=1, tlib_nodrop = 1},
})