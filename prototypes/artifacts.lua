--artifacts.lua

data:extend({
  {
    type = "generator-equipment",
    name = "artifact_test",
    sprite =
    {
      filename = "__f-a-c-t-o-r-i-o__/graphics/items/artifact.png",
      width = 32,
      height = 32,
      priority = "medium"
    },
    shape =
    {
      width = 1,
      height = 1,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "primary-output"
    },
    power = "0.000001W",
    categories = {"artifact"}
  },
  {
    type = "item",
    name = "artifact_test",
    icon = "__f-a-c-t-o-r-i-o__/graphics/items/artifact.png",
    icon_size = 32,
    placed_as_equipment_result = "artifact_test",
    subgroup = "equipment",
    stack_size = 5
  },
  
  {
    type = "generator-equipment",
    name = "artifact_shock",
    sprite =
    {
      filename = "__f-a-c-t-o-r-i-o__/graphics/items/artifact.png",
      width = 32,
      height = 32,
      priority = "medium"
    },
    shape =
    {
      width = 1,
      height = 1,
      type = "full"
    },
    energy_source =
    {
      type = "electric",
      usage_priority = "primary-output"
    },
    power = "0.000001W",
    categories = {"artifact"}
  },
  {
    type = "item",
    name = "artifact_shock",
    icon = "__f-a-c-t-o-r-i-o__/graphics/items/artifact.png",
    icon_size = 32,
    placed_as_equipment_result = "artifact_shock",
    localised_description = "artifact_shock_description",
    subgroup = "equipment",
    stack_size = 5
  }
})