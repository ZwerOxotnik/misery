--player_stats.lua

local player_stats = {}
player_stats.stats = {}

function player_stats.initPlayerGUI(player, ui)
  local main = ui.add{name="playerStatsUI", direction = "vertical", type = "flow"}
  local frame = main.add{name="frame", direction = "vertical", type = "frame", caption = {"Panel_caption"}}
  frame.style.top_margin = 0
  local flow = frame.add{name="healthbar", type = "flow", direction = "horizontal"}
  flow.style.vertical_align = "center"
  local item = flow.add{name="bar", type = "progressbar", value = 1}
  item.style.color = {r = 0.5}
  flow.add{name="label", type = "label", caption = {"Panel_health_bar"}}
  
  local flow = frame.add{name="radbar", type = "flow", direction = "horizontal"}
  flow.style.vertical_align = "center"
  local bar = flow.add{name="bar", type = "progressbar", value = 0}
  bar.style.color = {g = 0.5}
  flow.add{name="label", type = "label", caption = {"Panel_rad_bar"}}
  
  local flow = frame.add{name="chembar", type = "flow", direction = "horizontal"}
  flow.style.vertical_align = "center"
  local bar = flow.add{name="bar", type = "progressbar", value = 0}
  bar.style.color = {r = 0.5, g = 0.35}
  flow.add{name="label", type = "label", caption = {"Panel_chem_bar"}}
  
  local flow = frame.add{name="psibar", type = "flow", direction = "horizontal"}
  flow.style.vertical_align = "center"
  local bar = flow.add{name="bar", type = "progressbar", value = 0}
  bar.style.color = {r = 0.2, g = 0.4, b = 0.5}
  flow.add{name="label", type = "label", caption = {"Panel_psi_bar"}}
  
  local flow = main.add{name="areabar", type = "flow", direction = "horizontal"}
  flow.style.left_margin = 10
  flow.style.top_margin = 5
  local item = flow.add{name="rad", type = "sprite", sprite = "f-a-c-t-o-r-i-o_RadIconNone"}
  local item = flow.add{name="chem", type = "sprite", sprite = "f-a-c-t-o-r-i-o_ChemIconNone"}
  local item = flow.add{name="psi", type = "sprite", sprite = "f-a-c-t-o-r-i-o_PsiIconNone"}
  
  player_stats.stats[player.index] = {rad = 0, chem = 0, psi = 0}
end

function player_stats.setBar(player, type, value)
  if (player.gui.top["f.a.c.t.o.r.i.o-playerUI"]) then
    local frame = player.gui.top["f.a.c.t.o.r.i.o-playerUI"].playerStatsUI.frame
    if(type == "health") then
      frame.healthbar.bar.value = value 
    elseif(type == "rad") then
      frame.radbar.bar.value = value
    elseif(type == "chem") then
      frame.chembar.bar.value = value
    elseif(type == "psi") then
      frame.psibar.bar.value = value
    end
  end
end

function player_stats.setIcon(player, type, value)
  if (player.gui.top["f.a.c.t.o.r.i.o-playerUI"]) then
    local frame = player.gui.top["f.a.c.t.o.r.i.o-playerUI"].playerStatsUI.areabar
  
    if(value > 1) then value = 1 end
    if(value < 0) then value = 0 end
    
    local append = "None"
    if(value > 0.66) then
      append = "Strong"
    elseif(value > 0.33) then
      append = "Medium"
    elseif(value > 0) then
      append = "Weak"
    end
    
    if(type == "rad") then
      frame.rad.sprite = "f-a-c-t-o-r-i-o_RadIcon"..append
    elseif(type == "chem") then
      frame.chem.sprite = "f-a-c-t-o-r-i-o_ChemIcon"..append
    elseif(type == "psi") then
      frame.psi.sprite = "f-a-c-t-o-r-i-o_PsiIcon"..append
    end
  end
end

function player_stats.setStat(player, type, value)
  player_stats.stats[player.index][type] = value 
  if(player_stats.stats[player.index][type] < 0) then player_stats.stats[player.index][type] = 0 end
end

function player_stats.addStat(player, type, value)
  player_stats.stats[player.index][type] = player_stats.stats[player.index][type] + value
  if(player_stats.stats[player.index][type] < 0) then player_stats.stats[player.index][type] = 0 end
end

function player_stats.getStat(player, type)
  return player_stats.stats[player.index][type]
end

function player_stats.usedItem(event)
  local player = game.players[event.player_index]
  if(event.item.name == "vodka") then
    pplStats.addStat(player, "rad", -0.2)
    pplStats.setIcon(player, "rad", pplStats.getStat(player, "rad"))
  elseif(event.item.name == "suitCleaner") then
    pplStats.addStat(player, "chem", -0.3)
    pplStats.setIcon(player, "chem", pplStats.getStat(player, "chem"))
  elseif(event.item.name == "brainController") then
    pplStats.addStat(player, "psi", -0.5)
    pplStats.setIcon(player, "psi", pplStats.getStat(player, "psi"))
  end
end

return player_stats