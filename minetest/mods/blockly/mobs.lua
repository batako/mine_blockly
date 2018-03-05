blocklymobs = {}
function blocklymobs:register_mob(name, def)
  minetest.register_entity(name, {
    armor                = def.stats.armor,
    hp_max               = def.stats.hp_max,
    makes_footstep_sound = def.stats.makes_footstep_sound,
    physical             = def.stats.physical,
    type                 = def.stats.type,
    visual               = def.stats.visual,
    walk_velocity        = def.stats.walk_velocity,

    animation            = def.model.animation,
    collisionbox         = def.model.collisionbox,
    drawtype             = def.model.drawtype,
    mesh                 = def.model.mesh,
    rotation             = def.model.rotation,
    textures             = def.model.textures,

    sounds = def.sounds,

    timer       = 0,
    run         = false,
    actions     = {},
    next_action = "",

    is_reverse = function(self)
      return self.walk_velocity < 0
    end,

    run_action = function(self, dtime)
      local step = math.floor(self.timer) + 1

      if step > 0 then
        if step <= #self.actions then
          if not self.actions[step].done then
            if self.actions[step].action == "walk" then
              self.set_velocity(self, self.walk_velocity)
              self.set_animation(self, "walk")

            elseif self.actions[step].action == "stand" then
              self.set_velocity(self, 0)
              self.set_animation(self, "stand")

            elseif self.actions[step].action == "left" then
              self.set_velocity(self, 0)
              self.set_animation(self, "stand")
              self.object:setyaw(self.object:getyaw() + (90/180*math.pi) )

            elseif self.actions[step].action == "right" then
              self.set_velocity(self, 0)
              self.set_animation(self, "stand")
              self.object:setyaw(self.object:getyaw() + (-90/180*math.pi) )

            elseif self.actions[step].action == "wait" then
              self.set_velocity(self, 0)
              self.set_animation(self, "stand")

            elseif self.actions[step].action == "sound" then
              self.set_velocity(self, 0)
              self.set_animation(self, "stand")
              if self.actions[step].sound then
                minetest.sound_play(self.actions[step].sound, {object = self.object})
              end

            elseif self.actions[step].action == "place" then
              self.set_velocity(self, 0)
              self.set_animation(self, "stand")
              if self.actions[step].material then
                local pos = { x = null, y = null, z = null}
                if self.actions[step].type == "here" then
                  pos = self.object:getpos()
                  self.object:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
                elseif self.actions[step].type == "ahead" then
                  pos = self.get_ahead_pos(self)
                end
                minetest.add_node(pos, { name = self.actions[step].material })
              end

            end

            self.actions[step].done = true
          end

          if step < #self.actions then
            self.next_action = self.actions[step + 1].action
          end

        else
          self.object:remove()
        end
      end

      self.timer = self.timer + dtime
    end,

    on_rightclick = function(self, clicker)
      if not self.run and clicker:get_inventory() then
        self.object:setyaw(self.object:getyaw() + (90/180*math.pi) )
      end
    end,

    on_punch = function(self, _)
      self.run = true
    end,

    set_velocity = function(self, v)
      local yaw = self.object:getyaw()

      self.object:setvelocity({
        x = math.sin(yaw) * -v,
        y = self.object:getvelocity().y,
        z = math.cos(yaw) * v
      })
    end,

    get_velocity = function(self)
      local v = self.object:getvelocity()
      return (v.x^2 + v.z^2)^(0.5)
    end,

    set_animation = function(self, type)
      if not self.animation then
        return
      end

      if type == "stand" then
        if
          self.animation.stand_start
          and self.animation.stand_end
          and self.animation.speed_normal
        then
          self.object:set_animation(
            {x = self.animation.stand_start, y = self.animation.stand_end},
            self.animation.speed_normal,
            0
          )
        end

      elseif type == "walk" then
        if
          self.animation.walk_start
          and self.animation.walk_end
          and self.animation.speed_normal
        then
          self.object:set_animation(
            {x = self.animation.walk_start, y = self.animation.walk_end},
            self.animation.speed_normal,
            0
          )
        end

      end
    end,

    get_ahead_pos = function(self)
      local current_pos = self.object:getpos()
      local ahead_pos = {}
      local angle = math.floor(
        (self.object:getyaw() * 180 / math.pi) + 0.5
      ) % 360

      if self.is_reverse(self) then
        angle = (angle + 180) % 360
      end

      if angle == 0 then
        ahead_pos = {
          x = current_pos.x,
          y = current_pos.y,
          z = current_pos.z + 1,
        }
      elseif angle == 90 then
        ahead_pos = {
          x = current_pos.x - 1,
          y = current_pos.y,
          z = current_pos.z,
        }
      elseif angle == 180 then
        ahead_pos = {
          x = current_pos.x,
          y = current_pos.y,
          z = current_pos.z - 1,
        }
      elseif angle == 270 then
        ahead_pos = {
          x = current_pos.x + 1,
          y = current_pos.y,
          z = current_pos.z,
        }
      end

      return ahead_pos
    end,

    get_ahead_node = function(self)
      return minetest.get_node(
        self.get_ahead_pos(self)
      )
    end,

    on_step = function(self, dtime)
      local ahead_node = self.get_ahead_node(self)

      if ahead_node.name == "air" then
        self.object:setacceleration({x = 0, y = -9, z = 0})
      elseif self.next_action == "walk" then
        self.object:setacceleration({x = 0, y = 11, z = 0})
      end

      if self.run then
        self.run_action(self, dtime)
      end

      if not self.run and self.sounds and self.sounds.random and math.random(1, 100) <= 1 then
        minetest.sound_play(self.sounds.random, {object = self.object})
      end
    end,

    on_activate = function(self, staticdata, dtime_s)
      self.object:set_armor_groups({fleshy = self.armor})
      self.object:setacceleration({x = 0, y = -10, z = 0})
      self.object:setvelocity({x = 0, y = self.object:getvelocity().y, z = 0})

      if self.is_reverse(self) then
        self.object:setyaw(math.pi)
      else
        self.object:setyaw(0)
      end

      if staticdata then
        local tmp = minetest.deserialize(staticdata)
        if tmp and tmp.actions then
          self.actions   = tmp.actions
        end
      end
    end,

  })

end


blocklymobs:register_mob("blockly:mob_sheep", {
  stats = {
    armor                = 200,
    hp_max               = 3,
    makes_footstep_sound = true,
    physical             = true,
    type                 = "animal",
    visual               = "mesh",
    walk_velocity        = 1,
  },
  model = {
    animation = {
      speed_normal = 15,
      stand_start  = 0,
      stand_end    = 80,
      walk_start   = 81,
      walk_end     = 100,
    },
    collisionbox = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
    drawtype     = "front",
    mesh         = "mob_sheep.x",
    textures     = {"mob_sheep.png"},
  },
  sounds = {random = "mob_sheep",},
})

blocklymobs:register_mob("blockly:mob_chicken", {
  stats = {
    armor                = 200,
    hp_max               = 3,
    makes_footstep_sound = true,
    physical             = true,
    type                 = "animal",
    visual               = "mesh",
    walk_velocity        = -1,
  },
  model = {
    animation = {
      speed_normal = 50,
      stand_start  = 0,
      stand_end    = 1,
      walk_start   = 4,
      walk_end     = 36,
    },
    collide_with_objects = false,
    collisionbox         = {-0.25, -0.01, -0.3, 0.25, 0.45, 0.3},
    drawtype             = "front",
    mesh                 = "mob_chicken.b3d",
    textures             = {"mob_chicken.png"},
  },
  sounds = {random = "mob_chicken",},
})
