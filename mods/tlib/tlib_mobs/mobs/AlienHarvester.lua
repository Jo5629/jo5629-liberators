local function AlienHarvester_brain(self)
	mobkit.vitals(self)

	if self.hp <= 0 then
		mobkit.clear_queue_high(self)
		mobkit.hq_die(self)
		return
	end

	if mobkit.timer(self, 1) then
		local prty = mobkit.get_queue_priority(self)
        mobkit.hq_roam(self, 0)
	end
end

minetest.register_entity("tlib_mobs:AlienHarvester", {
	physical = true,
    stepheight = 0.1,
    collide_with_objects = true,
    collisionbox = {-1.5, -0.19, -1.5, 1.5, 6.25, 1.5},
    visual = "mesh",
    mesh = "AlienHarvester.b3d",
    textures = {"AlienHarvester.png"},
    visual_size = {x = 75, y = 75},
    static_save = true,
    makes_footstep_sound = true,
    on_step = mobkit.stepfunc,
    on_activate = mobkit.actfunc,
    get_staticdata = mobkit.statfunc,

	springiness = 0,
	buoyancy = 0.75,
	max_speed = 1,
	jump_height = 1.26,
	view_range = 24,
	lung_capacity = 10,
	max_hp = 300,
	timeout = 600,
	attack = {range = 2, damage_groups = {fleshy = 6}},
    animation = {
        stand = {range = {x = 1, y = 25}, speed = 30, frame_blend = 0.3, loop = true},
        walk = {range = {x = 30, y = 138}, speed = 30, frame_blend = 0.3, loop = true},
    },

    brainfunc = AlienHarvester_brain,

	on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		if mobkit.is_alive(self) then
			local hvel = vector.multiply(vector.normalize({x=dir.x,y=0,z=dir.z}),4)
			self.object:set_velocity({x=hvel.x,y=2,z=hvel.z})
			mobkit.hurt(self,tool_capabilities.damage_groups.fleshy or 1)

			if type(puncher)=='userdata' and puncher:is_player() then
				mobkit.clear_queue_high(self)
				mobkit.hq_hunt(self, 10, puncher)
			end
		end
	end,
})