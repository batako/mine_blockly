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

    settings     = nil,
    process_type = nil,
    processes = {
      spawn      = nil,
      punch      = 1,
      rightclick = 2,
    },
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
      elseif condition.step >= #condition.actions and condition.name == "forever" then
        action = condition.actions[condition.step].action
      end

      return action
    end,

    fix_pos_after_walk = function(self, condition)
      local pos = self.object:getpos()

      -- +dz
      if condition.actions[condition.step].angle == 0 then
        self.object:setpos({
          x = pos.x,
          y = pos.y,
          z = condition.actions[condition.step].next_pos.z,
        })

      -- -dx
      elseif condition.actions[condition.step].angle == 90 then
        self.object:setpos({
          x = condition.actions[condition.step].next_pos.x,
          y = pos.y,
          z = pos.z,
        })

      -- -dz
      elseif condition.actions[condition.step].angle == 180 then
        self.object:setpos({
          x = pos.x,
          y = pos.y,
          z = condition.actions[condition.step].next_pos.z,
        })

      -- +dx
      elseif condition.actions[condition.step].angle == 270 then
        self.object:setpos({
          x = condition.actions[condition.step].next_pos.x,
          y = pos.y,
          z = pos.z,
        })

      end
    end,

    next_step = function(self, condition)
      if condition.actions[condition.step].action == "walk" then
        self.set_velocity(self, 0)
        self.fix_pos_after_walk(self, condition)

        if self.next_action(self, condition) ~= "walk" then
          self.set_animation(self, "stand")
        end
      end

      condition.actions[condition.step].stats = self.statuses["done"]
      condition.step = condition.step + 1
    end,

    is_slowdown = function(self)
      return self.get_velocity(self) < self.walk_velocity
    end,

    collision_detection = function(self)
      -- TODO: don't jump on slow-footed block (Dirt with Snow)
      if self.is_slowdown(self) then
        self.set_velocity(self, self.walk_velocity)

        if self.get_under_node(self).name == "air" then
          self.fall(self)
        else
          self.jump(self)
        end
      end
    end,

    walk = function(self, condition)
      local pos = self.object:getpos()
      local current_angle = self.get_angle(self)

      -- Intercepted
      if current_angle ~= condition.actions[condition.step].angle then
        condition.actions[condition.step].angle = current_angle
        -- FIXME: distance
        self.set_next_pos(self, condition)
      end

      self.collision_detection(self)

      -- +dz
      if condition.actions[condition.step].angle == 0 then
        if pos.z >= condition.actions[condition.step].next_pos.z then
          self.next_step(self, condition)
        end

      -- -dx
      elseif condition.actions[condition.step].angle == 90 then
        if pos.x <= condition.actions[condition.step].next_pos.x then
          self.next_step(self, condition)
        end

      -- -dz
      elseif condition.actions[condition.step].angle == 180 then
        if pos.z <= condition.actions[condition.step].next_pos.z then
          self.next_step(self, condition)
        end

      -- +dx
      elseif condition.actions[condition.step].angle == 270 then
        if pos.x >= condition.actions[condition.step].next_pos.x then
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

    turn = function(self, angle)
      self.object:setyaw(self.object:getyaw() + (angle/180*math.pi) )
    end,

    turn_left = function(self)
      self.turn(self, 90)
    end,

    turn_right = function(self)
      self.turn(self, -90)
    end,

    set_next_pos = function(self, condition)
      local ahead_pos = self.get_ahead_pos(self)

      condition.actions[condition.step].next_pos = {
        x = ahead_pos.x,
        y = ahead_pos.y,
        z = ahead_pos.z,
      }
    end,

    action = function(self, condition, dtime)
      if condition.actions[condition.step].action == "walk" then
        condition.actions[condition.step].angle = self.get_angle(self)

        self.set_next_pos(self, condition)
        self.set_velocity(self, self.walk_velocity)
        self.set_animation(self, "walk")

      elseif condition.actions[condition.step].action == "stand" then
        condition.actions[condition.step].dtime = 0

      elseif condition.actions[condition.step].action == "forever" then
        if not condition.actions[condition.step].name then
          condition.actions[condition.step].name = "forever"
        end

        self.run_action(self, dtime, condition.actions[condition.step])

      elseif condition.actions[condition.step].action == "if_ahead" then
        if not condition.actions[condition.step].name then
          condition.actions[condition.step].name = "if_ahead"
        end

        if not condition.actions[condition.step].ahead_node_name then
          condition.actions[condition.step].ahead_node_name = self.get_ahead_node(self).name
        end

        if condition.actions[condition.step].block == condition.actions[condition.step].ahead_node_name then
          self.run_action(self, dtime, condition.actions[condition.step])
        else
          self.next_step(self, condition)
        end

      else
        if condition.actions[condition.step].action == "left" then
          local velocity = self.get_velocity(self)

          if velocity == 0 then
            self.turn_left(self)
          else
            self.set_velocity(self, 0)
            self.turn_left(self)
            self.set_velocity(self, velocity)
          end

        elseif condition.actions[condition.step].action == "right" then
          local velocity = self.get_velocity(self)

          if velocity == 0 then
            self.turn_right(self)
          else
            self.set_velocity(self, 0)
            self.turn_right(self)
            self.set_velocity(self, velocity)
          end

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

        elseif condition.actions[condition.step].action == "disappear" then
          self.object:remove()

        elseif condition.actions[condition.step].action == "destroy_block" then
          local ahead_pos = self.get_ahead_pos(self)
          local ahead_node = minetest.get_node(ahead_pos)
          local current_pos = self.object:getpos()

          if ahead_node.name ~= "air" then
            minetest.swap_node(ahead_pos, { name = "air" })
            minetest.add_item(ahead_pos, ahead_node.name)
          end

        elseif condition.actions[condition.step].action == "drop" then
          minetest.add_item(
            self.object:getpos(),
            condition.actions[condition.step].item_name
          )
        end

        self.next_step(self, condition)
      end
    end,

    run_action = function(self, dtime, condition)
      if condition.step <= #condition.actions then
        if condition.actions[condition.step].stats == self.statuses["neutral"] then
          condition.actions[condition.step].stats = self.statuses["processing"]

          self.action(self, condition, dtime)

        elseif condition.actions[condition.step].stats == self.statuses["processing"] then
          if condition.actions[condition.step].action == "walk" then
            self.walk(self, condition)

          elseif condition.actions[condition.step].action == "stand" then
            self.wait(self, dtime, condition)

          elseif condition.actions[condition.step].action == "forever" then
            self.run_action(self, dtime, condition.actions[condition.step])

          elseif condition.actions[condition.step].action == "if_ahead" then
            if condition.actions[condition.step].step <= #condition.actions[condition.step].actions then
              self.run_action(self, dtime, condition.actions[condition.step])
            else
              self.next_step(self, condition)
            end
          end
        end

      elseif condition.name == "when_punched" or condition.name == "when_rightclicked" then
        self.process_type = nil

        if self.settings[condition.name].previous_velocity > 0 then
          self.set_velocity(self, self.settings[condition.name].previous_velocity)
          self.set_animation(self, "walk")
        end

      elseif condition.name == "forever" then
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

    get_ahead_node = function(self)
      local pos = self.get_ahead_pos(self)
      local ahead_node = minetest.get_node(pos)

      return ahead_node
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

    gravity = function(self)
      if self.get_under_node(self).name == "air" then
        self.fall(self)
      end
    end,

    when_spawned = function(self, dtime)
      if self.settings.when_spawned and self.settings.when_spawned.actions then
        self.settings.when_spawned.name = "when_spawned"
        self.run_action(self, dtime, self.settings.when_spawned)
      end
    end,

    when_punched = function(self, dtime)
      if self.settings.when_punched and self.settings.when_punched.actions then
        self.settings.when_punched.name = "when_punched"
        self.run_action(self, dtime, self.settings.when_punched)
      end
    end,

    when_rightclicked = function(self, dtime)
      if self.settings.when_rightclicked and self.settings.when_rightclicked.actions then
        self.settings.when_rightclicked.name = "when_rightclicked"
        self.run_action(self, dtime, self.settings.when_rightclicked)
      end
    end,

    lifetime_countdown_clock = function(self, dtime)
      self.lifetime = self.lifetime - dtime
      if self.lifetime < 0 then self.object:remove() end
    end,

    init_condition = function(self, condition)
      condition.step  = 1
      condition.stats = self.statuses.neutral

      -- for if_ahead
      condition.ahead_node_name = nil

      for index, _ in pairs(condition.actions) do
        condition.actions[index].stats = self.statuses.neutral

        if condition.actions[index].actions then
          self.init_condition(self, condition.actions[index])
        end
      end
    end,

    run_click_action = function(self, condition_name, process_type)
      if self.settings[condition_name] and self.settings[condition_name].actions then
        if self.process_type ~= process_type then
          if self.process_type == self.processes.spawn then
            self.settings[condition_name].previous_velocity = self.get_velocity(self)
          else
            self.settings[condition_name].previous_velocity = 0
          end

          self.process_type = process_type
        end

        self.set_animation(self, "stand")
        self.set_velocity(self, 0)
        self.init_condition(self, self.settings[condition_name])
      end
    end,

    on_punch = function(self, _)
      self.run_click_action(self, "when_punched", self.processes.punch)
    end,

    on_rightclick = function(self, _)
      self.run_click_action(self, "when_rightclicked", self.processes.rightclick)
    end,

    on_step = function(self, dtime)
      self.gravity(self)

      if self.process_type == self.processes.punch then
        self.when_punched(self, dtime)
      elseif self.process_type == self.processes.rightclick then
        self.when_rightclicked(self, dtime)
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

          if settings.when_rightclicked and #settings.when_rightclicked.actions > 0 then
            has_actions = true
            self.settings.when_rightclicked = {
              actions = settings.when_rightclicked.actions,
            }
            self.init_condition(self, self.settings.when_rightclicked)
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
