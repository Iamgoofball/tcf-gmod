local GodMode = {
	Settings = {
		Length = 5
	}
}


function GodMode:PlayerSpawn(ply)
	if !IsValid(ply) then return end
	
	ply:GodEnable()
	ply.GodEnabled = true
	
	timer.Simple(self.Settings.Length, function()
		if !IsValid(ply) then return end
		ply:GodDisable()
		ply.GodEnabled = false
	end)
end
hook.Add("PlayerSpawn", "GE.PlayerSpawn", function(...) GodMode:PlayerSpawn(...) end)