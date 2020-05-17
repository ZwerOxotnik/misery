--location_general.lua

--  Colors used to number position with the same number
--  Red
--    if a path waypoint
--      0-85 type = single
--      86-170 type = loop
--      171-255 type = return
--  Green
--    enumeration
--  Blue
--    if a path waypoint
--      the path it belongs

local location = {}
location.surface = nil
location.traders = {}
location.spawns = {}
location.patrol_paths = {}

function location.initLocations(surface, position_prefix)
  location.surface = surface
  for k, pos in pairs(surface.get_script_positions(position_prefix.."_trader")) do
    location.traders[pos.color.g] = { position = pos.position, unit = nil }
  end
  for k, pos in pairs(surface.get_script_positions(position_prefix.."_spawn")) do
    location.spawns[pos.color.g] = { position = pos.position }
  end
  for k, pos in pairs(surface.get_script_positions(position_prefix.."_p")) do
    if(location.patrol_paths[pos.color.b] == nil) then
      location.patrol_paths[pos.color.b] = { type = "single", nodes = {}}
    end
    location.patrol_paths[pos.color.b].nodes[pos.color.g] = pos.position
    if(pos.color.r > 170) then location.patrol_paths[pos.color.b].type = "return"
    elseif(pos.color.r > 85) then location.patrol_paths[pos.color.b].type = "loop"
    else location.patrol_paths[pos.color.b].type = "single" end
  end
end

return location