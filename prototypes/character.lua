--character.lua

local character = table.deepcopy(data.raw.player["player"])
character.damage_hit_tint = {r = 0, g = 0, b = 0, a = 0}
character.healing_per_tick = 0
character.ticks_to_stay_in_combat = 0
character.ticks_to_keep_gun = 10
character.ticks_to_keep_aiming_direction = 10
--character.damage_hit_tint = {r = 0.1, g = 0.025, b = 0, a = 0}

data:extend{character}