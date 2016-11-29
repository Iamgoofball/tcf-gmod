include("shared.lua")

function ENT:Initialize()
	print("made a corpse")
end

hook.Add( "PreDrawHalos", "AddLootHalos", function()
	local fuck_shit_stack = {}
	for fuck, shit in pairs( ents.GetAll() ) do
		if string.find(shit:GetClass(), "corpse_lootable") then
			if shit:GetMyTeam() != LocalPlayer():Team() then
				if shit:GetLooted() != true then
					table.insert( fuck_shit_stack, shit )
				end
			end
		end
	end
	halo.Add( fuck_shit_stack, Color( 0, 255, 0 ), 0, 0, 1, true, false )
end )