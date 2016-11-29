ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.Category = "Corpses"
ENT.PrintName = "Lootable Corpse"
ENT.Author = "Iamgoofball"

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Looted")
	self:NetworkVar("Int", 0, "MyTeam")
end