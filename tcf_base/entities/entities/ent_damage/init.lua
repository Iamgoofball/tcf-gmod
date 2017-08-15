AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
function ENT:Initialize()
	
	self:SetModel("models/props_trenches/lapland02_128.mdl")
	
	self:SetModelScale(1,1)

	self:PhysicsInit(SOLID_VPHYSICS)

	self:SetMoveType(MOVETYPE_NONE)
	
	self:PhysicsDestroy()
	
	self:DropToFloor()
	
	self:SetAngles(Angle(0,90,0))
	
	self.EntHealth = self.StartingHealth
	self:SetEntHealth(self.EntHealth)
	
end

function ENT:OnTakeDamage(dmg)
	if self.TeamCheck != 0 then
		print(dmg:GetInflictor():GetOwner())
		if dmg:GetInflictor():GetOwner():Team() == self.TeamCheck then
			return
		end
	end
 
	self:TakePhysicsDamage(dmg)
 
	if(self.EntHealth <= 0) then return end 
 
	self.EntHealth = self.EntHealth - dmg:GetDamage() 
	self:SetEntHealth(self.EntHealth)
 
	if(self.EntHealth <= 0) then 
		self:EmitSound(self.SoundToMake)
		
		dmg:GetInflictor():GetOwner():AddExp(Config["barricade-reward"])
		
		self:Remove()
		
	
	end
	
end