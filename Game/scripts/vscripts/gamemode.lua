  -- This is the primary barebones gamemode script and should be used to assist in initializing your game mode
BAREBONES_VERSION = "1.00"

-- Set this to true if you want to see a complete debug output of all events/processes done by barebones
-- You can also change the cvar 'barebones_spew' at any time to 1 or 0 for output/no output
BAREBONES_DEBUG_SPEW = false 

if GameMode == nil then
    DebugPrint( '[BAREBONES] creating barebones game mode' )
    _G.GameMode = class({})
end

-- This library allow for easily delayed/timed actions
require('libraries/timers')
-- This library can be used for advancted physics/motion/collision of units.  See PhysicsReadme.txt for more information.
--require('libraries/physics')
-- This library can be used for advanced 3D projectile systems.
-- This library can be used for sending panorama notifications to the UIs of players/teams/everyone
require('libraries/notifications')
-- This library can be used for starting customized animations on units from lua
require('libraries/animations')
-- This library can be used for performing "Frankenstein" attachments on units
-- require('libraries/attachments')
-- This library can be used to synchronize client-server data via player/client-specific nettables
--require('libraries/playertables')
-- This library provides a searchable, automatically updating lua API in the tools-mode via "modmaker_api" console command
-- require('libraries/modmaker')
-- This library (by Noya) provides player selection inspection and management from server lua
require('libraries/selection')
-- copied from tne
require('libraries/player')
require('libraries/entity')
-- These internal libraries set up barebones's events and processes.  Feel free to inspect them/change them if you need to.
require('internal/gamemode')
require('internal/events')
require('internal/util')
-- settings.lua is where you can specify many different properties for your game mode and is one of the core barebones files.
require('settings')
-- events.lua is where you can specify the actions to be taken when any event occurs and is one of the core barebones files.
require('events')


-- This is a detailed example of many of the containers.lua possibilities, but only activates if you use the provided "playground" map
--require("examples/worldpanelsExample")

--[[
  This function should be used to set up Async precache calls at the beginning of the gameplay.

  In this function, place all of your PrecacheItemByNameAsync and PrecacheUnitByNameAsync.  These calls will be made
  after all players have loaded in, but before they have selected their heroes. PrecacheItemByNameAsync can also
  be used to precache dynamically-added datadriven abilities instead of items.  PrecacheUnitByNameAsync will 
  precache the precache{} block statement of the unit and all precache{} block statements for every Ability# 
  defined on the unit.

  This function should only be called once.  If you want to/need to precache more items/abilities/units at a later
  time, you can call the functions individually (for example if you want to precache units in a new wave of
  holdout).

  This function should generally only be used if the Precache() function in addon_game_mode.lua is not working.
]]
function GameMode:PostLoadPrecache()
  DebugPrint("[BAREBONES] Performing Post-Load precache")    
  --PrecacheItemByNameAsync("item_example_item", function(...) end)
  --PrecacheItemByNameAsync("example_ability", function(...) end)

  --PrecacheUnitByNameAsync("npc_dota_hero_viper", function(...) end)
  --PrecacheUnitByNameAsync("npc_dota_hero_enigma", function(...) end)
end

--[[
  This function is called once and only once as soon as the first player (almost certain to be the server in local lobbies) loads in.
  It can be used to initialize state that isn't initializeable in InitGameMode() but needs to be done before everyone loads in.
]]
function GameMode:OnFirstPlayerLoaded()
  DebugPrint("[BAREBONES] First Player has loaded")
end

--[[
  This function is called once and only once after all players have loaded into the game, right as the hero selection time begins.
  It can be used to initialize non-hero player state or adjust the hero selection (i.e. force random etc)
]]
function GameMode:OnAllPlayersLoaded()
  print("[BAREBONES] All Players have loaded into the game")
end


function InitializeHero(hero)
  hero.food = 0
  hero.buildings = {} -- This keeps the name and quantity of each building
  hero.units = {}
  hero.goldperfivesecond = 2
  hero.lumberperfivesecond = 2
  hero.disabledBuildings = {}
  -- if GameRules.stunHeroes then
  --   hero:AddNewModifier(nil, nil, "modifier_stunned", { })
  --   table.insert(GameRules.heroes,hero)
  -- end
  Timers:CreateTimer(5, function()
    if hero:IsNull() then
      return
    end
    PlayerResource:ModifyGold(hero, hero.goldperfivesecond)
    PlayerResource:ModifyLumber(hero, hero.lumberperfivesecond)
    return 5
  end)
  PlayerResource:SetGold(hero,50)
  PlayerResource:SetLumber(hero,100) -- Secondary resource of the player
  PlayerResource:ModifyFood(hero, 0)
