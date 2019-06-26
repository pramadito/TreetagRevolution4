--[[ Tree tracking ]]

destroyed_trees = {}
--========================ENT_ABILITIES=========================

function DestroyTree(event)
	local caster = event.caster
	local caster_team = caster:GetTeam()
	local target = event.target

	if not IsServer() then return end
	target:CutDown(caster_team)
end

function DestroyTreesAoE(event)
	local caster = event.caster
	local caster_team = caster:GetTeam()
	local target_point = event.target_points[1]
	local radius = event.Radius

	GridNav:DestroyTreesAroundPoint(target_point, radius, false)
end

function RegrowTreeAoE_Small(event)
	BuildingHelper:RegrowTreesAOE(event)
	
end

--========== NEED TIMER ==================
function GoldMineCreate(keys)
	local caster = keys.caster
	local hero = caster:GetOwner()
	local amountPerSecond = GetUnitKV(caster:GetUnitName()).GoldAmount * GameRules.MapSpeed
	local maxGold = GetUnitKV(caster:GetUnitName(),"MaxGold") or 2000000
	hero.goldPerSecond = hero.goldPerSecond + amountPerSecond
	local secondsToLive = maxGold/amountPerSecond;
	Timers:CreateTimer(secondsToLive, 
		function()
			caster:ForceKill(false)
		end)
	local dataTable = { entityIndex = caster:GetEntityIndex(), amount = amountPerSecond, interval = 1 }
	local player = hero:GetPlayerOwner()
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "gold_gain_start", dataTable)
	end
end

function GoldMineDestroy(keys)
	local caster = keys.caster
	local hero = caster:GetOwner()
	local amountPerSecond = GetUnitKV(caster:GetUnitName()).GoldAmount * GameRules.MapSpeed
	hero.goldPerSecond = hero.goldPerSecond - amountPerSecond
	local dataTable = { entityIndex = caster:GetEntityIndex() }
	local player = hero:GetPlayerOwner()
	if player then
		CustomGameEventManager:Send_ServerToPlayer(player, "gold_gain_stop", dataTable)
	end
end

function GainLumber()
	--body
end
--=========================================

function RevealArea(event)
	local caster = event.caster
	local point = event.target_points[1]
	local visionRadius = string.match(GetMapName(),"treetag_evolution_reborn_103_made_by_pramadito") and event.Radius*1.25 or event.Radius
	local visionDuration = event.Duration
	AddFOWViewer(caster:GetTeamNumber(), point, visionRadius, visionDuration, false)
	local units = FindUnitsInRadius(caster:GetTeamNumber(), point , nil, visionRadius , DOTA_UNIT_TARGET_TEAM_BOTH, DOTA_UNIT_TARGET_ALL , DOTA_UNIT_TARGET_FLAG_NONE, 0 , false)
	local timeElapsed = 0
	Timers:CreateTimer(0.03,function()
		for _,unit in pairs(units) do
			if unit:HasModifier("modifier_invisible") then
				unit:RemoveModifierByName("modifier_invisible")
			end
		end
		timeElapsed = timeElapsed + 0.03
		if timeElapsed < visionDuration then
			return 0.03
		end
	end)
end

function SendErrorMessage( pID, string )
    Notifications:ClearBottom(pID)
    Notifications:Bottom(pID, {text=string, style={color='#E62020'}, duration=2})
    EmitSoundOnClient("General.Cancel", PlayerResource:GetPlayer(pID))
end


function Infernal_Shockwave()
	--body
	--use invoker meteor from infernal's hand
end

function Infernal_Ward()
	--body
end

function Infernal_PowerWard()
	--body
end

function Infernal_Immolation()
	--body
end

function DestroyTree_WhileWalking(event)
	-- body
end



