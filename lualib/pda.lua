--pda.lua

--available functions:
--  initPlayerGUI(player, ui) ///////////////////////////|
--  update() ////////////////////////////////////////////|
--  InventoryToggle(event) //////////////////////////////|
--  InventoryOpen(event) ////////////////////////////////|
--  InventoryClose(event) ///////////////////////////////|

--  onPDAButtonsClicked(event) //////////////////////////|
--  onPDAToggle(event) //////////////////////////////////|
--  PDAToggle(event) ////////////////////////////////////|
--  PDAOpen(event) //////////////////////////////////////|
--  PDAClose(event) /////////////////////////////////////|
--  PDASetScreen(event, type) ///////////////////////////|
--  onSliderValueChanged(event) /////////////////////////| minimap for now

--  addObjectiveToTable(player, obj_text, desc_text) ////|
--  removeObjectiveFromTable(player, obj_num) ///////////|

local pda = {}
pda.objectiveTables = {}
pda.GUIs = {}
pda.inventoryOpenState = {}

function pda.initPlayerGUI(player, ui)

  local UI_BUTTON = ui.add{name="playerPDAbutton", direction = "vertical", type = "frame"}
  UI_BUTTON.add{name="PDA_toggle", type="sprite-button", sprite="misery_PDAIcon"}
  UI_BUTTON.style.left_margin = -3
  
  if player.gui.center["f.a.c.t.o.r.i.o-playerPDA"] then
    player.gui.center["f.a.c.t.o.r.i.o-playerPDA"].destroy() end
    
  local MAIN_UI = player.gui.center.add{name="f.a.c.t.o.r.i.o-playerPDA", type = "flow", direction = "vertical"}
  local MAIN_FRAME = MAIN_UI.add{name="PDA_content", type = "frame", caption = {"PDA_top_caption", player.name}, direction = "vertical"}
  local MAIN_FOREGROUND = MAIN_UI.add{name="PDA_image", type = "sprite", sprite = "misery_PDA_old", direction = "vertical", ignored_by_interaction = true}
  
  pda.GUIs[player.index] = MAIN_UI
  
  MAIN_FRAME.style.width = 768
  MAIN_FRAME.style.height = 575
  
  MAIN_FOREGROUND.style.top_margin = -660
  MAIN_FOREGROUND.style.left_margin = -96
  
  local LOCAL_FLOW = MAIN_FRAME.add{name="PDA_buttons", type = "flow", direction = "horizontal"}
  LOCAL_FLOW.add{name="PDA_main", type="sprite-button", sprite="misery_PDAIcon", tooltip={"PDA_main_button_tooltip"}}
  LOCAL_FLOW.add{name="PDA_map", type="sprite-button", sprite="misery_PDAIcon", tooltip={"PDA_map_button_tooltip"}}
  LOCAL_FLOW.add{name="PDA_quests", type="sprite-button", sprite="misery_PDAIcon", tooltip={"PDA_quests_button_tooltip"}}
  LOCAL_FLOW.add{name="PDA_logs", type="sprite-button", sprite="misery_PDAIcon", tooltip={"PDA_logs_button_tooltip"}}
  LOCAL_FLOW.add{name="PDA_encyclopedia", type="sprite-button", sprite="misery_PDAIcon", tooltip={"PDA_encyclopedia_button_tooltip"}}
  local item = LOCAL_FLOW.add{name="PDA_manual", type="sprite-button", sprite="misery_PDAIcon", tooltip={"PDA_manual_button_tooltip"}}
  item.style.left_margin = 497
  --flow.add{name="PDA_other", type="sprite-button", sprite="misery_PDAIcon", tooltip="OTHER"}
  
  local LOCAL_FLOW = MAIN_FRAME.add{name="PDA_main", type = "flow", direction = "vertical"}
  LOCAL_FLOW.style.width = 743
  LOCAL_FLOW.style.height = 487
  LOCAL_FLOW.visible = false
  
  local LOCAL_FLOWB = LOCAL_FLOW.add{name="PDA_main_top_frame", type = "frame", direction = "horizontal"}
  LOCAL_FLOWB.style.width = 743
  LOCAL_FLOWB.style.height = 216
  local item = LOCAL_FLOWB.add{name="PDA_main_time_label", type = "label", caption = {"PDA_main_time_label", player.name, 0, 0}}
  item.style.font = "default-bold"
  item.style.font_color = {1,1,1,1}
  
  local LOCAL_FLOWB = LOCAL_FLOW.add{name="PDA_main_bottom_flow", type = "flow", direction = "horizontal"}
  LOCAL_FLOWB.style.width = 743
  LOCAL_FLOWB.style.height = 268
  
  local item = LOCAL_FLOWB.add{name="PDA_main_bottom_frame_left", type = "frame", direction = "horizontal"}
  item.style.width = 272
  item.style.height = 268
  local item = item.add{name="PDA_minimap_map", type = "minimap", zoom = 1}
  item.style.width = 250
  item.style.height = 250
  
  local item = LOCAL_FLOWB.add{name="PDA_main_bottom_frame_right", type = "frame", direction = "horizontal"}
  item.style.width = 467
  item.style.height = 268
  
  local LOCAL_FLOW = MAIN_FRAME.add{name="PDA_minimap", type = "flow", direction = "vertical"}
  LOCAL_FLOW.style.width = 743
  LOCAL_FLOW.style.height = 487
  LOCAL_FLOW.visible = false
  local item = LOCAL_FLOW.add{name="PDA_minimap_map", type = "minimap", zoom = 1, force = "MONOLITH"}
  item.style.width = 743
  item.style.height = 467
  local item = LOCAL_FLOW.add{name="PDA_minimap_slider", type = "slider", minimum_value=0.5, maximum_value=2, value=1}
  item.style.width = 743
  
  local LOCAL_FLOW = MAIN_FRAME.add{name="PDA_quests", type = "flow", direction = "vertical"}
  LOCAL_FLOW.style.width = 743
  LOCAL_FLOW.style.height = 487
  LOCAL_FLOW.visible = false
  local scroll = LOCAL_FLOW.add{name="PDA_quests_scroll", type = "scroll-pane", horizontal_scroll_policy = "never", vertical_scroll_policy = "always"}
  scroll.style.width = 743
  scroll.style.height = 487
  
  local LOCAL_FLOW = MAIN_FRAME.add{name="PDA_encyclopedia", type = "flow", direction = "vertical"}
  LOCAL_FLOW.style.width = 743
  LOCAL_FLOW.style.height = 487
  LOCAL_FLOW.visible = false
  local scroll = LOCAL_FLOW.add{name="PDA_encyclopedia_scroll", type = "scroll-pane", horizontal_scroll_policy = "never", vertical_scroll_policy = "always"}
  scroll.style.width = 743
  scroll.style.height = 487
  
  local LOCAL_FLOW = MAIN_FRAME.add{name="PDA_logs", type = "flow", direction = "vertical"}
  LOCAL_FLOW.style.width = 743
  LOCAL_FLOW.style.height = 487
  LOCAL_FLOW.visible = false
  local scroll = LOCAL_FLOW.add{name="PDA_logs_scroll", type = "scroll-pane", horizontal_scroll_policy = "never", vertical_scroll_policy = "always"}
  scroll.style.width = 743
  scroll.style.height = 487
  
  local LOCAL_FLOW = MAIN_FRAME.add{name="PDA_manual", type = "flow", direction = "vertical"}
  LOCAL_FLOW.style.width = 743
  LOCAL_FLOW.style.height = 487
  LOCAL_FLOW.visible = false
  local scroll = LOCAL_FLOW.add{name="PDA_manual_scroll", type = "scroll-pane", horizontal_scroll_policy = "never", vertical_scroll_policy = "always"}
  scroll.style.width = 743
  scroll.style.height = 487
  
  pda.inventoryOpenState[player.index] = false
  
  pda.GUIs[player.index]["PDA_content"]["PDA_main"].visible = true
  pda.GUIs[player.index].visible = false
  
  pda.objectiveTables[player.index] = { table = scroll, count = 0 }
