LEVEL_STARTAMOUNT = 1 
 
function FirstSpawnLevel( ply )
	local wholeexp = ply:GetPData("Exp") --Get the saved Game_Exp amount
	local level = ply:GetPData("Level") --Get the saved Game_Exp amount
 
	if wholeexp == nil then --If it doesn't exist supply the player with the starting Game_Exp amount
		ply:SetPData("Exp", 0) --Save it
		ply:SetExp( 0 ) --Set it to the networked ints that can be called from the client too
	else
		ply:SetExp( wholeexp ) --If not, set the networked ints to what we last saved
	end
	
	if level == nil then --If it doesn't exist supply the player with the starting Game_Exp amount
		ply:SetPData("Level", LEVEL_STARTAMOUNT) --Save it
		ply:SetNWInt( "Level", LEVEL_STARTAMOUNT )
		ply:SaveExp()
		--ply:SetExp( Game_Exp_STARTAMOUNT ) --Set it to the networked ints that can be called from the client too
	else
		ply:SetNWInt( "Level", level )
		ply:SaveExp()
	end	

	ply:SetNWInt( "Level", level ) --If not, set the networked ints to what we last saved
 
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawnLevel", FirstSpawnLevel )
 
function fPlayerDisconnectLevel( ply )
	print("Player Disconnect: Level and Exp saved")
	ply:SaveExp()
	ply:SaveExpTXT()
end
hook.Add( "PlayerDisconnected", "playerdisconnectedlevel", fPlayerDisconnectLevel )
