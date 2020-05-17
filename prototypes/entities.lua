--entities.lua

data:extend({
  {
    type = "simple-entity-with-owner",
    name = "silo",
    render_layer = "object",
    icon = "__base__/graphics/icons/storage-tank.png",
    icon_size = 32,
    flags = {"placeable-player", "player-creation"},
    order = "s-e-w-o",
    minable = {mining_time = 0.5, result = "silo"},
    max_health = 1000,
    corpse = "medium-remnants",
    collision_box = {{-1.3, -1.3}, {1.3, 1.3}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    picture =
    {
      layers =
      {
        {
          filename = "__misery__/graphics/entity/silo/silo.png",
          priority = "extra-high",
          frames = 1,
          width = 100,
          height = 208,
          shift = util.by_pixel(0, -50),
          hr_version =
          {
            filename = "__misery__/graphics/entity/silo/hr-silo.png",
            priority = "extra-high",
            frames = 1,
            width = 200,
            height = 415,
            shift = util.by_pixel(0, -50),
            scale = 0.5
          }
        },
        {
          filename = "__misery__/graphics/entity/silo/silo-shadow.png",
          priority = "extra-high",
          frames = 1,
          width = 208,
          height = 100,
          shift = util.by_pixel(50, 10),
          draw_as_shadow = true,
          hr_version =
          {
            filename = "__misery__/graphics/entity/silo/hr-silo-shadow.png",
            priority = "extra-high",
            frames = 1,
            width = 415,
            height = 200,
            shift = util.by_pixel(50, 10),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    }
  },
  {
    type = "item-with-entity-data",
    name = "silo",
    icon = "__base__/graphics/icons/storage-tank.png",
    icon_size = 32,
    order = "s-e-w-o",
    place_result = "silo",
    stack_size = 10
  },
})