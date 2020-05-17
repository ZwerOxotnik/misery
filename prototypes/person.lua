--person.lua

require ("__base__/prototypes/entity/demo-player-animations")
require ("__base__/prototypes/entity/demo-gunshot-sounds")

data:extend(
{
  {
    --PROTOTYPE
    type = "unit",
    name = "NoArmorPistol",
    --PROTOTYPE OPT
    order="a",
    
    --ENTITY
    icon = "__base__/graphics/icons/player.png",
    icon_size = 32,
    --ENTITY OPT
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -1.4}, {0.4, 0.2}},
    sticker_box = {{-0.2, -1}, {0.2, 0}},
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    subgroup = "creatures",
    
    --ENTITY-WITH-HEALTH OPT
    max_health = 250,
    healing_per_tick = 0.15,
    dying_explosion = "blood-explosion-small",
    corpse = "character-corpse",
    resistances =
    {
      {
        type = "physical",
        decrease = 4,
        percent = 10
      },
      {
        type = "explosion",
        percent = 10
      },
      {
        type = "acid",
        percent = 100
      }
    },
    
    --UNIT
    run_animation =
    {
      layers=
      {
        playeranimations.level1.running_gun,
        playeranimations.level1.running_gun_mask,
        playeranimations.level1.running_gun_shadow
      }
    },
    
    idle_animation =
    {
      layers=
      {
        playeranimations.level1.idle_gun,
        playeranimations.level1.idle_gun_mask,
        playeranimations.level1.idle_gun_shadow
      }
    },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 15,
      movement_slow_down_factor = 0.2,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = 15,
      sound = make_light_gunshot_sounds(),
      ammo_type =
      {
        category = "bullet",
        action_delivery =
        {
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            },
            target_effects =
            {
              {
                type = "create-entity",
                entity_name = "explosion-hit"
              },
              {
                type = "damage",
                damage = { amount = 5 , type = "physical"}
              }
            }
          }
        }
      },
      animation =
      {
        layers=
        {
          playeranimations.level1.idle_gun,
          playeranimations.level1.idle_gun_mask,
          playeranimations.level1.idle_gun_shadow
        }
      }
    },
    movement_speed = 0.1,
    distance_per_frame = 0.188,
    pollution_to_join_attack = 1000,
    distraction_cooldown = 300,
    vision_distance = 30,
    --UNIT OPT
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
  },
  
  {
    --PROTOTYPE
    type = "unit",
    name = "LightArmorPistol",
    --PROTOTYPE OPT
    order="a",
    
    --ENTITY
    icon = "__base__/graphics/icons/player.png",
    icon_size = 32,
    --ENTITY OPT
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -1.4}, {0.4, 0.2}},
    sticker_box = {{-0.2, -1}, {0.2, 0}},
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    subgroup = "creatures",
    
    --ENTITY-WITH-HEALTH OPT
    max_health = 250,
    healing_per_tick = 0.15,
    dying_explosion = "blood-explosion-small",
    corpse = "character-corpse",
    resistances =
    {
      {
        type = "physical",
        decrease = 4,
        percent = 10
      },
      {
        type = "explosion",
        percent = 10
      },
      {
        type = "acid",
        percent = 100
      }
    },
    
    --UNIT
    run_animation =
    {
      layers=
      {
        playeranimations.level1.running_gun,
        playeranimations.level1.running_gun_mask,
        playeranimations.level2addon.running_gun,
        playeranimations.level2addon.running_gun_mask,
        playeranimations.level1.running_gun_shadow
      }
    },
    idle_animation =
    {
      layers=
      {
        playeranimations.level1.idle_gun,
        playeranimations.level1.idle_gun_mask,
        playeranimations.level2addon.idle_gun,
        playeranimations.level2addon.idle_gun_mask,
        playeranimations.level1.idle_gun_shadow
      }
    },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 15,
      movement_slow_down_factor = 0.2,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = 15,
      sound = make_light_gunshot_sounds(),
      ammo_type =
      {
        category = "bullet",
        action =
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-explosion",
                  entity_name = "explosion-gunshot"
                }
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-hit"
                },
                {
                  type = "damage",
                  damage = { amount = 5 , type = "physical"}
                }
              }
            }
          }
        }
      },
      animation =
      {
        layers=
        {
          playeranimations.level1.idle_gun,
          playeranimations.level1.idle_gun_mask,
          playeranimations.level2addon.idle_gun,
          playeranimations.level2addon.idle_gun_mask,
          playeranimations.level1.idle_gun_shadow
        }
      },
    },
    movement_speed = 0.1,
    distance_per_frame = 0.188,
    pollution_to_join_attack = 1000,
    distraction_cooldown = 300,
    vision_distance = 30,
    --UNIT OPT
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
  },
  
  {
    --PROTOTYPE
    type = "unit",
    name = "HeavyArmorPistol",
    --PROTOTYPE OPT
    order="a",
    
    --ENTITY
    icon = "__base__/graphics/icons/player.png",
    icon_size = 32,
    --ENTITY OPT
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -1.4}, {0.4, 0.2}},
    sticker_box = {{-0.2, -1}, {0.2, 0}},
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    subgroup = "creatures",
    
    --ENTITY-WITH-HEALTH OPT
    max_health = 250,
    healing_per_tick = 0.15,
    dying_explosion = "blood-explosion-small",
    corpse = "character-corpse",
    resistances =
    {
      {
        type = "physical",
        decrease = 4,
        percent = 10
      },
      {
        type = "explosion",
        percent = 10
      },
      {
        type = "acid",
        percent = 100
      }
    },
    
    --UNIT
    run_animation =
    {
      layers=
      {
        playeranimations.level1.running_gun,
        playeranimations.level1.running_gun_mask,
        playeranimations.level3addon.running_gun,
        playeranimations.level3addon.running_gun_mask,
        playeranimations.level1.running_gun_shadow
      }
    },
    idle_animation =
    {
      layers=
      {
        playeranimations.level1.idle_gun,
        playeranimations.level1.idle_gun_mask,
        playeranimations.level3addon.idle_gun,
        playeranimations.level3addon.idle_gun_mask,
        playeranimations.level1.idle_gun_shadow
      }
    },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 15,
      movement_slow_down_factor = 0.2,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = 15,
      sound = make_light_gunshot_sounds(),
      ammo_type =
      {
        category = "bullet",
        action =
        {
          type = "direct",
          action_delivery =
          {
            {
              type = "instant",
              source_effects =
              {
                {
                  type = "create-explosion",
                  entity_name = "explosion-gunshot"
                }
              },
              target_effects =
              {
                {
                  type = "create-entity",
                  entity_name = "explosion-hit"
                },
                {
                  type = "damage",
                  damage = { amount = 5 , type = "physical"}
                }
              }
            }
          }
        }
      },
      animation =
      {
        layers=
        {
          playeranimations.level1.idle_gun,
          playeranimations.level1.idle_gun_mask,
          playeranimations.level3addon.idle_gun,
          playeranimations.level3addon.idle_gun_mask,
          playeranimations.level1.idle_gun_shadow
        }
      },
    },
    movement_speed = 0.1,
    distance_per_frame = 0.188,
    pollution_to_join_attack = 1000,
    distraction_cooldown = 300,
    vision_distance = 30,
    --UNIT OPT
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
  },
  
  {
    --PROTOTYPE
    type = "unit",
    name = "NoArmorIdle",
    --PROTOTYPE OPT
    order="a",
    
    --ENTITY
    icon = "__base__/graphics/icons/player.png",
    icon_size = 32,
    --ENTITY OPT
    collision_box = {{-0.2, -0.2}, {0.2, 0.2}},
    selection_box = {{-0.4, -1.4}, {0.4, 0.2}},
    sticker_box = {{-0.2, -1}, {0.2, 0}},
    flags = {"placeable-player", "placeable-enemy", "placeable-off-grid", "breaths-air", "not-repairable"},
    subgroup = "creatures",
    
    --ENTITY-WITH-HEALTH OPT
    max_health = 250,
    healing_per_tick = 0.15,
    dying_explosion = "blood-explosion-small",
    corpse = "character-corpse",
    resistances =
    {
      {
        type = "physical",
        decrease = 4,
        percent = 10
      },
      {
        type = "explosion",
        percent = 10
      },
      {
        type = "acid",
        percent = 100
      }
    },
    
    --UNIT
    run_animation =
    {
      layers=
      {
        playeranimations.level1.idle,
        playeranimations.level1.idle_mask,
        playeranimations.level1.idle_shadow
      }
    },
    
    animation =
    {
      layers=
      {
        playeranimations.level1.idle_gun,
        playeranimations.level1.idle_gun_mask,
        playeranimations.level1.idle_gun_shadow
      }
    },
    
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "bullet",
      cooldown = 15,
      movement_slow_down_factor = 0.2,
      shell_particle =
      {
        name = "shell-particle",
        direction_deviation = 0.1,
        speed = 0.1,
        speed_deviation = 0.03,
        center = {0, 0.1},
        creation_distance = -0.5,
        starting_frame_speed = 0.4,
        starting_frame_speed_deviation = 0.1
      },
      projectile_creation_distance = 1.125,
      range = 15,
      sound = make_light_gunshot_sounds(),
      ammo_type =
      {
        category = "bullet",
        action_delivery =
        {
          {
            type = "instant",
            source_effects =
            {
              {
                type = "create-explosion",
                entity_name = "explosion-gunshot"
              }
            },
            target_effects =
            {
              {
                type = "create-entity",
                entity_name = "explosion-hit"
              },
              {
                type = "damage",
                damage = { amount = 5 , type = "physical"}
              }
            }
          }
        }
      },
      animation =
      {
        layers=
        {
          playeranimations.level1.idle_gun,
          playeranimations.level1.idle_gun_mask,
          playeranimations.level1.idle_gun_shadow
        }
      }
    },
    movement_speed = 0.1,
    distance_per_frame = 0.188,
    pollution_to_join_attack = 1000,
    distraction_cooldown = 300,
    vision_distance = 30,
    --UNIT OPT
    min_pursue_time = 10 * 60,
    max_pursue_distance = 50,
  },
})

