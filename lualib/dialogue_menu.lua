--dialogue_menu.lua

local dialogue_menu = {}
dialogue_menu.menus = {}

function dialogue_menu.initPlayerGUI(player)

  if player.gui.center["f.a.c.t.o.r.i.o-dialogue_menu"] then
    player.gui.center["f.a.c.t.o.r.i.o-dialogue_menu"].destroy() end
    
  local MAIN_UI = player.gui.center.add{name="f.a.c.t.o.r.i.o-dialogue_menu", type = "flow", direction = "vertical"}
  
  dialogue_menu.menus[player.index] = MAIN_UI
  
  local MAIN_FRAME = MAIN_UI.add{name="dialogue_menu", type = "frame", direction = "vertical"}
  MAIN_FRAME.style.width = 640
  MAIN_FRAME.style.height = 768
  MAIN_FRAME.visible = false
  
  local frame = MAIN_FRAME.add{name="textSpace", type = "scroll-pane", horizontal_scroll_policy = "never", vertical_scroll_policy = "always"}
  frame.style.width = 616
  frame.style.height = 586
  
  local frame = MAIN_FRAME.add{name="responseSpace", type = "frame", direction = "vertical"}
  frame.style.width = 616
  frame.style.height = 162
  
  local MAIN_FRAME = MAIN_UI.add{name="trade_menu", type = "frame", direction = "horizontal"}
  MAIN_FRAME.style.width = 1024
  MAIN_FRAME.style.height = 768
  MAIN_FRAME.visible = false
  
  local frame = MAIN_FRAME.add{name="playerInventory", type = "frame", direction = "vertical"}
  frame.style.width = 364
  frame.style.height = 752
  
  local frame = MAIN_FRAME.add{name="tradeSpace", type = "frame", direction = "vertical"}
  frame.style.width = 264
  frame.style.height = 752
  
  local frame = MAIN_FRAME.add{name="traderInventory", type = "frame", direction = "vertical"}
  frame.style.width = 364
  frame.style.height = 752
  
  
  
    
end

return dialogue_menu