end

function pda.update()
  for player_index,GUI in pairs(pda.GUIs) do
    if(GUI["PDA_content"]["PDA_main"].visible == true) then
      local daytime = game.players[player_index].surface.daytime - 6/24
      if(daytime < 0) then daytime = daytime + 1 end
      GUI["PDA_content"]["PDA_main"]["PDA_main_top_frame"]["PDA_main_time_label"].caption =
      {
        "PDA_main_time_label",
        game.players[player_index].name,
        math.floor(daytime*24),
        math.floor((daytime*24*60)%60)
      }
    end
  end
end

function pda.onSliderValueChanged(event)
  if(event.element.name == "PDA_minimap_slider") then
    event.element.parent["PDA_minimap_map"].zoom = event.element.slider_value
  end
end

function pda.InventoryToggle(event)
  if(pda.inventoryOpenState[event.player_index]) then
    game.players[event.player_index].opened = nil
    pda.inventoryOpenState[event.player_index] = false
  else
    game.players[event.player_index].opened = game.players[event.player_index]
    pda.PDAClose(event)
    pda.inventoryOpenState[event.player_index] = true
  end
end

function pda.InventoryClose(event)
  game.players[event.player_index].opened = nil
  pda.inventoryOpenState[event.player_index] = false
end

function pda.InventoryOpen(event)
  game.players[event.player_index].opened = game.players[event.player_index]
  pda.PDAClose(event)
  pda.inventoryOpenState[event.player_index] = true
