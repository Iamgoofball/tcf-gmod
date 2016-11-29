ENT.Type = "anim"
ENT.Category = "Damageable"
ENT.PrintName = "Damageable Entity Base"
ENT.Author = "Senpai"
ENT.StartingHealth = 200
ENT.TeamCheck = 0
ENT.SoundToMake = "physics/metal/metal_chainlink_impact_soft1.wav"
ENT.UsesTeamIcons = false

function ENT:SetupDataTables()
	
	self:NetworkVar("Float", 0, "EntHealth")

end