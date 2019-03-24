function DestroyTree(event)
	local caster = event.caster
	local caster_team = caster:GetTeam()
	local target = event.target
	
	target:CutDown(caster_team)
end