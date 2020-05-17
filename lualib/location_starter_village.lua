--location_starter_village.lua

local location = require("lualib.location_general")

function location.init()
  location.initLocations(game.surfaces["nauvis"], "_village")
  location.initTraders()
end

function location.initTraders()
  for k, pos in pairs(location.traders) do
    if(location.surface.can_place_entity({name="NoArmorIdle", position=pos.position, force="LONERS"})) then
      pos.unit = location.surface.create_entity({name="NoArmorIdle", position=pos.position, force="LONERS", direction = defines.direction.south})
      pos.unit.set_command({ type = defines.command.stop, distaction = defines.distraction.none })
    end
  end
end

return location