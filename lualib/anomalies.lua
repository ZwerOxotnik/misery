--anomalies.lua
local anomalies = {}

math2d = require ("math2d")

anomalies.surfaces = {}
anomalies.random = nil

anomalies.tables = {}
anomalies.tables.anomaly = require("lualib/tables/anomaly_table.lua")
anomalies.tables.artifacts = require("lualib/tables/artifacts_table.lua")
  
function anomalies.init()
  anomalies.random = game.create_random_generator()
  for k, anomaly in pairs(anomalies.tables.anomaly) do
    anomaly.artifact_spawn_rate = anomaly.artifact_spawn_rate * 60
    for k_, damage_prototype in pairs(game.damage_prototypes) do
      if(anomaly.stats[damage_prototype.name] == nil) then
        anomaly.stats[damage_prototype.name] = 0
      end
    end    
  end
  
  for key, surface in pairs(game.surfaces) do
    anomalies.surfaces[surface.name] = { }
    for key_, anomaly in pairs(anomalies.tables.anomaly) do
      for i, pos in pairs(surface.get_script_positions(anomaly.name)) do
        anomalies.create_anomaly(pos.position, surface, anomaly)
      end
    end
  end
end

function anomalies.update()
  for k, surface in pairs(game.surfaces) do
    local surfaceTable = anomalies.surfaces[surface.name]
    for i, anomaly in pairs(surfaceTable) do
      local anomaly_type = nil
      for _k, anomaly_type_definition in pairs(anomalies.tables.anomaly) do
        if(anomaly_type_definition.name == anomaly.anomaly) then
          anomaly_type = anomaly_type_definition
          break
        end
      end
      
      if (anomaly_type.artifacts ~= nil) then
        if(anomaly.artifact_timer >= anomaly_type.artifact_spawn_rate) then
          local has_artifact = false
          for __k, item in pairs(surface.find_entities_filtered({area = {{-2+anomaly.position.x, -2+anomaly.position.y}, {2+anomaly.position.x, 2+anomaly.position.y}}, type = "item-entity" })) do
            for ___k, artifact in pairs(anomaly_type.artifacts) do
              if(item.stack.name == artifact) then
                has_artifact = true
                break
              end
            end
          end
          if(has_artifact == false) then
            surface.spill_item_stack(anomaly.position, { name = anomaly_type.artifacts[anomalies.random(1,anomaly_type.artifact_total)] })
          end
          anomaly.artifact_timer = 0
        end
        anomaly.artifact_timer = anomaly.artifact_timer + 1
      end
    end
  end
end

function anomalies.create_anomaly(position, surface, anomaly)
  table.insert(anomalies.surfaces[surface.name], {
    position = position,
    surface = surface.name,
    anomaly = anomaly.name,
    artifact_timer = 0,
  })
  
  if (anomaly.effects ~= nil) then
    for k, effect in pairs(anomaly.effects) do
      for i = 0, effect.count, 1 do
        local x_offset = effect.radius*anomalies.random()*anomalies.random(-1,1)
        local y_offset = effect.radius*anomalies.random()*anomalies.random(-1,1)
        surface.create_entity({
          name = effect.effect_particle,
          position = {position.x+x_offset, position.y+y_offset},
        })
      end
    end
  end
end

function anomalies.get_damage(surface, position)
  local damages = {}
  for k_, damage_prototype in pairs(game.damage_prototypes) do
    damages[damage_prototype.name] = 0
  end
  
  for k, anomaly in pairs(anomalies.surfaces[surface.name]) do
    
    local anomaly_type = nil
    for _k, anomaly_type_definition in pairs(anomalies.tables.anomaly) do
      if(anomaly_type_definition.name == anomaly.anomaly) then
        anomaly_type = anomaly_type_definition
        break
      end
    end
    
    local distance = math2d.position.distance(position, anomaly.position)
    if (distance <= anomaly_type.radius) then
      for k_, damage_prototype in pairs(game.damage_prototypes) do
        damages[damage_prototype.name] = damages[damage_prototype.name] + anomaly_type.stats[damage_prototype.name]*(anomaly_type.radius - distance)/anomaly_type.radius
      end
    end
  end  
  return damages
end

return anomalies