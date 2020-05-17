--player_equipment.lua

local player_equipment = {}
player_equipment.players = {}

player_equipment.armor_table = require("tables.armor_table")
player_equipment.artifacts_table = require("tables.artifacts_table")

function player_equipment.initPlayer(player)
  player_equipment.players[player.index] =
  {
    armor =
    {
      name = "",
      stats = {rad = 0, chem = 0, psi = 0},
      grid = nil
    },
    stats = {rad = 0, chem = 0, psi = 0}
  }
end

function player_equipment.on_armor_changed(event)
  local player = game.players[event.player_index]
  if (player.character == nil) then return end
  
  local armor = player.character.get_inventory(defines.inventory.player_armor)
  player_equipment.players[player.index].stats = {rad = 0, chem = 0, psi = 0}
  
  if(not(armor[1].valid_for_read) or armor == nil) then
    player_equipment.players[player.index].armor.name = ""
    player_equipment.players[player.index].armor.stats = {rad = 0, chem = 0, psi = 0}
    player_equipment.players[player.index].armor.grid = nil
    return
    
  else
    player_equipment.players[player.index].armor.grid = armor[1].grid
    player_equipment.load_artifacts_from_armor(player)
    
    for k,item in pairs(player_equipment.armor_table) do
      if(item.name == armor[1].name) then
        player_equipment.players[player.index].armor.name = item.name
        player_equipment.players[player.index].armor.stats = item.stats
        return
      end
    end
    
  end
end

function player_equipment.on_artifact_added(event)
  local player = game.players[event.player_index]
  if (player_equipment.players[player.index].armor.grid ~= event.grid) then return end
  for k,item in pairs(player_equipment.artifacts_table) do
    if(item.name == event.equipment.name) then
      player_equipment.players[player.index].stats["rad"] = player_equipment.players[player.index].stats["rad"] + item.stats["rad"]
      player_equipment.players[player.index].stats["chem"] = player_equipment.players[player.index].stats["chem"] + item.stats["chem"]
      player_equipment.players[player.index].stats["psi"] = player_equipment.players[player.index].stats["psi"] + item.stats["psi"]
      return
    end
  end
end

function player_equipment.on_artifact_removed(event)
  local player = game.players[event.player_index]
  if (player_equipment.players[player.index].armor.grid ~= event.grid) then return end
  for k,item in pairs(player_equipment.artifacts_table) do
    if(item.name == event.equipment) then
      player_equipment.players[player.index].stats["rad"] = player_equipment.players[player.index].stats["rad"] - item.stats["rad"]
      player_equipment.players[player.index].stats["chem"] = player_equipment.players[player.index].stats["chem"] - item.stats["chem"]
      player_equipment.players[player.index].stats["psi"] = player_equipment.players[player.index].stats["psi"] - item.stats["psi"]
      return
    end
  end
end

function player_equipment.load_artifacts_from_armor(player)
  if(player_equipment.players[player.index].armor.grid == nil) then return end
  for k,item in pairs(player_equipment.players[player.index].armor.grid.equipment) do
    player_equipment.add_artifact(player, item)
  end
end

function player_equipment.add_artifact(player, artifact)
  for k,item in pairs(player_equipment.artifacts_table) do
    if(item.name == artifact.name) then
      player_equipment.players[player.index].stats["rad"] = player_equipment.players[player.index].stats["rad"] + item.stats["rad"]
      player_equipment.players[player.index].stats["chem"] = player_equipment.players[player.index].stats["chem"] + item.stats["chem"]
      player_equipment.players[player.index].stats["psi"] = player_equipment.players[player.index].stats["psi"] + item.stats["psi"]
      return
    end
  end
end

function player_equipment.get_stats(player, type)
  return player_equipment.players[player.index].stats[type]
end
function player_equipment.get_armor_stats(player, type)
  return player_equipment.players[player.index].armor.stats[type]
end

return player_equipment