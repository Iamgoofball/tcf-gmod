local meta = FindMetaTable("Player") --Get the meta table of player
 
function meta:AddMoney(amount)

	local current_cash = self:GetMoney()
	self:SetMoney( current_cash + amount )
	
	self:SendLua("GAMEMODE:AddNotify(\"+ $"..amount.."\", NOTIFY_GENERIC, 5)")
	
end
 
function meta:SetMoney(amount)
	self:SetNetworkedInt( "Money", amount )
	self:SaveMoney()
end
 
function meta:SaveMoney()
	local cash = self:GetMoney()
	self:SetPData("Money", cash)
end
 
function meta:SaveMoneyTXT()
	file.Write(gmod.GetGamemode().Name .."/Money/".. string.gsub(self:SteamID(), ":", "_") ..".txt", self:GetMoney())
end
 
function meta:TakeMoney(amount)
   --Add money function here
   self:AddMoney(-amount)
end
 
function meta:GetMoney()
	return self:GetNetworkedInt( "Money" )
end
 