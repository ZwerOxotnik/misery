--anomaly_table.lua

local effects = require("lualib/tables/anomaly_effect_table.lua")

local anomaly_table =
{
  {
    name = "_radioactive",
    stats = { radioactive = 0.15, chemical = 0.05 },
    radius = 10,
    artifact_spawn_rate = 0,
    artifact_total = 0,
    effects = nil,
    artifacts = nil,
  },
  {
    name = "_radioactive_heavy",
    stats = { radioactive = 0.65, chemical = 0.2 },
    radius = 10,
    artifact_spawn_rate = 0,
    artifact_total = 0,
    effects = nil,
    artifacts = nil,
  },
  {
    name = "_chemical",
    stats = { radioactive = 0.05, chemical = 0.2 },
    radius = 10,
    artifact_spawn_rate = 0,
    artifact_total = 0,
    effects = nil,
    artifacts = nil,
  },
  {
    name = "_psi",
    stats = { psi = 0.15 },
    radius = 10,
    artifact_spawn_rate = 0,
    artifact_total = 0,
    effects = nil,
    artifacts = nil,
  },
  {
    name = "_anomaly_shock",
    stats = { electric = 2, },
    radius = 2,
    artifact_spawn_rate = 1800,
    artifact_total = 1,
    effects = { effects.electric },
    artifacts = { "artifact_shock" },
  },
}

return anomaly_table