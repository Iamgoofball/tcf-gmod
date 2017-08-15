local meta = FindMetaTable("Player") --Get the meta table of player
 
function meta:AddTicket(amount)

	local current_tickets = self:GetTicket()
	self:SetTicket( current_tickets + amount )
	
	if amount < 1 then return end
	self:SendLua("GAMEMODE:AddNotify(\"Earned "..amount.." Ticket\", NOTIFY_GENERIC, 5)")
	
end
 
function meta:CanAffordTicket(amount)

	
	if self:GetTicket() >= amount then return true else
	
		self:SendLua("GAMEMODE:AddNotify(\"You do not have enough tickets.\", NOTIFY_GENERIC, 5)")
		
	end
	
end

function meta:SetTicket(amount)
	self:SetNetworkedInt( "Ticket", amount )
	self:SaveMoney()
end
 
function meta:SaveTicket()
	local tickets = self:GetTicket()
	self:SetPData("Ticket", tickets)
end
 
function meta:SaveTicketTXT()
	file.Write(gmod.GetGamemode().Name .."/Ticket/".. string.gsub(self:SteamID(), ":", "_") ..".txt", self:GetTicket())
end
 
function meta:TakeTicket(amount)
   --Add Ticket function here
   self:AddTicket(-amount)
end
 
function meta:GetTicket()
	return self:GetNetworkedInt( "Ticket" )
end
 