end
--======================== Initialize ent ===========================
function InitializeBuilder(hero)
  InitializeHero(hero)
  hero:ClearInventory()
  local ent_hand_1 = CreateItem("item_ent_hand_1", hero, hero)
  local ent_hand_2 = CreateItem("item_ent_hand_2", hero, hero)
  local ent_blink = CreateItem("item_ent_blink", hero, hero)
  local ent_aoe = CreateItem("item_ent_destroy_aoe", hero, hero)
  local ent_invis = CreateItem("item_ent_invis", hero, hero)

  hero:AddItem(ent_hand_1)
  hero:AddItem(ent_hand_2)
  hero:AddItem(ent_blink)
  hero:AddItem(ent_aoe)
  hero:AddItem(ent_invis)


  -- ==================== Make every abilities maxed ===================
  for i=0,15 do
    local ability = hero:GetAbilityByIndex(i)
    if ability then ability:SetLevel(ability:GetMaxLevel()) end
  end
end

--======================== Initialize Infernal =========================
function InitializeInfernal(hero)
  -- body
  hero:ClearInventory()

  -- local infernal_obs
  -- local infernal_altar
  -- local infernal_market
  
end
--[[
  This function is called once and only once for every player when they spawn into the game for the first time.  It is also called
  if the player's hero is replaced with a new hero for any reason.  This function is useful for initializing heroes, such as adding
  levels, changing the starting gold, removing/adding abilities, adding physics, etc.

  The hero parameter is the hero entity that just spawned in
]]
function GameMode:OnHeroInGame(hero)
	InitializeBuilder(hero)
  -- if infernal get somethingesleseela
end



--[[
  This function is called once and only once when the game completely begins (about 0:00 on the clock).  At this point,
  gold will begin to go up in ticks if configured, creeps will spawn, towers will become damageable etc.  This function
  is useful for starting any game logic timers/thinkers, beginning the first round, etc.
]]
function GameMode:OnGameInProgress()
  DebugPrint("[BAREBONES] The game has officially begun")

end



-- This function initializes the game mode and is called before anyone loads into the game
-- It can be used to pre-initialize any values/tables that will be needed later
function GameMode:InitGameMode()
  GameMode = self
  DebugPrint('[BAREBONES] Starting to load Barebones gamemode...')
  GameMode:_InitGameMode()

  -- Commands can be registered for debugging purposes or as functions that can be called by the custom Scaleform UI
  Convars:RegisterCommand( "command_example", Dynamic_Wrap(GameMode, 'ExampleConsoleCommand'), "A console command example", FCVAR_CHEAT )
  Convars:RegisterCommand( "greed_is_good", Dynamic_Wrap(GameMode, 'GreedIsGood'), "GreedIsGood", FCVAR_CHEAT )

  DebugPrint('[BAREBONES] Done loading Barebones gamemode!\n\n')
end

-- This is an example console command
function GameMode:ExampleConsoleCommand()
  print( '******* Example Console Command ***************' )
  local cmdPlayer = Convars:GetCommandClient()
  if cmdPlayer then
    local playerID = cmdPlayer:GetPlayerID()
    if playerID ~= nil and playerID ~= -1 then
      -- Do something here for the player who called this command
      PlayerResource:SetGold(playerID, 1000)
    end
  end

  print( '*********************************************' )
end

function GameMode:GreedIsGood()
  local cmdPlayer = Convars:GetCommandClient()
  PrintTable(cmdPlayer)
  local hero = cmdPlayer:GetAssignedHero()
  PrintTable(hero)
  if hero then
    PlayerResource:SetGold(hero, 10000)
    PlayerResource:SetLumber(hero, 10000)
  end
end


