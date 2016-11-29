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

function ENT:Touch( toucher )

	if toucher:IsValid() && toucher:IsPlayer() then
	
		toucher:SetVelocity(Vector(math.random(1,50) ,math.random(1,500) ,math.random(0,-500) ))
		
		if(toucher:Health() <= 0) then return end 
 
		toucher:SetHealth(toucher:Health() - 1)
		
		toucher:EmitSound("physics/metal/metal_chainlink_impact_soft"..math.random(1,3)..".wav")
	 
		if(toucher:Health() <= 0) then 
		
			toucher:Kill()
			
			
		end
		
	end
	
end