local noArmor = table.deepcopy(data.raw.unit["NoArmorPistol"])
local lightArmor = table.deepcopy(data.raw.unit["LightArmorPistol"])
local heavyArmor = table.deepcopy(data.raw.unit["HeavyArmorPistol"])

noArmor.name = "NoArmorRifle"
lightArmor.name = "LightArmorRifle"
heavyArmor.name = "HeavyArmorRifle"

noArmor.attack_parameters =
{
  type = "projectile",
  ammo_category = "bullet",
  cooldown = 6,
  movement_slow_down_factor = 0.7,
  shell_particle =
  {
    name = "shell-particle",
    direction_deviation = 0.1,
    speed = 0.1,
    speed_deviation = 0.03,
    center = {0, 0.1},
    creation_distance = -0.5,
    starting_frame_speed = 0.4,
    starting_frame_speed_deviation = 0.1
  },
  projectile_creation_distance = 1.125,
  range = 18,
  sound = make_light_gunshot_sounds(),
  ammo_type =
  {
    category = "bullet",
    action =
    {
      type = "direct",
      action_delivery =
      {
        {
          type = "instant",
          source_effects =
          {
            {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
            }
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit"
            },
            {
              type = "damage",
              damage = { amount = 5 , type = "physical"}
            }
          }
        }
      }
    }
  },
  animation =
  {
    layers=
    {
      playeranimations.level1.idle_gun,
      playeranimations.level1.idle_gun_mask,
      playeranimations.level1.idle_gun_shadow
    }
  },
}
lightArmor.attack_parameters =
{
  type = "projectile",
  ammo_category = "bullet",
  cooldown = 6,
  movement_slow_down_factor = 0.7,
  shell_particle =
  {
    name = "shell-particle",
    direction_deviation = 0.1,
    speed = 0.1,
    speed_deviation = 0.03,
    center = {0, 0.1},
    creation_distance = -0.5,
    starting_frame_speed = 0.4,
    starting_frame_speed_deviation = 0.1
  },
  projectile_creation_distance = 1.125,
  range = 18,
  sound = make_light_gunshot_sounds(),
  ammo_type =
  {
    category = "bullet",
    action =
    {
      type = "direct",
      action_delivery =
      {
        {
          type = "instant",
          source_effects =
          {
            {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
            }
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit"
            },
            {
              type = "damage",
              damage = { amount = 5 , type = "physical"}
            }
          }
        }
      }
    }
  },
  animation =
  {
    layers=
    {
      playeranimations.level1.idle_gun,
      playeranimations.level1.idle_gun_mask,
      playeranimations.level1.idle_gun_shadow
    }
  },
}
heavyArmor.attack_parameters =
{
  type = "projectile",
  ammo_category = "bullet",
  cooldown = 6,
  movement_slow_down_factor = 0.7,
  shell_particle =
  {
    name = "shell-particle",
    direction_deviation = 0.1,
    speed = 0.1,
    speed_deviation = 0.03,
    center = {0, 0.1},
    creation_distance = -0.5,
    starting_frame_speed = 0.4,
    starting_frame_speed_deviation = 0.1
  },
  projectile_creation_distance = 1.125,
  range = 18,
  sound = make_light_gunshot_sounds(),
  ammo_type =
  {
    category = "bullet",
    action =
    {
      type = "direct",
      action_delivery =
      {
        {
          type = "instant",
          source_effects =
          {
            {
              type = "create-explosion",
              entity_name = "explosion-gunshot"
            }
          },
          target_effects =
          {
            {
              type = "create-entity",
              entity_name = "explosion-hit"
            },
            {
              type = "damage",
              damage = { amount = 5 , type = "physical"}
            }
          }
        }
      }
    }
  },
  animation =
  {
    layers=
    {
      playeranimations.level1.idle_gun,
      playeranimations.level1.idle_gun_mask,
      playeranimations.level1.idle_gun_shadow
    }
  },
}

data:extend({noArmor,lightArmor,heavyArmor})