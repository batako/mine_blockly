minetest.register_entity("blockly:mob_sheep", {
  animation            = {},
  armor                = 200,
  collisionbox         = {-0.4, -0.01, -0.4, 0.4, 1, 0.4},
  drawtype             = "front",
  hp_max               = 3,
  jump                 = true,
  lava_damage          = 0,
  light_damage         = 0,
  makes_footstep_sound = true,
  mesh                 = "mob_sheep.x",
  physical             = true,
  sounds               = {
    random = "mob_sheep",
  },
  textures             = {"mob_sheep.png"},
  type                 = "animal",
  view_range           = 5,
  visual               = "mesh",
  walk_velocity        = 1,

  run                  = false,
  timer                = 0,
  actions              = {},
  next_action          = "",

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

    if not self.animation.current then
      self.animation.current = ""
    end

    if type == "stand" and self.animation.current ~= "stand" then
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
        self.animation.current = "stand"
      end

    elseif type == "walk" and self.animation.current ~= "walk"  then
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
        self.animation.current = "walk"
      end

    end
  end,

  get_ahead_node = function(self)
    local current_pos = self.object:getpos()
    local ahead_pos = {}
    local angle = math.floor(
      (self.object:getyaw() * 180 / math.pi) + 0.5
    ) % 360
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

    return minetest.get_node(ahead_pos)
  end,

  on_step = function(self, dtime)
    local ahead_node = self.get_ahead_node(self)

    if ahead_node.name == "air" then
      self.object:setacceleration({x = 0, y = -10, z = 0})
    elseif self.next_action == "walk" then
      self.object:setacceleration({x = 0, y = 10, z = 0})
    end

    if self.run then
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
              if self.sounds and self.sounds.random then
                minetest.sound_play(self.sounds.random, {object = self.object})
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
    end

    if not self.run and self.sounds and self.sounds.random and math.random(1, 100) <= 1 then
      minetest.sound_play(self.sounds.random, {object = self.object})
    end
  end,

  on_activate = function(self, staticdata, dtime_s)
    self.object:set_armor_groups({fleshy = self.armor})
    self.object:setacceleration({x = 0, y = -10, z = 0})
    self.object:setvelocity({x = 0, y = self.object:getvelocity().y, z = 0})
    self.object:setyaw(0)

    if staticdata then
      local tmp = minetest.deserialize(staticdata)
      if tmp and tmp.actions then
        self.actions = tmp.actions
        self.animation = {
          speed_normal = 15,
          stand_start  = 0,
          stand_end    = 80,
          walk_start   = 81,
          walk_end     = 100,
        }
      end
    end
  end,

})
