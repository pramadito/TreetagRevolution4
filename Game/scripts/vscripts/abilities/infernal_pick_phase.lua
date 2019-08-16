choice = {}

function PickInfernalStr(event)
	local hero = event.caster
	hero.infernalchoice = "infernal_str"
	---print(hero.infernalchoice)
end

function PickInfernalAgi(event)
	local hero = event.caster
	hero.infernalchoice = "infernal_agi"
	--print(hero.infernalchoice)
end

function PickInfernalInt(event)
	local hero = event.caster
	hero.infernalchoice = "infernal_int"
	--print(hero.infernalchoice)
end