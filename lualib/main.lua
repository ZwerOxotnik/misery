--main.lua

local anoms = require ("lualib/anomalies")
local pplStats = require ("lualib/player_stats")
local pdaUI = require ("lualib/pda")
local dialogueUI = require("lualib/dialogue_menu")
local pplEquipment = require("lualib/player_equipment")
local anomSounds = require("lualib/sounds/anomaly_sounds")

local _locationVillage = require("lualib/location_starter_village")

local main = {}
main.playerGUIs = {}

function main.initEvents()
  script.on_event(defines.events.on_player_created, function(event)
    main.onPlayerInit(event.player_index)
  end)
  
  script.on_event(defines.events.on_player_used_capsule, function(event)
    pplStats.usedItem(event)
  end)

  script.on_event(defines.events.on_gui_value_changed, function(event)
    pdaUI.onSliderValueChanged(event)
  end)

  script.on_event(defines.events.on_gui_click, function(event)
    pdaUI.onPDAButtonsClicked(event)
    pdaUI.onPDAToggle(event)
  end)

  script.on_event("misery_Inventory_key", function(event)
    pdaUI.InventoryToggle(event)
  end)

  script.on_event("misery_PDA_main_key", function(event)
    pdaUI.PDAToggle(event)
    pdaUI.InventoryClose(event)
  end)

  script.on_event("misery_PDA_map_key", function(event)
    pdaUI.PDASetScreen(event, "map")
    pdaUI.PDAToggle(event)
    pdaUI.InventoryClose(event)
  end)

  script.on_event("misery_PDA_quests_key", function(event)
    pdaUI.PDASetScreen(event, "quest")
    pdaUI.PDAToggle(event)
    pdaUI.InventoryClose(event)
  end)

  script.on_event("misery_PDA_encyclopedia_key", function(event)
    pdaUI.PDASetScreen(event, "encyclopedia")
    pdaUI.PDAToggle(event)
    pdaUI.InventoryClose(event)
  end)
  
  --player_equipment
  script.on_event(defines.events.on_player_armor_inventory_changed, function(event)
    pplEquipment.on_armor_changed(event)
  end)
  script.on_event(defines.events.on_player_placed_equipment, function(event)
    pplEquipment.on_artifact_added(event)
  end)
  script.on_event(defines.events.on_player_removed_equipment, function(event)
    pplEquipment.on_artifact_removed(event)
  end)
end
  
function main.init()
  main.initEvents()
  main.initPlayers()
  anoms.init()
  anomSounds.init()
  
  main.convertNeutralBuildings()
  main.setCorrectGameTime()
  _locationVillage.init()
  
  script.on_event(defines.events.on_tick, function(event)
    anoms.update()
    main.playerCycle()
    pdaUI.update()
  end)
end

