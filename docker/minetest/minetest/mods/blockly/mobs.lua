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
    wool_nodes = {
      "wool:white",
      "wool:grey",
      "wool:dark_grey",
      "wool:black",
      "wool:blue",
      "wool:cyan",
      "wool:green",
      "wool:dark_green",
      "wool:yellow",
      "wool:orange",
      "wool:brown",
      "wool:red",
      "wool:pink",
      "wool:magenta",
      "wool:violet",
    },
    is_dirty_pos = nil,

    round = function(num)
      local correction_value = nil

      if num >= 0 then
        correction_value = 0.5
      else
        correction_value = 0.4
      end

      return math.floor(num + correction_value)
    end,

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

    next_step = function(self, condition)
      if condition.actions[condition.step].action == "walk" then
        local next_pos = condition.actions[condition.step].next_pos

        self.set_velocity(self, 0)
        self.object:setpos({
          x = next_pos.x,
          y = self.object:getpos().y,
          z = next_pos.z,
        })

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

        if self.get_node(self, "bottom").name == "air" then
          self.fall(self)
        else
          self.jump(self)
        end
      end
    end,

    get_distance = function(start_pos, end_pos)
      return math.sqrt(
        (end_pos.x - start_pos.x)^2 + (end_pos.z - start_pos.z)^2
      )
    end,

    walk = function(self, condition)
      local pos = self.object:getpos()
      local current_radian = self.object:getyaw()
      local migratory_distance = self.get_distance(
        condition.actions[condition.step].start_pos,
        self.object:getpos()
      )

      -- Intercepted
      if current_radian ~= condition.actions[condition.step].radian then
        self.is_dirty_pos = true
        condition.actions[condition.step].radian = current_radian
        condition.actions[condition.step].distance = condition.actions[condition.step].distance - migratory_distance

        self.set_next_pos(self, condition, condition.actions[condition.step].distance)
      end

      self.collision_detection(self)

      if migratory_distance >= condition.actions[condition.step].distance then
        self.next_step(self, condition)
      end
    end,

    wait = function(self, dtime, condition)
      local seconds = tonumber(condition.actions[condition.step].seconds) or 0

      if condition.actions[condition.step].type then
        if condition.actions[condition.step].type == "very_short" then
          seconds = 0.1
        elseif condition.actions[condition.step].type == "short" then
          seconds = 0.5
        elseif condition.actions[condition.step].type == "medium" then
          seconds = 1
        elseif condition.actions[condition.step].type == "long" then
          seconds = 2
        elseif condition.actions[condition.step].type == "very_long" then
          seconds = 3
        elseif condition.actions[condition.step].type == "random" then
          math.randomseed(os.time())

          seconds = math.random(0, 30)/10
        end
      end

      condition.actions[condition.step].dtime = condition.actions[condition.step].dtime + dtime

      if condition.actions[condition.step].dtime > seconds then
        self.next_step(self, condition)
      end
    end,

    turn = function(self, radian)
      self.object:setyaw(self.object:getyaw() + radian )
    end,

    turn_left = function(self)
      self.turn(self, math.pi/2)
    end,

    turn_right = function(self)
      self.turn(self, -math.pi/2)
    end,

    turn_random = function(self)
      local angules = {90, -90, 180}

      math.randomseed(os.time())

      self.turn(
        self,
        angules[math.random(#angules)]
      )
    end,

    run_turn_action = function(self, action)
      local velocity = self.get_velocity(self)

      if velocity == 0 then
        self[action](self)
      else
        self.set_velocity(self, 0)
        self[action](self)
        self.set_velocity(self, velocity)
      end
    end,

    set_next_pos = function(self, condition, distance)
      local next_pos = self.get_pos(self, "front", distance)

      if self.is_dirty_pos then
        condition.actions[condition.step].next_pos = next_pos
      else
        condition.actions[condition.step].next_pos = {
          x = self.round(next_pos.x),
          y = next_pos.y,
          z = self.round(next_pos.z),
        }
      end
    end,

    convert_material = function(self, material)
      if material == "wool:random" and self.wool_nodes then
        math.randomseed(os.time())

        return self.wool_nodes[math.random(#self.wool_nodes)]

      else
        return material
      end
    end,

    action = function(self, condition, dtime)
      if condition.actions[condition.step].action == "walk" then
        condition.actions[condition.step].radian = self.object:getyaw()
        condition.actions[condition.step].start_pos = self.object:getpos()
        condition.actions[condition.step].distance = 1

        self.set_next_pos(self, condition)
        self.set_velocity(self, self.walk_velocity)
        self.set_animation(self, "walk")

      elseif condition.actions[condition.step].action == "stand" then
        self.set_velocity(self, 0)
        self.set_animation(self, "stand")

        condition.actions[condition.step].dtime = 0

      elseif condition.actions[condition.step].action == "forever" then
        if not condition.actions[condition.step].name then
          condition.actions[condition.step].name = "forever"
        end

        self.run_action(self, dtime, condition.actions[condition.step])

      elseif condition.actions[condition.step].action == "detect_block" then
        if not condition.actions[condition.step].name then
          condition.actions[condition.step].name = "detect_block"
        end

        if not condition.actions[condition.step].ahead_node_name then
          condition.actions[condition.step].ahead_node_name = self.get_node(
            self,
            condition.actions[condition.step].direction
          ).name
        end

        local run = nil

        if condition.actions[condition.step].operator == "not" then
          run = (condition.actions[condition.step].block ~= condition.actions[condition.step].ahead_node_name)
        elseif condition.actions[condition.step].operator == "equal" then
          run = (condition.actions[condition.step].block == condition.actions[condition.step].ahead_node_name)
        end

        if run then
          self.run_action(self, dtime, condition.actions[condition.step])
        else
          self.next_step(self, condition)
        end

      else
        if condition.actions[condition.step].action == "turn_left" then
          self.run_turn_action(self, condition.actions[condition.step].action)

        elseif condition.actions[condition.step].action == "turn_right" then
          self.run_turn_action(self, condition.actions[condition.step].action)

        elseif condition.actions[condition.step].action == "turn_random" then
          self.run_turn_action(self, condition.actions[condition.step].action)

        elseif condition.actions[condition.step].action == "sound" then
          if condition.actions[condition.step].sound then
            minetest.sound_play(condition.actions[condition.step].sound, {object = self.object})
          end

        elseif condition.actions[condition.step].action == "place" then
          if condition.actions[condition.step].material then
            local pos = { x = nil, y = nil, z = nil}
            local material = self.convert_material(self, condition.actions[condition.step].material)

            if condition.actions[condition.step].type == "here" then
              pos = self.object:getpos()
              self.object:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
            elseif condition.actions[condition.step].type == "ahead" then
              pos = self.get_pos(self, "front")
            end

            minetest.add_node(pos, { name = material })
          end

        elseif condition.actions[condition.step].action == "disappear" then
          self.object:remove()

        elseif condition.actions[condition.step].action == "destroy_block" then
          local ahead_pos = self.get_pos(self, "front")
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

          elseif condition.actions[condition.step].action == "detect_block" then
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

    get_pos = function(self, type, distance)
      local current_pos = self.object:getpos()
      local radian = nil
      local destination_pos = {x = nil, y = nil, z = nil}
      local distance = distance or 1

      if type == "right" or type == "right_top" or type == "right_bottom" then
        radian = self.object:getyaw() - math.pi
      elseif type == "front_right" or type == "front_top_right" or type == "front_bottom_right" then
        radian = self.object:getyaw() - (math.pi*3)/4
      elseif type == "front" or type == "front_top" or type == "front_bottom" then
        radian = self.object:getyaw() - math.pi/2
      elseif type == "front_left" or type == "front_top_left" or type == "front_bottom_left" then
        radian = self.object:getyaw() - math.pi/4
      elseif type == "left" or type == "left_top" or type == "left_bottom" then
        radian = self.object:getyaw()
      elseif type == "back_left" or type == "back_top_left" or type == "back_bottom_left" then
        radian = self.object:getyaw() + math.pi/4
      elseif type == "back" or type == "back_top" or type == "back_bottom" then
        radian = self.object:getyaw() + math.pi/2
      elseif type == "back_right" or type == "back_top_right" or type == "back_bottom_right" then
        radian = self.object:getyaw() + math.pi/2
      end

      if radian then
        destination_pos.x = current_pos.x - (math.cos(radian) * distance)
        destination_pos.z = current_pos.z - (math.sin(radian) * distance)
      else
        destination_pos.x = current_pos.x
        destination_pos.z = current_pos.z
      end

      if string.match(type, "top") then
        destination_pos.y = current_pos.y + distance
      elseif string.match(type, "bottom") then
        destination_pos.y = current_pos.y - distance
      else
        destination_pos.y = current_pos.y
      end

      return destination_pos
    end,

    get_node = function(self, type)
      return minetest.get_node(
        self.get_pos(self, type)
      )
    end,

    jump = function(self)
      self.object:setacceleration({x = 0, y = 5, z = 0})
    end,

    fall = function(self)
      self.object:setacceleration({x = 0, y = -10, z = 0})
    end,

    gravity = function(self)
      if self.get_node(self, "bottom").name == "air" then
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

      -- for detect_block
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
