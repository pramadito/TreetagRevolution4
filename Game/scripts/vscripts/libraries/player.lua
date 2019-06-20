Player = Player or {}

require('libraries/team')

function CDOTA_PlayerResource:SetGold(hero,gold)
    local pID = hero:GetPlayerOwnerID()
    gold = math.floor(string.match(gold,"[-]?%d+")) or 0
    gold = gold <= 1000000 and gold or 1000000
    GameRules.gold[pID] = gold
    CustomNetTables:SetTableValue("resources", tostring(pID), { gold = PlayerResource:GetGold(pID),lumber = PlayerResource:GetLumber(pID) })
end

function CDOTA_PlayerResource:ModifyGold(hero,gold,noGain)
    noGain = noGain or false
    local pID = hero:GetPlayerOwnerID()
    gold = math.floor(string.match(gold,"[-]?%d+")) or 0
    PlayerResource:SetGold(hero,math.floor(PlayerResource:GetGold(pID) + gold))
    if gold > 0 and not noGain then
      PlayerResource:ModifyGoldGained(pID,gold)
    end
    if GameRules.test then
      PlayerResource:SetGold(hero,1000000)
    end
end

function CDOTA_PlayerResource:GetGold(pID)
  return math.floor(GameRules.gold[pID] or 0)
end

function CDOTA_PlayerResource:SetLumber(hero,lumber)
    local pID = hero:GetPlayerOwnerID()
		lumber = lumber or 0
    lumber = lumber <= 1000000 and lumber or 1000000
    GameRules.lumber[pID] = lumber
    CustomNetTables:SetTableValue("resources", tostring(pID), { gold = PlayerResource:GetGold(pID),lumber = PlayerResource:GetLumber(pID) })
end

function CDOTA_PlayerResource:ModifyLumber(hero,lumber,noGain)
    noGain = noGain or false
    local pID = hero:GetPlayerOwnerID()
    lumber = lumber or 0
    PlayerResource:SetLumber(hero,PlayerResource:GetLumber(pID) + lumber)
    if lumber > 0 and not noGain then
      PlayerResource:ModifyLumberGained(pID,lumber)
    end
    if GameRules.test then
      PlayerResource:SetLumber(hero,1000000)
    end
end

function CDOTA_PlayerResource:GetLumber(pID)
  return GameRules.lumber[pID] or 0
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
    local playerID = hero:GetMainControllingPlayer()
    hero.food = hero.food + food
    local player = hero:GetPlayerOwner()
    if player then
      CustomGameEventManager:Send_ServerToPlayer(player, "player_food_changed", { food = math.floor(hero.food) , maxFood = GameRules.max_food })
    end
end


-- function CDOTA_PlayerResource:GetType(pID)
-- 	local heroName = PlayerResource:GetSelectedHeroName(pID)
-- 	return string.match(heroName,"troll") and "troll" or string.match(heroName,"crystal") and "angel" or string.match(heroName,"lycan") and "wolf" or "elf"
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

