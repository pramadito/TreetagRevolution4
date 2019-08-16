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
  PrecacheItemByNameSync("item_ent_hand_1", context)
  PrecacheItemByNameSync("item_ent_hand_2", context)
  PrecacheItemByNameSync("item_ent_blink", context)
  PrecacheItemByNameSync("item_ent_invis", context)
  PrecacheItemByNameSync("item_ent_destroy_aoe", context)



  -- Entire heroes (sound effects/voice/models/particles) can be precached with PrecacheUnitByNameSync

  
  -- Custom units from npc_units_custom.txt can also have all of their abilities and precache{} blocks precached in this way
  PrecacheUnitByNameSync("npc_dota_hero_wisp", context)
  PrecacheUnitByNameSync("npc_dota_hero_warlock", context)
  PrecacheUnitByNameSync("resource_storage_1", context)
  PrecacheUnitByNameSync("resource_storage_2", context)
  PrecacheUnitByNameSync("resource_storage_3", context)
  PrecacheUnitByNameSync("sentry_tower", context)
  PrecacheUnitByNameSync("basic_tree", context)
  PrecacheUnitByNameSync("armored_tree", context)
  PrecacheUnitByNameSync("invisible_tree", context)
  PrecacheUnitByNameSync("tree_of_life", context)
  
end

-- Create the game mode when we activate
function Activate()

  GameRules.maxFood = 100
  GameRules.gold = {}
  GameRules.lumber = {}
  GameRules.goldGained = {}
  GameRules.lumberGained = {}
  GameRules.goldGiven = {}
  GameRules.lumberGiven = {}
  GameRules.InfernalWin = false
  GameRules.heroes = {}
  GameRules.shops = {}
  GameRules.players = {}
  GameRules.firstHero = true
  GameRules.stunHeroes = true
  GameRules.InfernalSpawned = false
  GameRules.dcedChoosers = {}
  --GameRules.InfernalTimer = 30
  --GameRules.shops = Entities:FindAllByClassname("trigger_shop")
  --GameRules.playersColors = {{0, 102, 255},{0, 204, 255},{153, 0, 204},{225,0,255},{255, 255, 0},{255, 153, 51},{51, 204, 51},{0, 105, 0},{128, 0, 0},{176, 0, 0},{60,20,74}}
  GameRules.startTime = 0
  GameRules.colorCounter = 1
  GameRules.playerCount = 0
  GameRules.GameMode = GameMode()
  GameRules.GameMode:InitGameMode()
end