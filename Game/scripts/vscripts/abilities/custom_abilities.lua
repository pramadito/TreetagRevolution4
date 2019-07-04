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

function ProduceLumberandGoldCreate(event)
	local caster = event.caster
	Timers:CreateTimer({
    	endTime = 3, -- when this timer should first execute, you can omit this if you want it to run first on the next frame
    	callback = function()
		local hero = caster:GetOwner()
		if not hero then
			return
		end
		local goldamountperfivesecond = GetUnitKV(caster:GetUnitName()).GoldAmount
		local lumberamountperfivesecond = GetUnitKV(caster:GetUnitName()).LumberAmount
		hero.goldperfivesecond = hero.goldperfivesecond + goldamountperfivesecond
		hero.lumberperfivesecond = hero.lumberperfivesecond + lumberamountperfivesecond
    end
  	})
end

function ProduceLumberandGoldDestroy(event)
	local caster = event.caster
	local hero = caster:GetOwner()
	local goldamountperfivesecond = GetUnitKV(caster:GetUnitName()).GoldAmount
	local lumberamountperfivesecond = GetUnitKV(caster:GetUnitName()).LumberAmount
	hero.goldperfivesecond = hero.goldperfivesecond - goldamountperfivesecond
	hero.lumberperfivesecond = hero.lumberperfivesecond - lumberamountperfivesecond
end

function WispGainLumber()
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



