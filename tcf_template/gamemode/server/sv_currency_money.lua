MONEY_STARTAMOUNT = 1000 
 
function FirstSpawn( ply )
	local cash = ply:GetPData("Money") 
 
	if cash == nil then 
		ply:SetPData("Money", MONEY_STARTAMOUNT) 
		ply:SetMoney( MONEY_STARTAMOUNT ) 
	else
		ply:SetMoney( cash ) 
	end
 
end
hook.Add( "PlayerInitialSpawn", "playerInitialSpawnCurrency", FirstSpawn )
 
function fPlayerDisconnectCurrency( ply )
	print("Player Disconnect: Money saved")
	ply:SaveMoney()
	ply:SaveMoneyTXT()
end
hook.Add( "PlayerDisconnected", "playerdisconnectedcurrency", fPlayerDisconnectCurrency )
 
