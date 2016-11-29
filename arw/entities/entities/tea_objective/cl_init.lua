include("shared.lua")

hook.Add( "PreDrawHalos", "TeaHalos", function()
	local green_shit = {}
	local red_shit = {}
	for fuck, shit in pairs( ents.GetAll() ) do
		if string.find(shit:GetClass(), "tea_objective") then
			if LocalPlayer():Team() == 2 then
				table.insert( red_shit, shit )
			else
				table.insert( green_shit, shit)
			end
		end
	end
	halo.Add( green_shit, Color( 0, 255, 0 ), 0, 0, 1, true, true)
	halo.Add( red_shit, Color( 255, 0, 0 ), 0, 0, 1, true, true)
end )