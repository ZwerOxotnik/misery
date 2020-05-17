--particles.lua

data:extend({
  {
    type = "simple-entity",
    name = "particle_electric_discharge",
    icon = "__base__/graphics/icons/storage-tank.png",
    icon_size = 32,
    order = "s-e",
    flags = {"placeable-off-grid", "placeable-neutral", "not-on-map", "not-flammable"},
    --render_layer = "light-effect",
    random_animation_offset = true,
    working_sound =
    {
      sound = { filename = "__base__/sound/accumulator-working.ogg", volume = 1},
    },
    animations =
    {
      layers =
      {
        {
          filename = "__misery__/graphics/particles/electric_discharge/electric-discharge2.png",
          width = 20,
          height = 20,
          line_length = 9,
          frame_count = 35,
          shift = util.by_pixel(0, 0),
          scale = 2,
          hr_version =
          {
            filename = "__misery__/graphics/particles/electric_discharge/hr-electric-discharge2.png",
            width = 43,
            height = 43,
            line_length = 9,
            frame_count = 35,
            shift = util.by_pixel(0, 0),
            scale = 1,
          }
        }
      }
    },
  },
})