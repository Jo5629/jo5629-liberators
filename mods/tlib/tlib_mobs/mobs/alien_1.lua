local function herbivore_brain(self)
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

minetest.register_entity("tlib_mobs:Alien_1", {
    physical = true,
    stepheight = 0.1,
    collide_with_objects = true,
    collisionbox = {-0.35, -0.19, -0.35, 0.35, 0.65, 0.35},
    visual = "mesh",
    mesh = "alien_1.b3d",
    textures = {"alien_1.png"},
    visual_size = {x = 15, y = 15},
    static_save = true,
    makes_footstep_sound = true,
    on_step = mobkit.stepfunc,
    on_activate = mobkit.actfunc,
    get_staticdata = mobkit.statfunc,

	springiness=0,
	buoyancy = 0.9,
	max_speed = 5,
	jump_height = 1.26,
	view_range = 24,
	lung_capacity = 10,			-- seconds
	max_hp = 10,
	timeout = 600,
	attack={range=0.5,damage_groups={fleshy=3}},
    animation = {
        stand = {range = {x = 30, y = 54}, speed = 20, frame_blend = 0.3, loop = true},
        walk = {range = {x = 1, y = 25}, speed = 30, frame_blend = 0.3, loop = true},
    },

    brainfunc = herbivore_brain,

	on_punch=function(self, puncher, time_from_last_punch, tool_capabilities, dir)
		local hvel = vector.multiply(vector.normalize({x=dir.x,y=0,z=dir.z}),4)
		self.object:set_velocity({x=hvel.x,y=2,z=hvel.z})
		mobkit.make_sound(self,'hurt')
		mobkit.hurt(self,tool_capabilities.damage_groups.fleshy or 1)
	end,
})