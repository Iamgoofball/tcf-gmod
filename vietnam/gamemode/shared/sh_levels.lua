local meta = FindMetaTable("Player") --Get the meta table of player


function meta:AddExp(amount)
    local total = self:GetExp() + amount
    local levels = math.floor(total/1000)
    
    
    if levels > 0 then
        for i=1, levels do 
			self:SetNWInt("Level", self:GetNWInt("Level") + 1) 
		end -- calls the "level up" function in sequence so the player doesn't miss important levels
        self:SetExp(total%1000)
		-- notification of level up here
		
    else
        self:SetExp(total)
		self:SendLua("GAMEMODE:AddNotify(\"+"..amount.." Exp!\", NOTIFY_GENERIC, 5)")
    end
end
 
function meta:SetExp(amount)
	self:SetNetworkedInt( "Exp", amount )
	self:SaveExp()
end

function meta:SaveExp()
	local wholeexp = self:GetExp()
	local level = self:GetLevel()
	self:SetPData("Exp", wholeexp)
	self:SetPData("Level", level)
end
 
function meta:SaveExpTXT()
	file.Write(gmod.GetGamemode().Name .."/Game_Exp/".. string.gsub(self:SteamID(), ":", "_") ..".txt", self:GetExp())
end
 
function meta:TakeExp(amount)
   --Add Game_Exp function here
   self:AddExp(-amount)
end
 
function meta:GetExp()
	return self:GetNetworkedInt( "Exp" )
end

function meta:GetLevel()
	return self:GetNetworkedInt( "Level" )
end

function meta:SetLevel(amount)
	self:SetNetworkedInt( "Level", amount )
	self:SaveExp()
end