--========================GAME RULES=========================
--50 GOLD, 100 WOOD; GET GOLD AND WOOD PER 5 SECONDS + RESOURCE STORAGE; THIS IS FOR ent
--****; THIS IS FOR INFERNAL
--100 MAX FOOD
--RESOURCE STORE 4 WOOD + 2 GOLD, BIG RESOURCE STORAGE 6 WOOD + 8 GOLD, GREAT RESOURCE STORAGE 10 GOLD + 10 WOOD
--WISP 5 WOOD /10 SECONDS
--GAME LAST 45 MINS
--IF ent ALL DIED, INFERNAL WINS. IF GAME TIMER IS UP ent WINS.
--INFERNAL CANNOT DIE AND WILL ALWAYS REINCARNATE.
--========================BUILDINGS==========================
--(BASIC+ADVANCED) BASIC TREE 0 GOLD, 0 WOOD 5 SEC CONSTRUCTION, BIG TREE, GIANT TREE (MIGHT NOT NEEDED)
--(BASIC+ADVANCED) ARMORED TREE 20 WOOD 5 SEC CONSTRUCTION (MIGHT NOT NEEDED)
--RESOUCE STORAGE 20 GOLD, 40 WOOD; BIG RESOURCE STORAGE 60 GOLD, 100 WOOD; GREAT RESOURCE STORAGE 100 GOLD, 120 WOOD 15 SEC CONSTRUCTION
--(ADVANCED) SentRY TOWER 20 GOLD, 20 WOOD 15 SEC CONSTRUCTION
--AURA TOWER 40 GOLD, 60 WOOD 15 SEC CONSTRUCTION
--INVISIBLE TREE 30 GOLD, 50 WOOD 15 SEC CONSTRUCTION
--TREE OF LIFE 100 GOLD, 200 WOOD, 60 SEC CONSTRUCTION
--(ADVANCED) ITEM SHOP (MAYBE NOT)
--(ADVANCED) CRYSTAL BALL DETECTOR 100 GOLD, 150 WOOD 20 SEC CONSTRUCTION
--NOOB INFERNAL KILLER 500 GOLD , 650 WOOD 30 SEC CONSTRUCTION; NICE INFERNAL KILLER 750 GOLD, 900 WOOD; GOOD INFERNAL KILLER 2000 GOLD, 1500 WOOD; CRAZY INFERNAL KILLER 4500 GOLD, 3000 WOOD; INSANE INFERNAL KILLER 6500 GOLD, 5000 WOOD
--(ADVANCED) TREE BARRACK 100 GOLD , 200 WOOD 30 SEC CONSTRUCTION, TREE BARACK UPGRADED 100 GOLD, 200 WOOD 30 SEC CONSTRUCTION
--(ADVANCED) UPGRADE CentER 100 GOLD , 100 WOOD, 30 SEC CONSTRUCTION
--(ADVANCED) TUNNEL entRANCE 200 GOLD , 250 WOOD 5 SEC CONSTRUCTION
--========================UNITS==============================
--WISP 60 GOLD, 10 SEC SPAWN
--ADVANCED BUILDING 60 GOLD, 60 WOOD, 15 SEC SPAWN
--======================5 SEC SPAWN==========================
--TREE FIGHTER 20 GOLD, 40 WOOD
--WATER 80 GOLD, 100 WOOD
--TRAPPER 145 GOLD, 60 WOOD
--SIEGE 75 GOLD, 100 WOOD
--TREE GOLEM 450 GOLD, 300 WOOD
--WATER LORD 100 GOLD, 150 WOOD
--SIEGE UPGRADED 100, GOLD 150 WOOD
--HERO (MAYBE NOT)
--OWL (SCOUT) 250 GOLD, 400 WOOD
--=====================INFERNAL UNITS=======================
--BARON 5 MAX / INFERNAL 
--========================ITEMS=============================
--==================WEST EAST SHOP=========================
--SUMMON GOLEM (1 CHARGE ONLY)
--SUMMON MINI-INFERNAL (1 CHARGE ONLY)
--HEALING POTION (1 CHARGE ONLY) (99 IN SHOP)
--EUL (3 CHARGE ONLY) (2 IN SHOP)
--CRYSTALL BALL 
--INVUL POTION (1 CHARGE ONLY)
--INVIS POTION (1 CHARGE ONLY)
--MAGIC IMMUNE POTION (1 CHARGE ONLY)
--=================NORTH SOUTH SHOP=========================
--MAGIC IMMUNE ITEM
--DRUM OF ENDURANE WITHOUT STATS
--SHIELD??? 10% ATTACK + 8 ARMOR
--GEM
--BOOTS
--MANA REGEN ITEM LVL 1 3.5 MANA REGEN
--===================SECRET SHOP=========================
--MANA REGEN ITEM LVL ULTIMATE 20 MANA REGEN
--AXE OF DOOM 100% LIFESTEAL 20% AS, CRIT 10%
--REFRESHER ORB
--AS 200%, DAMAGE TAKEN 100% (USELESS IN MY OPINION)
--NECROMICON LVL 4 (SUMMON 2 MELLE , 2 RANGE)