AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/TrapPropeller_Engine.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()
	self:SetUseType(SIMPLE_USE)
	self:SetLooted(false)
end

function ENT:Use(activator, caller)
	if self:GetLooted() == false then
		if self:GetMyTeam() != caller:Team() then
			caller:AddMoney(Config["loot-reward"])
			self:SetLooted(true)
		end
	end
end