function main.playerCycle()
  for key,player in pairs(game.players) do
    if (player.character ~= nil) then
      local damages = anoms.get_damage(player.character.surface, player.character.position)
      
      pplStats.setBar(player, "health", player.character.get_health_ratio())
      pplStats.setBar(player, "rad", damages.radioactive)
      pplStats.setBar(player, "chem", damages.chemical)
      pplStats.setBar(player, "psi", damages.psi)
      anomSounds.update(player, damages.radioactive)
      
      for k_, damage_prototype in pairs(game.damage_prototypes) do
        if (player.character == nil) then break end
        if(damage_prototype.name == "radioactive") then
          local damage = damages.radioactive + pplEquipment.get_armor_stats(player, "rad") + pplEquipment.get_stats(player, "rad")
          if (damage > 0) then 
            damage = player.character.damage(damage, "neutral", "radioactive")
            pplStats.addStat(player, "rad", damage/200)
          end
          if (player.character ~= nil) then
            damage = pplStats.getStat(player, "rad")/10 + pplEquipment.get_stats(player, "rad")/100
            if (damage > 0) then
              damage = player.character.damage(damage, "neutral", "internal")
              pplStats.addStat(player, "rad", damage/200)
            end
            pplStats.addStat(player, "rad", pplEquipment.get_stats(player, "rad")/100)
            pplStats.setIcon(player, "rad", pplStats.getStat(player, "rad"))
          end
        elseif(damage_prototype.name == "chemical") then
          local damage = damages.chemical + pplEquipment.get_armor_stats(player, "chem") + pplEquipment.get_stats(player, "chem") + pplStats.getStat(player, "chem")/100
          if (damage > 0) then 
            damage = player.character.damage(damage, "neutral", "chemical")
            pplStats.addStat(player, "chem", damage/200)
          end
          pplStats.addStat(player, "chem", pplEquipment.get_stats(player, "chem")/100)
          pplStats.setIcon(player, "chem", pplStats.getStat(player, "chem"))
        elseif(damage_prototype.name == "psi") then
          local damage = damages.psi + pplEquipment.get_armor_stats(player, "psi") + pplEquipment.get_stats(player, "psi")
          if (damage > 0) then 
            damage = player.character.damage(damage, "neutral", "psi")
            pplStats.addStat(player, "psi", damage/1000)
          end
          if (player.character ~= nil) then
            damage = pplStats.getStat(player, "psi")
            if (damage > 0) then
              damage = player.character.damage(damage, "neutral", "internal")
              pplStats.addStat(player, "psi", damage/1000)
            end
            pplStats.setIcon(player, "psi", pplStats.getStat(player, "psi"))
          end
        else
          player.character.damage(damages[damage_prototype.name], "neutral", damage_prototype.name)
        end
      end
    end
  end
end

function main.initPlayer(player_index)
  local player = game.players[player_index]
  player.force.disable_research()
  player.force.disable_all_prototypes()
  player.force.chart_all()
  player.disable_recipe_groups()
  player.game_view_settings.show_controller_gui = true
  player.game_view_settings.show_minimap = false
  player.game_view_settings.show_research_info = false
  player.game_view_settings.show_entity_info = false
  player.game_view_settings.show_alert_gui = true
  player.game_view_settings.update_entity_selection = false
  player.game_view_settings.show_rail_block_visualisation = false
  player.game_view_settings.show_side_menu = false
  player.game_view_settings.show_map_view_options = false
  player.game_view_settings.show_quickbar = true
  player.game_view_settings.show_shortcut_bar = true
end

function main.initPlayerGUI(player)
  if player.gui.top["f.a.c.t.o.r.i.o-playerUI"] then
    player.gui.top["f.a.c.t.o.r.i.o-playerUI"].destroy() end
    
  return player.gui.top.add{name="f.a.c.t.o.r.i.o-playerUI", direction = "horizontal", type = "flow"}
end

function main.convertNeutralBuildings()
  if(game.forces["NEUTRAL_TO_CONVERT"] == nil) then return end
  for k, entity in pairs(game.surfaces["nauvis"].find_entities_filtered({force="NEUTRAL_TO_CONVERT"})) do
    entity.force = "neutral"
    entity.destructible = false
    entity.minable = false
    entity.operable = false
    entity.rotatable = false
    entity.active = false
  end
end

function main.setCorrectGameTime()
  game.surfaces["nauvis"].daytime = 13.45/24
  game.surfaces["nauvis"].dusk = 0/24
  game.surfaces["nauvis"].evening = 3/24
  game.surfaces["nauvis"].morning = 12/24
  game.surfaces["nauvis"].dawn = 15/24
  game.surfaces["nauvis"].min_brightness = 0.02
end

function main.onPlayerInit(player_index)
  main.initPlayer(player_index)
  main.playerGUIs[player_index] = main.initPlayerGUI(game.players[player_index])
  pplStats.initPlayerGUI(game.players[player_index], main.playerGUIs[player_index])
  pdaUI.initPlayerGUI(game.players[player_index], main.playerGUIs[player_index])
  dialogueUI.initPlayerGUI(game.players[player_index])
  pplEquipment.initPlayer(game.players[player_index])
end

function main.initPlayers()
  for k, player in pairs(game.players) do
    main.onPlayerInit(player.index)
  end
end

return main