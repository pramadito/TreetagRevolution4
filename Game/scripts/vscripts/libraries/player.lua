--THIS CODE IS CREATED BY sSAM (or his team) THE CREATOR OF TROLL AND ELVES 2 NOT ME
--THIS CODE IS COPIED BY ME TO IMPLEMENT CUSTOM PLAYER RESOURCE


Player = Player or {}

require('libraries/team')

if GameRules.disconnectedHeroSelects == nil then
  GameRules.disconnectedHeroSelects = {}
end

-- function CDOTA_PlayerResource:SetSelectedHero(playerID, heroName)
--     local player = PlayerResource:GetPlayer(playerID)
--   if player == nil then
--         GameRules.disconnectedHeroSelects[playerID] = heroName
--         return
--   end
--     player:SetSelectedHero(heroName)
-- end

function CDOTA_PlayerResource:SetGold(hero,gold)
    local playerID = hero:GetPlayerOwnerID()
    gold = math.min(gold, 1000000)
    GameRules.gold[playerID] = gold
  CustomGameEventManager:Send_ServerToTeam(hero:GetTeam(), "player_custom_gold_changed", {
    playerID = playerID,
    gold = PlayerResource:GetGold(playerID)
  })
end

function CDOTA_PlayerResource:ModifyGold(hero,gold,noGain)
    if GameRules.test then
    PlayerResource:SetGold(hero, 1000000)
    return
    end
    noGain = noGain or false
    local pID = hero:GetPlayerOwnerID()
    PlayerResource:SetGold(hero, (GameRules.gold[pID] or 0) + gold)
    if gold > 0 and not noGain then
        PlayerResource:ModifyGoldGained(pID,gold)
    end
end

function CDOTA_PlayerResource:GetGold(pID)
  return math.floor(GameRules.gold[pID] or 0)
end


function CDOTA_PlayerResource:SetLumber(hero, lumber)
    local playerID = hero:GetPlayerOwnerID()
    lumber = math.min(lumber, 1000000)
  GameRules.lumber[playerID] = lumber
  CustomGameEventManager:Send_ServerToTeam(hero:GetTeam(), "player_lumber_changed", {
    playerID = playerID,
    lumber = PlayerResource:GetLumber(playerID)
  })
end

function CDOTA_PlayerResource:ModifyLumber(hero,lumber,noGain)
    if GameRules.test then
    PlayerResource:SetLumber(hero,1000000)
    return
    end
    noGain = noGain or false
    local pID = hero:GetPlayerOwnerID()
    PlayerResource:SetLumber(hero, (GameRules.lumber[pID] or 0) + lumber)
    if lumber > 0 and not noGain then
      PlayerResource:ModifyLumberGained(pID, lumber)
    end
end

function CDOTA_PlayerResource:GetLumber(pID)
  return math.floor(GameRules.lumber[pID]) or 0
end


function CDOTA_PlayerResource:ModifyGoldGained(pID,amount)
  GameRules.goldGained[pID] = PlayerResource:GetGoldGained(pID) + amount
end

function CDOTA_PlayerResource:GetGoldGained(pID)
  return GameRules.goldGained[pID] or 0
end

function CDOTA_PlayerResource:ModifyGoldGiven(pID,amount)
  GameRules.goldGiven[pID] = PlayerResource:GetGoldGiven(pID) + amount
end

function CDOTA_PlayerResource:GetGoldGiven(pID)
  return GameRules.goldGiven[pID] or 0
end



function CDOTA_PlayerResource:ModifyLumberGained(pID,amount)
  GameRules.lumberGained[pID] =PlayerResource:GetLumberGained(pID) + amount
end

function CDOTA_PlayerResource:GetLumberGained(pID)
  return GameRules.lumberGained[pID] or 0
end

function CDOTA_PlayerResource:ModifyLumberGiven(pID,amount)
  GameRules.lumberGiven[pID] = PlayerResource:GetLumberGiven(pID) + amount
end

function CDOTA_PlayerResource:GetLumberGiven(pID)
  return GameRules.lumberGiven[pID] or 0
end

function CDOTA_PlayerResource:GetAllStats(pID)
  local sum = 0
  sum = sum + PlayerResource:GetGoldGained(pID) + PlayerResource:GetGoldGiven(pID) + PlayerResource:GetLumberGiven(pID) + PlayerResource:GetLumberGained(pID)
  return sum
end

function CDOTA_PlayerResource:ModifyFood(hero,food)
    food = string.match(food,"[-]?%d+") or 0
    local playerID = hero:GetPlayerOwnerID()
    hero.food = hero.food + food
  CustomGameEventManager:Send_ServerToTeam(hero:GetTeam(), "player_food_changed", {
    playerID = playerID,
    food = math.floor(hero.food),
    maxFood = GameRules.maxFood
  })
end


-- function CDOTA_PlayerResource:GetType(pID)
--   local heroName = PlayerResource:GetSelectedHeroName(pID)
--     return string.match(heroName,TROLL_HERO) and "troll"
--             or string.match(heroName,ANGEL_HERO) and "angel"
--             or string.match(heroName,WOLF_HERO) and "wolf"
--             or "elf"
-- end


function ModifyStartedConstructionBuildingCount(hero, unitName, number)
    local buildingCounts = hero.buildings[unitName]
    buildingCounts.startedConstructionCount = buildingCounts.startedConstructionCount + number
end

function ModifyCompletedConstructionBuildingCount(hero, unitName, number)
  local buildingCounts = hero.buildings[unitName]
    buildingCounts.completedConstructionCount = buildingCounts.completedConstructionCount + number
end


-- function CDOTA_BaseNPC:IsElf()
--     return self:GetUnitName() == ELF_HERO
-- end
-- function CDOTA_BaseNPC:IsTroll()
--     return self:GetUnitName() == TROLL_HERO
-- end
-- function CDOTA_BaseNPC:IsAngel()
--     return self:GetUnitName() == ANGEL_HERO
-- end
-- function CDOTA_BaseNPC:IsWolf()
--     return self:GetUnitName() == WOLF_HERO
-- end

function CDOTA_PlayerResource:IsEnt(hero)
    return string.match(hero:GetUnitName(),"wisp")
end
function CDOTA_PlayerResource:IsInfernal(hero)
    return string.match(hero:GetUnitName(),"warlock_golem")
end
function CDOTA_PlayerResource:IsDeadEnt(hero)
    return string.match(hero:GetUnitName(),"black_treant")
end

