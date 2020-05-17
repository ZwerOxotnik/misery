--armor.lua

local armor = table.deepcopy(data.raw.armor["light-armor"])
armor.equipment_grid = "short-artifact-belt"
data:extend{armor}

local armor = table.deepcopy(data.raw.armor["heavy-armor"])
armor.resistances["rad"] = { type = "radioactive", decrease = 0, percent = 10 }
armor.resistances["chem"] = { type = "chemical", decrease = 3, percent = 5 }
armor.equipment_grid = "artifact-belt"
data:extend{armor}

local armor = table.deepcopy(data.raw.armor["modular-armor"])
armor.resistances["rad"] = { type = "radioactive", decrease = 10, percent = 30 }
armor.resistances["chem"] = { type = "chemical", decrease = 5, percent = 30 }
armor.resistances["psi"] = { type = "psi", decrease = 0, percent = 10 }
data:extend{armor}

local armor = table.deepcopy(data.raw.armor["power-armor"])
armor.resistances["rad"] = { type = "radioactive", decrease = 30, percent = 50 }
armor.resistances["chem"] = { type = "chemical", decrease = 15, percent = 50 }
armor.resistances["psi"] = { type = "psi", decrease = 15, percent = 30 }
data:extend{armor}

local armor = table.deepcopy(data.raw.armor["power-armor-mk2"])
armor.resistances["rad"] = { type = "radioactive", decrease = 50, percent = 70 }
armor.resistances["chem"] = { type = "chemical", decrease = 25, percent = 70 }
armor.resistances["psi"] = { type = "psi", decrease = 25, percent = 50 }
data:extend{armor}