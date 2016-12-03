TICKET_STARTAMOUNT = 1 
 
function FirstTicketSpawn( ply )
	local tickets = ply:GetPData("Ticket") 
 
	if tickets == nil then 
		ply:SetPData("Ticket", TICKET_STARTAMOUNT) 
		ply:SetTicket( TICKET_STARTAMOUNT ) 
	else
		ply:SetTicket( tickets ) 
	end
 
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawnTickets", FirstTicketSpawn )
 
function fPlayerDisconnectTickets( ply )
	print("Player Disconnect: Tickets saved")
	ply:SaveTicket()
	ply:SaveTicketTXT()
end
hook.Add( "PlayerDisconnected", "playerdisconnectedtickets", fPlayerDisconnectTickets )
 
