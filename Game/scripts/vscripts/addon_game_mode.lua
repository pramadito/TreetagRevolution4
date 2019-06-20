-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc

require('internal/util')
require('gamemode')
require("libraries/buildinghelper")

function Precache( context )
--[[
  This function is used to precache resources/units/items/abilities that will be needed
  for sure in your game and that will not be precached by hero selection.  When a hero
  is selected from the hero selection screen, the game will precache that hero's assets,
  any equipped cosmetics, and perform the data-driven precaching defined in that hero's
  precache{} block, as well as the precache{} block for any equipped abilities.

  See GameMode:PostLoadPrecache() in gamemode.lua for more information
  ]]

  DebugPrint("[BAREBONES] Performing pre-load precache")

  PrecacheResource("particle_folder", "particles/buildinghelper", context)
  PrecacheResource("particle","particles/econ/events/league_teleport_2014/teleport_end_league.vpcf",context)
  PrecacheResource("soundfile","soundevents/game_sounds_heroes/game_sounds_sven.vsndevts",context)
  PrecacheResource("particle","particles/units/heroes/hero_sven/sven_spell_storm_bolt.vpcf",context)
  PrecacheResource("particle","particles/units/heroes/hero_sven/sven_storm_bolt_projectile_explosion.vpcf",context)
  PrecacheResource("particle","particles/generic_gameplay/generic_stunned.vpcf",context)

  -- Entire items can be precached by name
  -- Abilities can also be precached in this way despite the name
  PrecacheItemByNameSync("item_treant_hand_1", context)
  PrecacheItemByNameSync("item_treant_hand_2", context)
  PrecacheItemByNameSync("item_treant_blink", context)


  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  PrecacheUnitByNameSync("npc_dota_hero_wisp", context)
  PrecacheUnitByNameSync("gold_mine_1", context)
end

-- Create the game mode when we activate
function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
  GameRules.max_food = 100
  GameRules.gold = {}
  GameRules.lumber = {}
  GameRules.goldGained = {}
  GameRules.lumberGained = {}
  GameRules.goldGiven = {}
  GameRules.lumberGiven = {}
end