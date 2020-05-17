--cars.lua

local car = table.deepcopy(data.raw.car["car"])
car.name = "civilian_car"
car.guns = {}
car.turret_animation = nil
car.minable = {mining_time = 0.4, result = "civilian_car"}
car.max_health = 250
car.weight = 500
car.inventory_size = 10
data:extend{car}

local tank = table.deepcopy(data.raw.car["tank"])
tank.name = "tractor"
tank.guns = {}
tank.turret_animation = nil
tank.resistances = car.resistances
tank.minable = {mining_time = 0.4, result = "tractor"}
tank.max_health = 500
tank.weight = 10000
tank.inventory_size = 10
tank.immune_to_tree_impacts = false
data:extend{tank}

data:extend({
  {
    type = "item-with-entity-data",
    name = "civilian_car",
    icon = "__base__/graphics/icons/car.png",
    icon_size = 32,
    subgroup = "transport",
    order = "b[personal-transport]-a[car]",
    place_result = "civilian_car",
    stack_size = 1
  },
  {
    type = "item-with-entity-data",
    name = "tractor",
    icon = "__base__/graphics/icons/tank.png",
    icon_size = 32,
    subgroup = "transport",
    order = "b[personal-transport]-b[tank]",
    place_result = "tractor",
    stack_size = 1
  }
})