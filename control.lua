--control.lua

local main = require("lualib/main")

script.on_event(defines.events.on_tick, function(event)
  local player = game.players[1]
  if(player.controller_type == defines.controllers.character) then
    main.init()
  end
end)