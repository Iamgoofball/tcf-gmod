util.AddNetworkString( "SetLoadoutWeapon" )
util.AddNetworkString( "SendVote" )

net.Receive( "SetLoadoutWeapon", function( len, ply ) 

	local weptype = net.ReadUInt( 8 ) 
	local entname = net.ReadString( 32 ) 
	
	if weptype == 1 then
	
		ply:SetNWInt("primary", entname)
		
	elseif weptype == 2 then
	 
		ply:SetNWInt("secondary", entname)
		
	end

end )

net.Receive( "SendVote", function( len, ply ) 
	
	if ply:CanAffordTicket(1) then
		
		ply:TakeTicket(1)

		local gametype = net.ReadUInt( 8 ) 
	
		SetGlobalInt( "GameType"..gametype.."votes", GetGlobalInt("GameType"..gametype.."votes") + 1 )
		
		ply:SendLua("GAMEMODE:AddNotify(\"Voted for: "..GameType[gametype].name.."\", NOTIFY_GENERIC, 5)")

		
	end

end )