end

function pda.onPDAToggle(event)
  if(event.element.name == "PDA_toggle") then
    pda.PDAToggle(event)
  end
  pda.InventoryClose(event)
end

function pda.PDAToggle(event)
  pda.GUIs[event.player_index].visible = not pda.GUIs[event.player_index].visible
end

function pda.PDAOpen(event)
  pda.GUIs[event.player_index].visible = true
end

function pda.PDAClose(event)
  pda.GUIs[event.player_index].visible = false
end

function pda.PDASetScreen(event, type)
  pda.GUIs[event.player_index]["PDA_content"]["PDA_main"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_minimap"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_quests"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_encyclopedia"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_logs"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_manual"].visible = false
  
  if(type == "map") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_minimap"].visible = true
  elseif(type == "quest") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_quests"].visible = true
  elseif(type == "encyclopedia") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_encyclopedia"].visible = true
  elseif(type == "main") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_main"].visible = true
  elseif(type == "manual") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_manual"].visible = true
  elseif(type == "log") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_logs"].visible = true
  end
end

function pda.onPDAButtonsClicked(event)
  if(event.element.parent.name ~= "PDA_buttons") then return end
  pda.GUIs[event.player_index]["PDA_content"]["PDA_main"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_minimap"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_quests"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_encyclopedia"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_logs"].visible = false
  pda.GUIs[event.player_index]["PDA_content"]["PDA_manual"].visible = false
  
  if(event.element.name == "PDA_map") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_minimap"].visible = true
  elseif(event.element.name == "PDA_quests") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_quests"].visible = true
  elseif(event.element.name == "PDA_encyclopedia") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_encyclopedia"].visible = true
  elseif(event.element.name == "PDA_main") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_main"].visible = true
  elseif(event.element.name == "PDA_manual") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_manual"].visible = true
  elseif(event.element.name == "PDA_logs") then
    pda.GUIs[event.player_index]["PDA_content"]["PDA_logs"].visible = true
  end
end

function pda.addObjectiveToTable(player, obj_text, desc_text)
  local flow = pda.objectiveTables[player.index].table.add{name="PDA_quest_"..pda.objectiveTables[player.index].count, type="flow", direction="horizontal"}
  local item = flow.add{name="PDA_quest_title", type = "frame"}
    item.style.width = 200
    item.style.vertically_stretchable = true
  local item = item.add{name="PDA_text", type = "label", caption={obj_text}}
    item.style.font = "heading-2"
    item.style.font_color = {1,1,1,1}
    item.style.width = 196
    item.style.single_line = false
  local item = flow.add{name="PDA_quest_desc", type = "frame", direction = "vertical"}
    item.style.width = 518
    item.style.vertically_stretchable = true
  local item = item.add{name="PDA_text", type = "label", caption={desc_text}}
    item.style.font = "default-bold"
    item.style.font_color = {1,1,1,1}
    item.style.width = 514
    item.style.single_line = false
    
  pda.objectiveTables[player.index].count = pda.objectiveTables[player.index].count + 1
  return pda.objectiveTables[player.index].count - 1
end

function pda.removeObjectiveFromTable(player, obj_num)
  for k, item in pairs(pda.objectiveTables[player.index].table) do
    if(item.name == "PDA_quest_"..obj_num) then
      item.destroy()
      return
    end
  end
end

return pda