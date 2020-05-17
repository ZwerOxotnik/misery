--anomaly_sounds.lua

local anomaly_sounds = {}

anomaly_sounds.radiation_tick = 0

function anomaly_sounds.init()
end

function anomaly_sounds.update(player, radiation)
  anomaly_sounds.update_radiation(player, radiation)
end

function anomaly_sounds.update_radiation(player, radiation)
  if(radiation == 0) then 
    anomaly_sounds.radiation_tick = 0
    return
  end
  if(anomaly_sounds.radiation_tick >= 60) then
    anomaly_sounds.radiation_tick = 0
    if(radiation > 0.66) then
      player.play_sound( { path = "strong_radiation" } );
    elseif(radiation > 0.33) then
      player.play_sound( { path = "medium_radiation" } );
    else
      player.play_sound( { path = "weak_radiation" } );
    end    
  end
  anomaly_sounds.radiation_tick = anomaly_sounds.radiation_tick + 1
end

return anomaly_sounds