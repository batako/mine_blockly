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
    lifetime             = def.stats.lifetime or 60,

    animation            = def.model.animation,
    collisionbox         = def.model.collisionbox,
    drawtype             = def.model.drawtype,
    mesh                 = def.model.mesh,
    rotation             = def.model.rotation,
    textures             = def.model.textures,

    sounds = def.sounds,

    settings   = nil,
    is_panched = false,
    statuses = {
      neutral    = nil,
      processing = 1,
      done       = 2,
    },

    is_reverse = function(self)
      return self.walk_velocity < 0
    end,

    next_action = function(self, condition)
      local action = ""

      if condition.step < #condition.actions then
        action = condition.actions[condition.step + 1].action
      end

      return action
    end,

    next_step = function(self, condition)
      if condition.actions[condition.step].action == "walk" and self.next_action(self, condition) ~= "walk" then
        self.set_animation(self, "stand")
        self.set_velocity(self, 0)
      end

      condition.actions[condition.step].stats = self.statuses["done"]
      condition.step = condition.step + 1
    end,

    collision_detection = function(self)
      local velocity = self.get_velocity(self)

      -- TODO: don't jump on slow-footed block (Dirt with Snow)
      if velocity < self.walk_velocity then
        self.jump(self)
        self.set_velocity(self, self.walk_velocity)
      end
    end,

    walk = function(self, condition)
      local pos = self.object:getpos()

      self.collision_detection(self)

      -- +dz
      if condition.actions[condition.step].angle == 0 then
        if pos.z >= condition.actions[condition.step].next_pos.z then
          self.object:setpos({
            x = pos.x,
            y = pos.y,
            z = condition.actions[condition.step].next_pos.z,
          })
          self.next_step(self, condition)
        end

      -- -dx
      elseif condition.actions[condition.step].angle == 90 then
        if pos.x <= condition.actions[condition.step].next_pos.x then
          self.object:setpos({
            x = condition.actions[condition.step].next_pos.x,
            y = pos.y,
            z = pos.z,
          })
          self.next_step(self, condition)
        end

      -- -dz
      elseif condition.actions[condition.step].angle == 180 then
        if pos.z <= condition.actions[condition.step].next_pos.z then
          self.object:setpos({
            x = pos.x,
            y = pos.y,
            z = condition.actions[condition.step].next_pos.z,
          })
          self.next_step(self, condition)
        end

      -- +dx
      elseif condition.actions[condition.step].angle == 270 then
        if pos.x >= condition.actions[condition.step].next_pos.x then
          self.object:setpos({
            x = condition.actions[condition.step].next_pos.x,
            y = pos.y,
            z = pos.z,
          })
          self.next_step(self, condition)
        end

      end
    end,

    wait = function(self, dtime, condition)
      condition.actions[condition.step].dtime = condition.actions[condition.step].dtime + dtime

      if condition.actions[condition.step].dtime > 1 then
        self.next_step(self, condition)
      end
    end,

    action = function(self, condition)
      if condition.actions[condition.step].action == "walk" then
        local ahead_pos = self.get_ahead_pos(self)

        condition.actions[condition.step].next_pos = {
          x = ahead_pos.x,
          y = ahead_pos.y,
          z = ahead_pos.z,
        }
        condition.actions[condition.step].angle = self.get_angle(self)

        self.set_velocity(self, self.walk_velocity)
        self.set_animation(self, "walk")

      elseif condition.actions[condition.step].action == "stand" then
        condition.actions[condition.step].dtime = 0

      else
        if condition.actions[condition.step].action == "left" then
          self.object:setyaw(self.object:getyaw() + (90/180*math.pi) )

        elseif condition.actions[condition.step].action == "right" then
          self.object:setyaw(self.object:getyaw() + (-90/180*math.pi) )

        elseif condition.actions[condition.step].action == "sound" then
          if condition.actions[condition.step].sound then
            minetest.sound_play(condition.actions[condition.step].sound, {object = self.object})
          end

        elseif condition.actions[condition.step].action == "place" then
          if condition.actions[condition.step].material then
            local pos = { x = nil, y = nil, z = nil}
            if condition.actions[condition.step].type == "here" then
              pos = self.object:getpos()
              self.object:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
            elseif condition.actions[condition.step].type == "ahead" then
              pos = self.get_ahead_pos(self)
            end
            minetest.add_node(pos, { name = condition.actions[condition.step].material })
          end

        end

        self.next_step(self, condition)
      end
    end,

    run_action = function(self, dtime, condition)
      if condition.step <= #condition.actions then
        if condition.actions[condition.step].stats == self.statuses["neutral"] then
          condition.actions[condition.step].stats = self.statuses["processing"]

          self.action(self, condition)

        elseif condition.actions[condition.step].stats == self.statuses["processing"] then
          if condition.actions[condition.step].action == "walk" then
            self.walk(self, condition)

          elseif condition.actions[condition.step].action == "stand" then
            self.wait(self, dtime, condition)

          end
        end

      else
        self.is_panched = false
        self.init_condition(self, condition)
      end
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

    get_angle = function(self)
      local angle = math.floor(
        (self.object:getyaw() * 180 / math.pi) + 0.5
      ) % 360

      if self.is_reverse(self) then
        angle = (angle + 180) % 360
      end

      return angle
    end,

    get_ahead_pos = function(self)
      local current_pos = self.object:getpos()
      local ahead_pos = {}
      local angle = self.get_angle(self)

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

    get_under_node = function(self)
      local pos = self.object:getpos()
      pos.y = pos.y - 1

      return minetest.get_node(pos)
    end,

    jump = function(self)
      self.object:setacceleration({x = 0, y = 5, z = 0})
    end,

    fall = function(self)
      self.object:setacceleration({x = 0, y = -10, z = 0})
    end,

    -- random_sound = function(self)
    --   if self.sounds and self.sounds.random and math.random(1, 100) <= 1 then
    --     minetest.sound_play(self.sounds.random, {object = self.object})
    --   end
    -- end,

    gravity = function(self)
      if self.get_under_node(self).name == "air" then
        self.fall(self)
      end
    end,

    when_spawned = function(self, dtime)
      if self.settings.when_spawned and self.settings.when_spawned.actions then
        self.run_action(self, dtime, self.settings.when_spawned)
      end
    end,

    when_punched = function(self, dtime)
      if self.settings.when_punched and self.settings.when_punched.actions then
        self.run_action(self, dtime, self.settings.when_punched)
      else
        self.is_panched = false
        self.init_condition(self, self.settings.when_spawned)
      end
    end,

    lifetime_countdown_clock = function(self, dtime)
      self.lifetime = self.lifetime - dtime
      if self.lifetime < 0 then self.object:remove() end
    end,

    on_rightclick = function(self, _)
      -- self.object:setyaw(self.object:getyaw() + (90/180*math.pi) )
      print("on_rightclick")
    end,

    init_condition = function(self, condition)
      condition.actions = condition.actions
      condition.step    = 1
      condition.stats   = self.statuses.neutral
    end,

    on_punch = function(self, _)
      self.is_panched = true

      if self.settings.when_punched then
        self.settings.when_punched.step = 1

        for index, value in pairs(self.settings.when_punched.actions) do
          self.settings.when_punched.actions[index].stats = self.statuses.neutral
        end
      end
    end,

    on_step = function(self, dtime)
      self.gravity(self)

      if self.is_panched then
        self.when_punched(self, dtime)
      else
        self.when_spawned(self, dtime)
      end

      self.lifetime_countdown_clock(self, dtime)
    end,

    on_activate = function(self, staticdata, dtime_s)
      self.settings = {}

      self.object:set_armor_groups({fleshy = self.armor})
      self.object:setacceleration({x = 0, y = -10, z = 0})
      self.object:setvelocity({x = 0, y = self.object:getvelocity().y, z = 0})

      if self.is_reverse(self) then
        self.object:setyaw(math.pi)
      else
        self.object:setyaw(0)
      end

      if staticdata then
        local settings = minetest.deserialize(staticdata)
        if settings then
          local has_actions = false

          if settings.when_spawned and #settings.when_spawned.actions > 0 then
            has_actions = true
            self.settings.when_spawned = {
              actions = settings.when_spawned.actions,
            }
            self.init_condition(self, self.settings.when_spawned)
          end

          if settings.when_punched and #settings.when_punched.actions > 0 then
            has_actions = true
            self.settings.when_punched = {
              actions = settings.when_punched.actions,
            }
            self.init_condition(self, self.settings.when_punched)
          end

          if not has_actions then self.object:remove() end

        else
          self.object:remove()
        end

      else
        self.object:remove()
      end
    end,

  })

end


blocklymobs:register_mob("blockly:mob_sheep", {
  stats = {
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
