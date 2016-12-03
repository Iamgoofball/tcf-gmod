AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	self:SetModel("models/props/de_inferno/wine_barrel.mdl")
	self:SetModelScale(1,1)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:PhysicsDestroy()
	self:DropToFloor()
	self:SetAngles(Angle(0,90,0))
	self.EntHealth = self.StartingHealth
	self:SetEntHealth(self.EntHealth)
end