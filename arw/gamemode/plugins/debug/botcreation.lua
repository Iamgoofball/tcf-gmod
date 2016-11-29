concommand.Add( "createbot", function( ply, cmd, args )
	RunConsoleCommand("bot")
	--[[for k, v in pairs(player.GetAll()) do
		if v:IsBot() then
			v:SetTeam(3)
		end]]
	end
end )