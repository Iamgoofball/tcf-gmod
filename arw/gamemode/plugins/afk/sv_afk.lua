AFK_TIME = 900


hook.Add("PlayerInitialSpawn", "MakeAFKVar", function(ply)
	ply.NextAFK = CurTime() + AFK_TIME
end)

hook.Add("Think", "HandleAFKPlayers", function()
	for _, ply in pairs (player.GetAll()) do
		if ply:Team() != 1 && !ply:IsAdmin() then
			if (!ply.NextAFK) then
				ply.NextAFK = CurTime() + AFK_TIME
			end
		
			local afktime = ply.NextAFK
			if (CurTime() >= afktime - AFK_TIME / 1.3) and (!ply.Warning) then
				
				ply:SendLua("GAMEMODE:AddNotify(\"Warning: You will be kicked if you do not move.\", NOTIFY_GENERIC, 5)")
				
				ply.Warning = true
			elseif (CurTime() >= afktime) and (ply.Warning) then
				ply.Warning = nil
				ply.NextAFK = nil
				ply:Kick("Kick for AFK, please come back soon!\n ")
			end
		end
	end
end)

hook.Add("KeyPress", "PlayerMoved", function(ply, key)
	ply.NextAFK = CurTime() + AFK_TIME
	ply.Warning = false
end)