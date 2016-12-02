local function HPRegen()
	for k,v in pairs(player.GetAll()) do 
		local hpdif = v:GetMaxHealth()-v:Health()
		if hpdif >= 5 then
			v:SetHealth(v:Health()+5)
		elseif hpdif < 5 then
			v:SetHealth(v:Health()+hpdif)
		end
	end
end

timer.Create("playerHpRegen", Config["regen-delay"], 0, HPRegen)